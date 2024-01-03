import 'package:flutter/widgets.dart';
import 'package:flutter_template/common/helpers/ads/ads_ids_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdsHelper {
  static final InterstitialAdsHelper _instance = InterstitialAdsHelper._(0, 3);

  InterstitialAd? _interstitialAd;

  int _numOfLoadAttempts;
  final int maxNumOfLoadAttempts;

  factory InterstitialAdsHelper() {
    return _instance;
  }

  InterstitialAdsHelper._(this._numOfLoadAttempts, this.maxNumOfLoadAttempts);

  Future<void> loadAds({required BuildContext context, String? id}) async {
    return InterstitialAd.load(
      adUnitId: id ?? AdsIdsHelper.getInterstitialAdsId(context),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _numOfLoadAttempts = 0;
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (err) {
          _interstitialAd = null;

          if (_numOfLoadAttempts < maxNumOfLoadAttempts) {
            ++_numOfLoadAttempts;
            loadAds(context: context, id: id);
          }
        },
      ),
    );
  }

  Future<void> showAds() async {
    if (_interstitialAd == null) {
    } else {}
  }
}
