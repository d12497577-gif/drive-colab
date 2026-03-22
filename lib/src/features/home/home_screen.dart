import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ads/dynamic_ad_manager.dart';
import '../../core/models/settings_model.dart';
import '../splash/splash_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(splashViewModelProvider.select((state) => state.settings));

    if (settings == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('AbdouTV')),
      body: const Center(child: Text('Home Screen - Coming Soon')),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DynamicAdManager.buildBannerAd(),
          _buildBottomNav(settings),
        ],
      ),
    );
  }

  Widget _buildBottomNav(SettingsModel settings) {
    final items = <BottomNavigationBarItem>[];

    if (settings.enableChannels) {
      items.add(const BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Channels'));
    }
    if (settings.enableMovies) {
      items.add(const BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'));
    }
    if (settings.enableAnime) {
      items.add(const BottomNavigationBarItem(icon: Icon(Icons.animation), label: 'Anime'));
    }

    if (items.isEmpty) return const SizedBox.shrink();

    return BottomNavigationBar(
      items: items,
      currentIndex: 0,
      onTap: (index) {
        // TODO: Navigate to respective screens
      },
    );
  }
}