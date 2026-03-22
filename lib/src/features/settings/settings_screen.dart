import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/ads/dynamic_ad_manager.dart';
import '../../core/models/settings_model.dart';
import '../../core/theme/app_theme.dart';
import 'settings_view_model.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsViewModelProvider);

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.error != null
                  ? _buildErrorView(state.error!, ref)
                  : state.settings != null
                      ? _buildSettingsList(state.settings!, context)
                      : const Center(
                          child: Text(
                            'No settings available',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

          // Banner ad at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DynamicAdManager.buildBannerAd(),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String error, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Error: $error',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                ref.read(settingsViewModelProvider.notifier).loadSettings(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList(SettingsModel settings, BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('App Status'),
        _buildSettingItem(
          'Maintenance Mode',
          settings.maintenanceMode ? 'Active' : 'Inactive',
          settings.maintenanceMode ? Colors.red : Colors.green,
        ),
        const SizedBox(height: 16),
        _buildSectionTitle('Features'),
        _buildSettingItem(
          'Channels',
          settings.enableChannels ? 'Enabled' : 'Disabled',
          settings.enableChannels ? Colors.green : Colors.red,
        ),
        _buildSettingItem(
          'Movies',
          settings.enableMovies ? 'Enabled' : 'Disabled',
          settings.enableMovies ? Colors.green : Colors.red,
        ),
        _buildSettingItem(
          'Anime',
          settings.enableAnime ? 'Enabled' : 'Disabled',
          settings.enableAnime ? Colors.green : Colors.red,
        ),
        const SizedBox(height: 16),
        _buildSectionTitle('Updates'),
        _buildSettingItem(
          'Latest Version',
          'Code: ${settings.latestVersionCode}',
          Colors.blue,
        ),
        if (settings.updateMessage.isNotEmpty)
          _buildSettingItem(
            'Update Message',
            settings.updateMessage,
            Colors.orange,
          ),
        if (settings.updateUrl.isNotEmpty)
          ListTile(
            title: const Text(
              'Update App',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              settings.updateUrl,
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: const Icon(
              Icons.open_in_new,
              color: Colors.blue,
            ),
            onTap: () => _launchUrl(settings.updateUrl),
          ),
        const SizedBox(height: 16),
        _buildSectionTitle('About'),
        const ListTile(
          title: Text(
            'Version',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            '1.0.0',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const ListTile(
          title: Text(
            'Developer',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'AbdouTV Team',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingItem(String title, String value, Color valueColor) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: Text(
        value,
        style: TextStyle(
          color: valueColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
