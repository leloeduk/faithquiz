import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/question_model.dart';

class QuizRepository {
  /// Charger les questions selon le niveau
  Future<List<Question>> loadQuestions(String level) async {
    String fileName =
        'lib/assets/json/quiz_$level.json'; // ex: quiz_debutant.json
    final String data = await rootBundle.loadString(fileName);
    final Map<String, dynamic> jsonResult = json.decode(data);

    final List questionsJson = jsonResult['questions'] ?? [];
    return questionsJson.map((q) => Question.fromJson(q)).toList();
  }

  /// Filtrer par catégorie
  Future<List<Question>> getQuestionsByCategory(
    String level,
    String category,
  ) async {
    final allQuestions = await loadQuestions(level);
    return allQuestions.where((q) => q.category == category).toList();
  }
}
