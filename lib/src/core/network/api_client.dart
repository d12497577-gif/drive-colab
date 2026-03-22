import 'package:dio/dio.dart';

import 'dio_client.dart';

class ApiClient {
  ApiClient({Dio? dio}) : _dio = dio ?? DioClient.create();

  final Dio _dio;

  Future<Map<String, dynamic>> get(String url, {Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.get(url, queryParameters: queryParameters);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(String url, {Map<String, dynamic>? data}) async {
    final response = await _dio.post(url, data: data);
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      throw Exception('Unexpected response format');
    }
    throw Exception('HTTP error: ${response.statusCode}');
  }
}
