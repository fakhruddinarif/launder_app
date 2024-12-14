import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:launder_app/utils/local_storage/auth_local_storage.dart';

class LaunderHttpClient {
  static String _baseUrl = 'http://10.0.2.2:3000/api';

  static Future<http.Response> get(String endpoint) async {
    final headers = await _getHeaders();
    return http.get(Uri.parse('$_baseUrl/$endpoint'), headers: headers);
  }

  static Future<http.Response> post(String endpoint, dynamic body) async {
    final headers = await _getHeaders();
    return http.post(Uri.parse('$_baseUrl/$endpoint'), headers: headers, body: json.encode(body));
  }

  static Future<http.Response> put(String endpoint, dynamic body) async {
    final headers = await _getHeaders();
    return http.put(Uri.parse('$_baseUrl/$endpoint'), headers: headers, body: json.encode(body));
  }

  static Future<http.Response> patch(String endpoint, dynamic body) async {
    final headers = await _getHeaders();
    return http.patch(Uri.parse('$_baseUrl/$endpoint'), headers: headers, body: json.encode(body));
  }

  static Future<http.Response> delete(String endpoint) async {
    final headers = await _getHeaders();
    return http.delete(Uri.parse('$_baseUrl/$endpoint'), headers: headers);
  }

  static Future<Map<String, String>> _getHeaders() async {
    final token = await AuthLocalStorage().get();
    return {
      'Content-Type': 'application/json',
      if (token?.accessToken != null) 'Authorization': '${token?.tokenType} ${token?.accessToken}',
    };
  }
}