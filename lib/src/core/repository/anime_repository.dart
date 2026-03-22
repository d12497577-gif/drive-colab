import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/anime_model.dart';
import '../network/api_client.dart';
import '../network/api_routes.dart';

@Injectable()
class AnimeRepository {
  final ApiClient _apiClient;

  AnimeRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<AnimeModel>> getAnime() async {
    try {
      final response = await _apiClient.get(ApiRoutes.anime);
      final data = response['data'] as List<dynamic>;
      return data
          .map((json) => AnimeModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load anime: $e');
    }
  }

  Future<List<AnimeModel>> getAnimeByCategory(int categoryId) async {
    try {
      final response = await _apiClient.get(ApiRoutes.anime);
      final data = response['data'] as List<dynamic>;
      final anime = data
          .map((json) => AnimeModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return anime.where((anime) => anime.categoryId == categoryId).toList();
    } catch (e) {
      throw Exception('Failed to load anime: $e');
    }
  }
}
