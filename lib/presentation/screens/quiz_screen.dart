import 'package:flutter/material.dart';
import '../../core/utils/app_localization.dart';
import '../../data/models/question_model.dart';
import '../../data/repositories/quiz_repository.dart';
import '../widgets/question_card.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String level;
  final String category;
  final AppLocal local;

  const QuizScreen({
    super.key,
    required this.level,
    required this.category,
    required this.local,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizRepository repository = QuizRepository();
  List<Question> questions = [];
  int currentIndex = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    questions = await repository.getQuestionsByCategory(
      widget.level,
      widget.category,
    );
    setState(() {});
  }

  void onAnswerSelected(int index) {
    if (questions[currentIndex].correctIndex == index) score++;
    if (currentIndex < questions.length - 1) {
      setState(() => currentIndex++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            score: score,
            total: questions.length,
            local: widget.local,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty)
      return const Center(child: CircularProgressIndicator());
    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: QuestionCard(
        question: questions[currentIndex],
        onOptionSelected: onAnswerSelected,
      ),
    );
  }
}
