// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:get_it/get_it.dart';

import '../network/api_client.dart';
import '../network/dio_client.dart';
import '../repository/ads_repository.dart';
import '../repository/settings_repository.dart';

Future<void> $initGetIt(GetIt getIt) async {
  // Register core services
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(dio: DioClient.create()));

  // Repositories
  getIt.registerLazySingleton<SettingsRepository>(() => SettingsRepository(apiClient: getIt()));
  getIt.registerLazySingleton<AdsRepository>(() => AdsRepository(apiClient: getIt()));
}
