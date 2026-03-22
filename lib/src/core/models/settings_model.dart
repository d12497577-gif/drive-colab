class SettingsModel {
  final bool maintenanceMode;
  final int latestVersionCode;
  final String updateUrl;
  final String updateMessage;
  final bool forceUpdate;

  final bool enableChannels;
  final bool enableMovies;
  final bool enableAnime;

  SettingsModel({
    required this.maintenanceMode,
    required this.latestVersionCode,
    required this.updateUrl,
    required this.updateMessage,
    required this.forceUpdate,
    required this.enableChannels,
    required this.enableMovies,
    required this.enableAnime,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? <String, dynamic>{};

    bool parseBool(dynamic value) {
      if (value is bool) return value;
      if (value is num) return value == 1;
      if (value is String) return value == '1' || value.toLowerCase() == 'true';
      return false;
    }

    int parseInt(dynamic value) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      if (value is num) return value.toInt();
      return 0;
    }

    return SettingsModel(
      maintenanceMode: parseBool(data['maintenance_mode']),
      latestVersionCode: parseInt(data['latest_version_code'] ?? data['version'] ?? 0),
      updateUrl: data['update_url'] ?? '',
      updateMessage: data['update_message'] ?? '',
      forceUpdate: parseBool(data['force_update']),
      enableChannels: parseBool(data['enable_channels']),
      enableMovies: parseBool(data['enable_movies']),
      enableAnime: parseBool(data['enable_anime']),
    );
  }
}
