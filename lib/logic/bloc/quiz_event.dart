

abstract class QuizEvent {}

class LoadQuestionsEvent extends QuizEvent {
  final int level;
  final String? category;

  LoadQuestionsEvent({required this.level, this.category});
}

class AnswerSelectedEvent extends QuizEvent {
  final int questionIndex;
  final int selectedAnswerIndex;

  AnswerSelectedEvent(this.questionIndex, this.selectedAnswerIndex);
}

class NextQuestionEvent extends QuizEvent {}

class ResetQuizEvent extends QuizEvent {}