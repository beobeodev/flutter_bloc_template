import 'dart:io';

import 'package:ads_service/ads_config.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdsHelper {
  AdWithoutView? adWithoutView;

  final String? id;
  int numOfLoadAttempts;
  final int maxNumOfLoadAttempts;

  AdsHelper({
    this.numOfLoadAttempts = 0,
    this.maxNumOfLoadAttempts = 3,
    this.id,
  });

  Future<void> preloadAds({
    void Function()? onAdLoaded,
    void Function()? onAdFailedToLoad,
  });

  void setAd({required AdWithoutView ad, required void Function()? onAdLoaded}) {
    numOfLoadAttempts = 0;
    adWithoutView = ad;

    onAdLoaded?.call();
  }

  void handleAdFailedToLoad({required void Function()? onAdFailedToLoad}) {
    adWithoutView = null;

    if (numOfLoadAttempts < maxNumOfLoadAttempts) {
      ++numOfLoadAttempts;
      preloadAds();
    }

    onAdFailedToLoad?.call();
  }

  Future<void> showAds({
    required BuildContext context,
    void Function()? onAdShowedFullScreenContent,
    void Function()? onAdFailedToLoad,
    void Function()? onAdFailedToShowFullScreenContent,
    void Function()? onAdDismissedFullScreenContent,
    void Function()? onAdClicked,
    void Function(AdWithoutView, RewardItem)? onUserEarnedReward,
  }) async {
    if (adWithoutView == null) {
      AdsConfig.instance.showLoading(context);

      await preloadAds(
        onAdLoaded: () async {
          Navigator.pop(context);

          await showFullScreenContent(
            onAdShowedFullScreenContent: onAdShowedFullScreenContent,
            onAdFailedToShowFullScreenContent: onAdFailedToShowFullScreenContent,
            onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
            onAdClicked: onAdClicked,
            onUserEarnedReward: onUserEarnedReward,
          );
        },
        onAdFailedToLoad: () {
          Navigator.pop(context);
          onAdFailedToLoad?.call();
        },
      ).catchError((_) {
        Navigator.pop(context);
        onAdFailedToLoad?.call();
      });

      return;
    }

    await showFullScreenContent(
      onAdShowedFullScreenContent: onAdShowedFullScreenContent,
      onAdFailedToShowFullScreenContent: onAdFailedToShowFullScreenContent,
      onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
      onAdClicked: onAdClicked,
      onUserEarnedReward: onUserEarnedReward,
    );
  }

  Future<void> showFullScreenContent({
    required void Function()? onAdShowedFullScreenContent,
    required void Function()? onAdFailedToShowFullScreenContent,
    required void Function()? onAdDismissedFullScreenContent,
    required void Function()? onAdClicked,
    required void Function(AdWithoutView, RewardItem)? onUserEarnedReward,
  }) async {
    if (adWithoutView == null) return;

    if (adWithoutView is AppOpenAd) {
      final ad = adWithoutView as AppOpenAd;

      ad.fullScreenContentCallback = _getContentCallback<AppOpenAd>(
        onAdClicked: onAdClicked,
        onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
        onAdFailedToShowFullScreenContent: onAdFailedToShowFullScreenContent,
        onAdShowedFullScreenContent: onAdShowedFullScreenContent,
      );

      await ad.show();
    } else if (adWithoutView is InterstitialAd) {
      final ad = adWithoutView as InterstitialAd;

      ad.fullScreenContentCallback = _getContentCallback<InterstitialAd>(
        onAdClicked: onAdClicked,
        onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
        onAdFailedToShowFullScreenContent: onAdFailedToShowFullScreenContent,
        onAdShowedFullScreenContent: onAdShowedFullScreenContent,
      );

      await ad.show();
    } else if (adWithoutView is RewardedAd) {
      final ad = adWithoutView as RewardedAd;

      ad.fullScreenContentCallback = _getContentCallback<RewardedAd>(
        onAdClicked: onAdClicked,
        onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
        onAdFailedToShowFullScreenContent: onAdFailedToShowFullScreenContent,
        onAdShowedFullScreenContent: onAdShowedFullScreenContent,
      );

      await ad.show(onUserEarnedReward: (ad, item) => onUserEarnedReward?.call(ad, item));
    }

    return;
  }

  FullScreenContentCallback<T> _getContentCallback<T extends AdWithoutView>({
    required void Function()? onAdShowedFullScreenContent,
    required void Function()? onAdFailedToShowFullScreenContent,
    required void Function()? onAdDismissedFullScreenContent,
    required void Function()? onAdClicked,
  }) {
    return FullScreenContentCallback<T>(
      onAdShowedFullScreenContent: (_) {
        onAdShowedFullScreenContent?.call();
      },
      onAdFailedToShowFullScreenContent: (ad, __) {
        _disposeAd(ad);
        if (Platform.isAndroid) {
          _disableOpenAppAds();
        }

        onAdFailedToShowFullScreenContent?.call();
      },
      onAdWillDismissFullScreenContent: (ad) {
        _disableOpenAppAds();
      },
      onAdDismissedFullScreenContent: (ad) {
        _disposeAd(ad);
        if (Platform.isAndroid) {
          _disableOpenAppAds();
        }

        onAdDismissedFullScreenContent?.call();
      },
      onAdClicked: (_) => onAdClicked?.call(),
    );
  }

  void _disableOpenAppAds() {
    AdsConfig().enableOpenAppAds = false;
  }

  void _disposeAd(Ad ad) {
    ad.dispose();
    adWithoutView = null;
    preloadAds();
  }
}
