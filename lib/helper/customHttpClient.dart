import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomHttpClient {
  final http.Client client;

  CustomHttpClient(this.client);

  // POST request
  Future<http.Response> post(Uri url, {Map<String, String>? headers, Object? body}) async {
    _logRequest('POST', url, headers, body);

    final response = await client.post(url, headers: headers, body: body);

    _logResponse(response);

    return response;
  }

  // GET request
  Future<http.Response> get(Uri url, {Map<String, String>? headers }) async {
    _logRequest('GET', url, headers, null);

    final response = await client.get(url, headers: headers);

    _logResponse(response);

    return response;
  }

  // PUT request
  Future<http.Response> put(Uri url, {Map<String, String>? headers, Object? body}) async {
    _logRequest('PUT', url, headers, body);

    final response = await client.put(url, headers: headers, body: body);

    _logResponse(response);

    return response;
  }

  // Common method to log requests
  void _logRequest(String method, Uri url, Map<String, String>? headers, Object? body) {

    if (body != null) ;
  }

  // Common method to log responses
  void _logResponse(http.Response response) {

  }
}
