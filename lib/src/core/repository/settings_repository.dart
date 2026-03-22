import '../models/settings_model.dart';
import '../network/api_client.dart';
import '../network/api_routes.dart';

class SettingsRepository {
  SettingsRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<SettingsModel> fetchSettings() async {
    final response = await _apiClient.get(ApiRoutes.settings);
    return SettingsModel.fromJson(response);
  }
}
