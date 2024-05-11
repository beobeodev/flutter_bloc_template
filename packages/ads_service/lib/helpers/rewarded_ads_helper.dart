import 'package:ads_service/helpers/ads_helper.dart';
import 'package:ads_service/helpers/ads_ids_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdsHelper extends AdsHelper {
  RewardedAdsHelper({
    super.maxNumOfLoadAttempts,
    super.id,
    super.numOfLoadAttempts,
  });

  @override
  Future<void> preloadAds({
    void Function()? onAdLoaded,
    void Function()? onAdFailedToLoad,
  }) {
    return RewardedAd.load(
      adUnitId: (kReleaseMode && id != null) ? id! : AdsIdsHelper.getRewardedAdsId(),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
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
