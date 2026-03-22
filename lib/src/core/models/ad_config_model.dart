import 'dart:convert';

class AdConfigModel {
  final String networkName;
  final Map<String, dynamic> settings;

  AdConfigModel({
    required this.networkName,
    required this.settings,
  });

  factory AdConfigModel.fromJson(Map<String, dynamic> json) {
    final rawSettings = json['settings_json'];
    Map<String, dynamic> settingsMap = {};
    if (rawSettings is String && rawSettings.isNotEmpty) {
      try {
        settingsMap = jsonDecode(rawSettings) as Map<String, dynamic>;
      } catch (_) {
        settingsMap = {};
      }
    }

    return AdConfigModel(
      networkName: json['network_name'] ?? '',
      settings: settingsMap,
    );
  }
}
