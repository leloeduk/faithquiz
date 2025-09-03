import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_localization.dart';
import 'category_screen.dart';

class HomeScreen extends StatelessWidget {
  final AppLocal local;

  const HomeScreen({super.key, required this.local});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(local.translate('home_title'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              local.translate('choose_level'),
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20),
            ...AppConstants.levels.map(
              (level) => ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CategoryScreen(level: level, local: local),
                    ),
                  );
                },
                child: Text(level.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
