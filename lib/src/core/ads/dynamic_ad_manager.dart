import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as gma;
import 'package:applovin_max/applovin_max.dart';

import '../models/ad_config_model.dart';

enum AdNetwork { admob, applovin }

class DynamicAdManager {
  static AdNetwork? _currentNetwork;
  static AdConfigModel? _config;

  static void initialize(AdConfigModel config) {
    _config = config;
    _currentNetwork = _parseNetwork(config.networkName);

    switch (_currentNetwork) {
      case AdNetwork.admob:
        _initAdMob();
        break;
      case AdNetwork.applovin:
        _initAppLovin();
        break;
      default:
        break;
    }
  }

  static AdNetwork? _parseNetwork(String networkName) {
    switch (networkName.toLowerCase()) {
      case 'admob':
        return AdNetwork.admob;
      case 'applovin':
        return AdNetwork.applovin;
      default:
        return null;
    }
  }

  static void _initAdMob() {
    // AdMob initialization
    gma.MobileAds.instance.initialize();
  }

  static void _initAppLovin() {
    // AppLovin initialization
    AppLovinMAX.initialize(_config!.settings['sdk_key'] ?? '');
  }

  static Future<void> showInterstitial() async {
    switch (_currentNetwork) {
      case AdNetwork.admob:
        await _showAdMobInterstitial();
        break;
      case AdNetwork.applovin:
        await _showAppLovinInterstitial();
        break;
      default:
        break;
    }
  }

  static Future<void> _showAdMobInterstitial() async {
    final adUnitId = _config!.settings['interstitial_id'] ?? '';
    await gma.InterstitialAd.load(
      adUnitId: adUnitId,
      request: const gma.AdRequest(),
      adLoadCallback: gma.InterstitialAdLoadCallback(
        onAdLoaded: (gma.InterstitialAd ad) {
          ad.show();
        },
        onAdFailedToLoad: (gma.LoadAdError error) {
          // Handle error
        },
      ),
    );
  }

  static Future<void> _showAppLovinInterstitial() async {
    AppLovinMAX.showInterstitial(_config!.settings['interstitial_id'] ?? '');
  }

  static Widget buildBannerAd() {
    switch (_currentNetwork) {
      case AdNetwork.admob:
        return _buildAdMobBanner();
      case AdNetwork.applovin:
        return _buildAppLovinBanner();
      default:
        return const SizedBox.shrink();
    }
  }

  static Widget _buildAdMobBanner() {
    final adUnitId = _config!.settings['banner_id'] ?? '';
    return SizedBox(
      height: 50,
      child: gma.AdWidget(
        ad: gma.BannerAd(
          adUnitId: adUnitId,
          size: gma.AdSize.banner,
          request: const gma.AdRequest(),
          listener: const gma.BannerAdListener(),
        )..load(),
      ),
    );
  }

  static Widget _buildAppLovinBanner() {
    // AppLovin MAX banner implementation
    // Note: AppLovin MAX banner creation is typically handled differently
    // This is a placeholder - you may need to adjust based on actual API
    return const SizedBox(
      height: 50,
      child: Center(
        child: Text('AppLovin Banner', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  static Widget buildNativeAd() {
    switch (_currentNetwork) {
      case AdNetwork.admob:
        return _buildAdMobNative();
      case AdNetwork.applovin:
        return _buildAppLovinNative();

      default:
        return const SizedBox.shrink();
    }
  }

  static Widget _buildAdMobNative() {
    final adUnitId = _config!.settings['native_id'] ?? '';
    return SizedBox(
      height: 250,
      child: gma.AdWidget(
        ad: gma.NativeAd(
          adUnitId: adUnitId,
          factoryId: 'adFactoryExample',
          request: gma.AdRequest(),
          listener: gma.NativeAdListener(),
        )..load(),
      ),
    );
  }

  static Widget _buildAppLovinNative() {
    // AppLovin MAX native ad implementation
    // Note: AppLovin MAX native ad creation is typically handled differently
    // This is a placeholder - you may need to adjust based on actual API
    return const SizedBox(
      height: 250,
      child: Center(
        child:
            Text('AppLovin Native Ad', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
