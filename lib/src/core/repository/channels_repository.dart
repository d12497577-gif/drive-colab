import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/channel_model.dart';
import '../network/api_client.dart';
import '../network/api_routes.dart';

@Injectable()
class ChannelsRepository {
  final ApiClient _apiClient;

  ChannelsRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<ChannelModel>> getChannels() async {
    try {
      final response = await _apiClient.get(ApiRoutes.channels);
      final data = response['data'] as List<dynamic>;
      return data
          .map((json) => ChannelModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load channels: $e');
    }
  }

  Future<List<ChannelModel>> getChannelsByCategory(int categoryId) async {
    try {
      final response = await _apiClient.get(ApiRoutes.channels);
      final data = response['data'] as List<dynamic>;
      final channels = data
          .map((json) => ChannelModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return channels
          .where((channel) => channel.categoryId == categoryId)
          .toList();
    } catch (e) {
      throw Exception('Failed to load channels: $e');
    }
  }
}
