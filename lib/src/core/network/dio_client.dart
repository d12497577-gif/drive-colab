import 'package:dio/dio.dart';

import 'api_routes.dart';

class DioClient {
  DioClient._();

  static Dio create({BaseOptions? options}) {
    final dio = Dio(options ?? BaseOptions(baseUrl: ApiRoutes.baseUrl));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add any global headers here
          options.headers['Accept'] = 'application/json';
          return handler.next(options);
        },
        onError: (error, handler) {
          // Add global error handling if needed
          return handler.next(error);
        },
      ),
    );

    return dio;
  }
}
