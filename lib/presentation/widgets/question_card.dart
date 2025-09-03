import 'package:flutter/material.dart';
import '../../data/models/question_model.dart';
import 'option_tile.dart';
import 'timer_widget.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final Function(int) onOptionSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimerWidget(seconds: 10, onTimeUp: () => onOptionSelected(-1)),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            question.question,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        ...List.generate(
          question.options.length,
          (index) => OptionTile(
            text: question.options[index],
            onTap: () => onOptionSelected(index),
          ),
        ),
      ],
    );
  }
}
