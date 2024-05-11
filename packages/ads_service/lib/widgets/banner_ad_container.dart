import 'package:ads_service/helpers/ads_ids_helper.dart';
import 'package:ads_service/load_ads_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdContainer extends StatefulWidget {
  final String? adsId;
  final AdSize adSize;
  final void Function()? onAdClicked;
  final Color backgroundColor;
  final String loadingTitle;
  final TextStyle loadingStyle;

  const BannerAdContainer({
    super.key,
    this.adSize = AdSize.banner,
    this.adsId,
    this.onAdClicked,
    this.backgroundColor = Colors.white,
    this.loadingTitle = 'Loading ads...',
    this.loadingStyle = const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
  });

  @override
  State<BannerAdContainer> createState() => _BannerAdContainerState();
}

class _BannerAdContainerState extends State<BannerAdContainer> with AutomaticKeepAliveClientMixin<BannerAdContainer> {
  BannerAd? _bannerAd;
  LoadAdsStatus loadStatus = LoadAdsStatus.loading;

  @override
  void initState() {
    _bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: (kReleaseMode && widget.adsId != null) ? widget.adsId! : AdsIdsHelper.getBannerAdsId(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            loadStatus = LoadAdsStatus.success;
          });
        },
        onAdFailedToLoad: (ad, error) {
          setState(() {
            loadStatus = LoadAdsStatus.failure;
          });
        },
        onAdClicked: (_) => widget.onAdClicked?.call(),
      ),
      request: const AdRequest(),
    )..load();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildLoadingCard() {
    return Container(
      height: widget.adSize.height.toDouble(),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      alignment: Alignment.center,
      child: Text(
        widget.loadingTitle,
        style: widget.loadingStyle,
      ),
    );
  }

  Widget _buildAds() {
    return Container(
      height: widget.adSize.height.toDouble(),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      child: SizedBox(
        width: widget.adSize.width.toDouble(),
        height: widget.adSize.height.toDouble(),
        child: AdWidget(
          ad: _bannerAd!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return switch (loadStatus) {
      LoadAdsStatus.loading => _buildLoadingCard(),
      LoadAdsStatus.success => _buildAds(),
      LoadAdsStatus.failure => const SizedBox.shrink(),
    };
  }
}
