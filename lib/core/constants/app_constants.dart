class AppConstants {
  // Niveaux du quiz
  static const List<String> levels = ['debutant', 'moyen', 'avance', 'expert'];

  // Durée du quiz en secondes
  static const int quizTimeLimit = 10;

  // Nombre de questions par catégorie
  static const int questionsPerCategory = 5;

  // Clés Hive
  static const String hiveScoresBox = 'scores';

  // URLs de partage
  static const String shareMessageTemplate =
      "J’ai obtenu {score}/20 au quiz biblique !";

  // ID Ads (à remplacer par vos vrais IDs)
  static const String bannerAdUnitId = '<YOUR_BANNER_AD_UNIT_ID>';
  static const String interstitialAdUnitId = '<YOUR_INTERSTITIAL_AD_UNIT_ID>';
}
