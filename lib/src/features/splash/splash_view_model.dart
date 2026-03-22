import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ads/dynamic_ad_manager.dart';
import '../../core/di/injection.dart';
import '../../core/repository/ads_repository.dart';
import '../../core/repository/settings_repository.dart';
import 'splash_state.dart';

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, SplashState>(
  (ref) => SplashViewModel(),
);

class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel() : super(SplashState.initial());

  Future<void> init() async {
    state = state.copyWith(status: SplashStatus.loading);

    try {
      final settingsRepo = getIt<SettingsRepository>();
      final settings = await settingsRepo.fetchSettings();

      if (settings.maintenanceMode) {
        state = state.copyWith(
            status: SplashStatus.maintenance, settings: settings);
        return;
      }

      // Fetch and initialize ads
      final adsRepo = getIt<AdsRepository>();
      final adConfigs = await adsRepo.fetchAdConfigs();
      if (adConfigs.isNotEmpty) {
        DynamicAdManager.initialize(adConfigs.first);
      }

      // TODO: Compare versionCode from package_info_plus to settings.latestVersionCode
      // and set updateRequired if needed.

      state = state.copyWith(status: SplashStatus.ready, settings: settings);
    } catch (e) {
      state = state.copyWith(status: SplashStatus.error, message: e.toString());
    }
  }
}
