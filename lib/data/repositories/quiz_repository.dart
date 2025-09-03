import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/question_model.dart';

class QuizRepository {
  /// Charger toutes les questions selon le niveau
  Future<List<Question>> loadQuestions(String level) async {
    try {
      final fileName = 'lib/assets/json/quiz_$level.json';
      final String data = await rootBundle.loadString(fileName);
      final Map<String, dynamic> jsonResult = json.decode(data);

      final List questionsJson = jsonResult['questions'] ?? [];
      return questionsJson.map((q) => Question.fromJson(q)).toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement des questions: $e');
    }
  }

  /// Filtrer par catégorie
  Future<List<Question>> getQuestionsByCategory(
    String level,
    String category,
  ) async {
    final allQuestions = await loadQuestions(level);
    return allQuestions.where((q) => q.category == category).toList();
  }

  /// Récupérer toutes les catégories disponibles
  Future<List<String>> getCategories(String level) async {
    final allQuestions = await loadQuestions(level);
    final categories = allQuestions.map((q) => q.category).toSet().toList();
    return categories;
  }
}
