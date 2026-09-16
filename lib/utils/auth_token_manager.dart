import 'dart:async';

import 'package:flutter/foundation.dart';

typedef TokenRefreshCall = Future<Map<String, dynamic>> Function();

/// In-memory holder for the current JWT bearer token, read synchronously by
/// [ApiClient] on every request so a token rotation is picked up everywhere
/// without touching individual repositories.
///
/// Per backend guidance, the app does not log the user out on a fixed
/// 3600s timer. Instead it silently re-calls the login endpoint every 59
/// minutes (1 minute before the server's 60-minute expiry) using the
/// credentials captured at the real login, and swaps in the new token.
/// The user is only forced out if that silent refresh itself fails.
class AuthTokenManager {
  AuthTokenManager._internal();

  static final AuthTokenManager _instance = AuthTokenManager._internal();

  factory AuthTokenManager() => _instance;

  static const _refreshInterval = Duration(minutes: 59);

  String? _token;

  /// The `SESSION` cookie verifyLogin also sets (Set-Cookie). Some
  /// endpoints - confirmed on saveLogoutHistoryMobile - still depend on
  /// this server-side session on top of the JWT, likely left over from
  /// before bearer-token auth was added. Sent alongside the token on
  /// every request since it's harmless where it isn't needed.
  String? _sessionCookie;
  Timer? _refreshTimer;
  TokenRefreshCall? _refreshCall;
  DateTime? _lastRefreshAt;

  /// Invoked when the token can no longer be refreshed (bad credentials,
  /// network failure, server rejection) or a 401 was received - the app
  /// should treat this as a forced logout.
  VoidCallback? onSessionExpired;

  String? get token => _token;

  String? get sessionCookie => _sessionCookie;

  bool get isActive => _token != null;

  /// Convenience for call sites that build their own [http.BaseRequest]
  /// (multipart uploads, raw downloads) instead of going through
  /// [ApiClient.get]/[ApiClient.post].
  Map<String, String> get authHeaders {
    if (_token == null) return const {};
    return {
      'Authorization': 'Bearer $_token',
      if (_sessionCookie != null) 'Cookie': _sessionCookie!,
    };
  }

  /// Called from LoginRepository.login() right after a successful
  /// verifyLogin response - covers manual login, the silent 59-minute
  /// refresh, and the splash-screen silent re-login, since they all go
  /// through that same repository method.
  void setSessionCookie(String? rawSetCookieHeader) {
    if (rawSetCookieHeader == null) return;
    // Strip cookie attributes (Path, HttpOnly, SameSite, ...) - only the
    // "name=value" pair belongs in a Cookie request header.
    _sessionCookie = rawSetCookieHeader.split(';').first.trim();
  }

  /// Call once right after a successful login. [refreshCall] should re-run
  /// the same login request - the caller already has the credentials in
  /// scope - and return its decoded JSON response.
  void activate(String token, TokenRefreshCall refreshCall) {
    _token = token;
    _refreshCall = refreshCall;
    _lastRefreshAt = DateTime.now();
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(_refreshInterval, (_) => _refresh());
  }

  /// Covers the gap where the periodic [Timer] pauses while the app is
  /// backgrounded: call this on app resume to catch up immediately if the
  /// 59-minute mark was missed while suspended.
  Future<void> refreshIfDue() async {
    final lastRefreshAt = _lastRefreshAt;
    if (_token == null || lastRefreshAt == null) return;
    if (DateTime.now().difference(lastRefreshAt) >= _refreshInterval) {
      await _refresh();
    }
  }

  Future<void> _refresh() async {
    final refreshCall = _refreshCall;
    if (refreshCall == null) return;

    try {
      final data = await refreshCall();
      final newToken = data['token'] as String?;
      if (data['status'] == 'Success' && newToken != null) {
        _token = newToken;
        _lastRefreshAt = DateTime.now();
        debugPrint('AuthTokenManager: token refreshed silently');
      } else {
        debugPrint('AuthTokenManager: refresh rejected - ${data['status']}');
        _forceLogout();
      }
    } catch (e) {
      debugPrint('AuthTokenManager: silent refresh failed - $e');
      _forceLogout();
    }
  }

  void _forceLogout() {
    clear();
    onSessionExpired?.call();
  }

  /// Call on explicit logout, and internally on a 401 from any API.
  void clear() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
    _token = null;
    _sessionCookie = null;
    _refreshCall = null;
    _lastRefreshAt = null;
  }
}
