class ApiRoutes {
  // TODO: Replace with the actual base URL for your deployed API.
  // Example: https://your-domain.com/api.php
  static const String baseUrl = 'http://controltvpro.xo.je/?route=api';

  static const String settings = '$baseUrl&endpoint=settings';
  static const String categories = '$baseUrl&endpoint=categories';
  static const String channels = '$baseUrl&endpoint=channels';
  static const String movies = '$baseUrl&endpoint=movies';
  static const String anime = '$baseUrl&endpoint=anime';
  static const String ads = '$baseUrl&endpoint=ads';
  static const String checkUpdate = '$baseUrl&endpoint=check-update';
}
