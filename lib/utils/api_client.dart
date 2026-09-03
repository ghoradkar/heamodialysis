import 'dart:convert';

import 'package:flutter/foundation.dart';
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
    final response = await _client.get(uri, headers: headers ?? jsonHeaders);
    debugPrint('response.body : ${response.body}');
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
        headers: headers ?? jsonHeaders, body: encodedBody);
    debugPrint('response.body : ${response.body}');
    return response;
  }

  /// Passthrough for callers that need to build their own [http.BaseRequest]
  /// (e.g. a GET with a body) but still want the same SSL-bypass client
  /// every other ApiClient call uses.
  Future<http.StreamedResponse> sendRaw(http.BaseRequest request) {
    return _client.send(request);
  }
}
