import 'dart:developer' as developer;

class Logger {
  static void d(String message, {String? tag}) {
    developer.log(message, name: tag ?? 'AbdouTV');
  }

  static void e(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    developer.log(message, name: tag ?? 'AbdouTV', error: error, stackTrace: stackTrace);
  }
}
