import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'network/api_client.dart';
import 'repository/anime_repository.dart';
import 'repository/channels_repository.dart';
import 'repository/movies_repository.dart';
import 'repository/settings_repository.dart';

/// Provides a single shared instance of [ApiClient] for the app.
///
/// This is used by repositories to perform network calls.
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

/// Provides a single shared instance of [ChannelsRepository] for the app.
final channelsRepositoryProvider = Provider<ChannelsRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ChannelsRepository(apiClient: apiClient);
});

/// Provides a single shared instance of [AnimeRepository] for the app.
final animeRepositoryProvider = Provider<AnimeRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AnimeRepository(apiClient: apiClient);
});

/// Provides a single shared instance of [MoviesRepository] for the app.
final moviesRepositoryProvider = Provider<MoviesRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return MoviesRepository(apiClient: apiClient);
});

/// Provides a single shared instance of [SettingsRepository] for the app.
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return SettingsRepository(apiClient: apiClient);
});
