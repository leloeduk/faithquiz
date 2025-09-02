import 'package:bloc/bloc.dart';
import 'package:faithquiz/data/models/question_model.dart';
import 'package:faithquiz/data/repositories/quiz_repository.dart';
import 'package:faithquiz/logic/bloc/quiz_event.dart';
import 'package:faithquiz/logic/bloc/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository quizRepository;

  QuizBloc({required this.quizRepository}) : super(QuizInitial()) {
    on<LoadQuestionsEvent>(_onLoadQuestions);
    on<AnswerSelectedEvent>(_onAnswerSelected);
    on<NextQuestionEvent>(_onNextQuestion);
    on<ResetQuizEvent>(_onResetQuiz);
  }

  Future<void> _onLoadQuestions(
    LoadQuestionsEvent event,
    Emitter<QuizState> emit,
  ) async {
    emit(QuizLoading());
    try {
      final questions = event.category != null
          ? await quizRepository.getQuestionsByCategory(
              event.level as String,
              event.category!,
            )
          : await quizRepository.loadQuestions(event.level as String);
      emit(QuizLoaded(questions: questions, currentQuestionIndex: 0, score: 0));
    } catch (e) {
      emit(QuizError('Erreur de chargement: $e'));
    }
  }

  void _onAnswerSelected(AnswerSelectedEvent event, Emitter<QuizState> emit) {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      final currentQuestion = currentState.questions[event.questionIndex];

      final isCorrect =
          event.selectedAnswerIndex == currentQuestion.correctIndex;
      final updatedScore = isCorrect
          ? currentState.score + 1
          : currentState.score;

      final updatedQuestions = List<Question>.from(currentState.questions);
      updatedQuestions[event.questionIndex] = currentQuestion.copyWith(
        userAnswerIndex: event.selectedAnswerIndex,
      );

      emit(
        currentState.copyWith(questions: updatedQuestions, score: updatedScore),
      );
    }
  }

  void _onNextQuestion(NextQuestionEvent event, Emitter<QuizState> emit) {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;

      if (currentState.currentQuestionIndex + 1 >=
          currentState.questions.length) {
        emit(QuizCompleted(currentState.score, currentState.questions.length));
      } else {
        emit(
          currentState.copyWith(
            currentQuestionIndex: currentState.currentQuestionIndex + 1,
          ),
        );
      }
    }
  }

  void _onResetQuiz(ResetQuizEvent event, Emitter<QuizState> emit) {
    emit(QuizInitial());
  }
}
