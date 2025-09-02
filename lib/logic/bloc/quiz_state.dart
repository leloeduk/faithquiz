import '../../data/models/question_model.dart';

abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<Question> questions;
  final int currentQuestionIndex;
  final int score;

  QuizLoaded({
    required this.questions,
    this.currentQuestionIndex = 0,
    this.score = 0,
  });

  QuizLoaded copyWith({
    List<Question>? questions,
    int? currentQuestionIndex,
    int? score,
  }) {
    return QuizLoaded(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
    );
  }
}

class QuizError extends QuizState {
  final String message;

  QuizError(this.message);
}

class QuizCompleted extends QuizState {
  final int finalScore;
  final int totalQuestions;

  QuizCompleted(this.finalScore, this.totalQuestions);
}
