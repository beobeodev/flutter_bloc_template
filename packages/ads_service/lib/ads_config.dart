import 'package:ads_service/widgets/loading_ads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsConfig {
  static final AdsConfig _instance = AdsConfig._();

  factory AdsConfig() {
    return _instance;
  }

  AdsConfig._();

  static AdsConfig get instance => _instance;

  Widget loadingFullScreen = const LoadingAds();

  bool enableOpenAppAds = false;

  void showLoading(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return Dialog.fullscreen(child: loadingFullScreen);
      },
    );
  }

  Future<void> init() async {
    await MobileAds.instance.initialize();
  }
}
