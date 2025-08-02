import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsProvider extends ChangeNotifier {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  bool _isPremium = false;

  BannerAd? get bannerAd => _bannerAd;
  bool get isAdLoaded => _isAdLoaded;
  bool get isPremium => _isPremium;

  void setPremium(bool isPremium) {
    _isPremium = isPremium;
    if (isPremium && _bannerAd != null) {
      _bannerAd!.dispose();
      _bannerAd = null;
      _isAdLoaded = false;
    }
    notifyListeners();
  }

  Future<void> loadBannerAd() async {
    if (_isPremium) return;

    _bannerAd = BannerAd(
      adUnitId: _getAdUnitId(),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isAdLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _isAdLoaded = false;
          notifyListeners();
        },
      ),
    );

    try {
      await _bannerAd!.load();
    } catch (e) {
      _bannerAd = null;
      _isAdLoaded = false;
      notifyListeners();
    }
  }

  void disposeAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
    _isAdLoaded = false;
  }

  String _getAdUnitId() {
    // Replace with your actual AdMob unit IDs
    // For testing, you can use the test IDs
    // Note: In a real app, you'd need to pass the platform context
    // For now, we'll use Android test ID as default
    return 'ca-app-pub-3940256099942544/6300978111'; // Test ID for Android
  }
} 