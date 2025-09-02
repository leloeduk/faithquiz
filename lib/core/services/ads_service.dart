import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsService {
  static BannerAd? bannerAd;
  static InterstitialAd? interstitialAd;

  /// Charger la banner
  static void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: '<YOUR_BANNER_AD_UNIT_ID>',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => print("Banner loaded"),
        onAdFailedToLoad: (_, e) => print("Banner failed to load: $e"),
      ),
    )..load();
  }

  /// Charger l'interstitiel
  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: '<YOUR_INTERSTITIAL_AD_UNIT_ID>',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => interstitialAd = ad,
        onAdFailedToLoad: (err) => print("Interstitial failed to load: $err"),
      ),
    );
  }

  /// Afficher l'interstitiel
  static void showInterstitial() {
    if (interstitialAd != null) {
      interstitialAd!.show();
      interstitialAd = null;
      loadInterstitialAd(); // recharge automatique
    }
  }

  /// Nettoyer les ads si besoin
  static void dispose() {
    bannerAd?.dispose();
    interstitialAd?.dispose();
  }
}
