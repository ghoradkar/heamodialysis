import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:heamodialysis/utils/auth_token_manager.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

/// Thrown by [ApiClient]-based repository calls when the server responds
/// with a non-200 status code, carrying the status code so callers can
/// keep their existing per-status-code handling (e.g. treating 401
/// differently from other failures).
class ApiException implements Exception {
  final int statusCode;
  final String body;

  ApiException(this.statusCode, this.body);

  @override
  String toString() => 'ApiException($statusCode): $body';
}

/// Shared HTTP client for feature repositories. Centralizes the
/// SSL-bypass client, default JSON headers, and request/response
/// debug logging that used to be duplicated in every controller.
///
/// This does not change request behavior - it is the same
/// IOClient(ByPassCert().httpClient) every controller already used for
/// its JSON get/post calls.
class ApiClient {
  ApiClient._internal();

  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  final IOClient _client = IOClient(ByPassCert().httpClient);

  static const Map<String, String> jsonHeaders = {
    "Content-Type": "application/json",
  };

  Future<http.Response> get(String url, {Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    debugPrint('GET $uri');
    final response = await _client.get(uri, headers: _withAuth(headers));
    debugPrint('response.body : ${response.body}');
    _handleUnauthorized(response);
    return response;
  }

  Future<http.Response> post(String url,
      {Object? body, Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    final String? encodedBody =
        body == null ? null : (body is String ? body : json.encode(body));
    debugPrint('POST $uri');
    if (encodedBody != null) debugPrint(encodedBody);
    final response = await _client.post(uri,
        headers: _withAuth(headers), body: encodedBody);
    debugPrint('response.body : ${response.body}');
    _handleUnauthorized(response);
    return response;
  }

  /// Merges in `Authorization: Bearer <token>` when a token is active, so
  /// every repository picks up the current (and any later rotated) token
  /// without needing to pass it explicitly.
  Map<String, String> _withAuth(Map<String, String>? headers) {
    return {...(headers ?? jsonHeaders), ...AuthTokenManager().authHeaders};
  }

  /// Safety net for a token that expired or was rejected without the
  /// silent 59-minute refresh having caught it yet.
  void _handleUnauthorized(http.Response response) {
    if (response.statusCode == 401 && AuthTokenManager().isActive) {
      AuthTokenManager().clear();
      AuthTokenManager().onSessionExpired?.call();
    }
  }

  /// Passthrough for callers that need to build their own [http.BaseRequest]
  /// (e.g. a GET with a body) but still want the same SSL-bypass client,
  /// auth header, and 401 handling every other ApiClient call gets.
  Future<http.StreamedResponse> sendRaw(http.BaseRequest request) async {
    request.headers.addAll(AuthTokenManager().authHeaders);
    final response = await _client.send(request);
    if (response.statusCode == 401 && AuthTokenManager().isActive) {
      AuthTokenManager().clear();
      AuthTokenManager().onSessionExpired?.call();
    }
    return response;
  }
}
