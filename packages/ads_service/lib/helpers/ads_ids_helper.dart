import 'dart:io';

import 'package:ads_service/ads_ids/android_test_ads_ids.dart';
import 'package:ads_service/ads_ids/ios_test_ads_ids.dart';

abstract final class AdsIdsHelper {
  static String getBannerAdsId() {
    if (Platform.isAndroid) {
      return AndroidTestAdsIds.BANNER;
    } else if (Platform.isIOS) {
      return IosTestAdsIds.BANNER;
    }

    throw UnsupportedError('Unsupported platform');
  }

  static String getNativeAdsId() {
    if (Platform.isAndroid) {
      return AndroidTestAdsIds.NATIVE;
    } else if (Platform.isIOS) {
      return IosTestAdsIds.NATIVE;
    }

    throw UnsupportedError('Unsupported platform');
  }

  static String getInterstitialAdsId() {
    if (Platform.isAndroid) {
      return AndroidTestAdsIds.INTERSTITIAL;
    } else if (Platform.isIOS) {
      return IosTestAdsIds.INTERSTITIAL;
    }

    throw UnsupportedError('Unsupported platform');
  }

  static String getAppOpenAdsId() {
    if (Platform.isAndroid) {
      return AndroidTestAdsIds.OPEN_APP;
    } else if (Platform.isIOS) {
      return IosTestAdsIds.OPEN_APP;
    }
    throw UnsupportedError('Unsupported platform');
  }

  static String getRewardedAdsId() {
    if (Platform.isAndroid) {
      return AndroidTestAdsIds.REWARDED;
    } else if (Platform.isIOS) {
      return IosTestAdsIds.REWARDED;
    }

    throw UnsupportedError('Unsupported platform');
  }

  static String getRewardedInterstitialAdsId() {
    if (Platform.isAndroid) {
      return AndroidTestAdsIds.REWARDED_INTERSTITIAL;
    } else if (Platform.isIOS) {
      return IosTestAdsIds.REWARDED_INTERSTITIAL;
    }

    throw UnsupportedError('Unsupported platform');
  }
}
