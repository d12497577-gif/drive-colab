import '../../core/models/settings_model.dart';

enum SplashStatus { idle, loading, ready, maintenance, updateRequired, error }

class SplashState {
  final SplashStatus status;
  final SettingsModel? settings;
  final String? message;

  const SplashState({
    required this.status,
    this.settings,
    this.message,
  });

  factory SplashState.initial() => const SplashState(status: SplashStatus.idle);

  SplashState copyWith({
    SplashStatus? status,
    SettingsModel? settings,
    String? message,
  }) {
    return SplashState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      message: message ?? this.message,
    );
  }
}
