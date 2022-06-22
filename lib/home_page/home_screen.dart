import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_ads/home_page/home_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var ctr = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ADS'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  ctr.showAd();
                },
                child: Text('App Open')),
            TextButton(
                onPressed: () {
                  if (ctr.isAdLoaded) {
                    ctr.interstitialAd!.show();
                  }
                },
                child: const Text('Interstitial')),
            TextButton(
                onPressed: () {
                  ctr.rewardedAd!.show(onUserEarnedReward: (ad, reward) {});
                },
                child: Text('Rewarded')),
          ],
        ),
      ),
      bottomNavigationBar: ctr.isAdLoaded
          ? Container(
              height: ctr.bannerAd!.size.height.toDouble(),
              width: ctr.bannerAd!.size.width.toDouble(),
              child: AdWidget(
                ad: ctr.bannerAd!,
              ),
            )
          : const SizedBox(),
    );
  }
}
