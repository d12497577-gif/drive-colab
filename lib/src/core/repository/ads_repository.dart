import '../models/ad_config_model.dart';
import '../network/api_client.dart';
import '../network/api_routes.dart';

class AdsRepository {
  AdsRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<List<AdConfigModel>> fetchAdConfigs() async {
    final response = await _apiClient.get(ApiRoutes.ads);
    final data = response['data'] as List<dynamic>;
    return data.map((json) => AdConfigModel.fromJson(json)).toList();
  }
}