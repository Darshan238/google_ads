import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeController extends GetxController {
  BannerAd? bannerAd;
  bool isAdLoaded = false;
  AppOpenAd? openAd;
  InterstitialAd? interstitialAd;

  @override
  void onInit() {
    initAdsBanner();
    super.onInit();
  }

  initAdsBanner() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-3940256099942544/3419835294',
        listener: BannerAdListener(
            onAdLoaded: (ad) {
              isAdLoaded = true;
            },
            onAdFailedToLoad: (ad, error) {}),
        request: const AdRequest());

    bannerAd!.load();
  }

  Future<void> openLoadAd() async {
    await AppOpenAd.load(
        adUnitId: '	ca-app-pub-3940256099942544/3419835294',
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
          print('ad is loaded');
          openAd = ad;
          // openAd!.show();
        }, onAdFailedToLoad: (error) {
          print('ad failed to load $error');
        }),
        orientation: AppOpenAd.orientationPortrait);
  }

  /// show again openads  function
  void showAd() {
    if (openAd == null) {
      print('trying tto show before loading');
      openLoadAd();
      return;
    }

    openAd!.fullScreenContentCallback =
        FullScreenContentCallback(onAdShowedFullScreenContent: (ad) {
      print('onAdShowedFullScreenContent');
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      ad.dispose();
      print('failed to load $error');
      openAd = null;
      openLoadAd();
    }, onAdDismissedFullScreenContent: (ad) {
      ad.dispose();
      print('dismissed');
      openAd = null;
      openLoadAd();
    });

    openAd!.show();
  }

  iniinterstitialAd() {
    InterstitialAd.load(
        adUnitId: InterstitialAd.testAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: onAdLoaded, onAdFailedToLoad: (error) {}));
  }

  void onAdLoaded(InterstitialAd ad) {
    interstitialAd = ad;
    isAdLoaded = true;
    interstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
      interstitialAd!.dispose();
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      interstitialAd!.dispose();
    });
  }
}
