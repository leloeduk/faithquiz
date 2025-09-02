import 'package:hive/hive.dart';

class HiveService {
  static const String scoresBox = 'scores';

  /// Ouvre la box Hive
  static Future<void> init() async {
    await Hive.openBox(scoresBox);
  }

  /// Sauvegarder le score
  static Future<void> saveScore(String level, int score) async {
    final box = Hive.box(scoresBox);
    // sauvegarde sous forme map par niveau
    List<int> scores = box.get(level, defaultValue: <int>[])?.cast<int>() ?? [];
    scores.add(score);
    await box.put(level, scores);
  }

  /// Récupérer tous les scores pour un niveau
  static List<int> getScores(String level) {
    final box = Hive.box(scoresBox);
    return box.get(level, defaultValue: <int>[])?.cast<int>() ?? [];
  }

  /// Récupérer le meilleur score pour un niveau
  static int getBestScore(String level) {
    final scores = getScores(level);
    if (scores.isEmpty) return 0;
    scores.sort((a, b) => b.compareTo(a));
    return scores.first;
  }

  /// Reset scores pour un niveau
  static Future<void> resetScores(String level) async {
    final box = Hive.box(scoresBox);
    await box.put(level, <int>[]);
  }
}
