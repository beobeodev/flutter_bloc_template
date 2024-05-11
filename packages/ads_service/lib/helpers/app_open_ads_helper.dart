import 'package:ads_service/helpers/ads_helper.dart';
import 'package:ads_service/helpers/ads_ids_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdsHelper extends AdsHelper {
  AppOpenAdsHelper({
    super.maxNumOfLoadAttempts,
    super.id,
    super.numOfLoadAttempts,
  });

  @override
  Future<void> preloadAds({
    void Function()? onAdLoaded,
    void Function()? onAdFailedToLoad,
  }) {
    return AppOpenAd.load(
      adUnitId: (kReleaseMode && id != null) ? id! : AdsIdsHelper.getAppOpenAdsId(),
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (AppOpenAd ad) {
          super.setAd(ad: ad, onAdLoaded: onAdLoaded);
        },
        onAdFailedToLoad: (LoadAdError error) {
          super.handleAdFailedToLoad(onAdFailedToLoad: onAdFailedToLoad);
        },
      ),
    );
  }
}
