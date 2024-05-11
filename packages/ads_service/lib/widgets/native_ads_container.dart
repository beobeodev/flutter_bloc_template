import 'package:ads_service/helpers/ads_ids_helper.dart';
import 'package:ads_service/load_ads_status.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdsContainer extends StatefulWidget {
  final String? adsId;
  final TemplateType templateType;
  final VoidCallback? onAdClicked;
  final double borderRadius;
  final Color backgroundColor;
  final Widget? loadingWidget;
  final NativeTemplateTextStyle? callToActionTextStyle;
  final NativeTemplateTextStyle? primaryTextStyle;
  final NativeTemplateTextStyle? secondaryTextStyle;
  final NativeTemplateTextStyle? tertiaryTextStyle;

  const NativeAdsContainer({
    super.key,
    this.adsId,
    this.templateType = TemplateType.medium,
    this.onAdClicked,
    this.borderRadius = 0,
    this.backgroundColor = Colors.white,
    this.loadingWidget,
    this.callToActionTextStyle,
    this.primaryTextStyle,
    this.secondaryTextStyle,
    this.tertiaryTextStyle,
  });

  @override
  State<NativeAdsContainer> createState() => _NativeAdsContainerState();
}

class _NativeAdsContainerState extends State<NativeAdsContainer>
    with AutomaticKeepAliveClientMixin<NativeAdsContainer> {
  NativeAd? nativeAd;
  LoadAdsStatus loadStatus = LoadAdsStatus.loading;

  @override
  void initState() {
    super.initState();
    nativeAd = NativeAd(
      adUnitId: widget.adsId ?? AdsIdsHelper.getNativeAdsId(),
      listener: NativeAdListener(
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
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: widget.templateType,
        cornerRadius: widget.borderRadius,
        mainBackgroundColor: widget.backgroundColor,
        callToActionTextStyle: widget.callToActionTextStyle ??
            NativeTemplateTextStyle(
              textColor: Colors.black,
              backgroundColor: Colors.white,
              style: NativeTemplateFontStyle.bold,
              size: 17.0,
            ),
        primaryTextStyle: widget.primaryTextStyle ??
            NativeTemplateTextStyle(
              textColor: Colors.black,
              backgroundColor: Colors.white,
              style: NativeTemplateFontStyle.bold,
              size: 17.0,
            ),
        secondaryTextStyle: widget.secondaryTextStyle ??
            NativeTemplateTextStyle(
              textColor: Colors.black,
              backgroundColor: Colors.white,
              style: NativeTemplateFontStyle.bold,
              size: 17.0,
            ),
        tertiaryTextStyle: widget.tertiaryTextStyle ??
            NativeTemplateTextStyle(
              textColor: Colors.black,
              backgroundColor: Colors.white,
              style: NativeTemplateFontStyle.bold,
              size: 17.0,
            ),
      ),
    )..load();
  }

  Widget _buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      constraints: BoxConstraints(
        minWidth: 320,
        maxWidth: 400,
        minHeight: widget.templateType == TemplateType.medium ? 320 : 90,
        maxHeight: widget.templateType == TemplateType.medium ? 400 : 200,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return switch (loadStatus) {
      LoadAdsStatus.loading => _buildContainer(
          widget.loadingWidget ??
              const Text('Loading ads...', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
      LoadAdsStatus.success => _buildContainer(AdWidget(ad: nativeAd!)),
      LoadAdsStatus.failure => const SizedBox.shrink(),
    };
  }

  @override
  bool get wantKeepAlive => true;
}
