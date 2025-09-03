import 'package:flutter/material.dart';
import '../../core/utils/app_localization.dart';
import 'quiz_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String level;
  final AppLocal local;

  CategoryScreen({super.key, required this.level, required this.local});

  final List<String> categories = [
    'general',
    'personnages',
    'miracles',
    'paraboles',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(local.translate('choose_category'))),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: categories
            .map(
              (cat) => Card(
                child: ListTile(
                  title: Text(cat.toUpperCase()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(
                          level: level,
                          category: cat,
                          local: local,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
