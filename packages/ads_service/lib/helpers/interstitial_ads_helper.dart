import 'package:ads_service/helpers/ads_helper.dart';
import 'package:ads_service/helpers/ads_ids_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdsHelper extends AdsHelper {
  InterstitialAdsHelper({
    super.maxNumOfLoadAttempts,
    super.id,
    super.numOfLoadAttempts,
  });

  @override
  Future<void> preloadAds({
    void Function()? onAdLoaded,
    void Function()? onAdFailedToLoad,
  }) {
    return InterstitialAd.load(
      adUnitId: (kReleaseMode && id != null) ? id! : AdsIdsHelper.getInterstitialAdsId(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          super.setAd(ad: ad, onAdLoaded: onAdLoaded);
        },
        onAdFailedToLoad: (err) {
          super.handleAdFailedToLoad(onAdFailedToLoad: onAdFailedToLoad);
        },
      ),
    );
  }
}
