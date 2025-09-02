import 'package:hive/hive.dart';

part 'question_model.g.dart';

@HiveType(typeId: 0)
class Question extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String question;

  @HiveField(2)
  final List<String> options;

  @HiveField(3)
  final int correctIndex;

  @HiveField(4)
  final String verse;

  @HiveField(5)
  final String category; // catégorie pour filtrer si besoin

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.verse,
    required this.category,
  });

  // Création depuis JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctIndex: json['correctIndex'],
      verse: json['verse'],
      category: json['category'] ?? 'general',
    );
  }

  // Convertir en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctIndex': correctIndex,
      'verse': verse,
      'category': category,
    };
  }
}
