import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/movie_model.dart';
import '../network/api_client.dart';
import '../network/api_routes.dart';

@Injectable()
class MoviesRepository {
  final ApiClient _apiClient;

  MoviesRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<MovieModel>> getMovies() async {
    try {
      final response = await _apiClient.get(ApiRoutes.movies);
      final data = response['data'] as List<dynamic>;
      return data
          .map((json) => MovieModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

  Future<List<MovieModel>> getMoviesByCategory(int categoryId) async {
    try {
      final response = await _apiClient.get(ApiRoutes.movies);
      final data = response['data'] as List<dynamic>;
      final movies = data
          .map((json) => MovieModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return movies.where((movie) => movie.categoryId == categoryId).toList();
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }
}
