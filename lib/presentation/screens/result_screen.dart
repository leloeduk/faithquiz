import 'package:flutter/material.dart';
import '../../core/utils/app_localization.dart';
import '../../core/services/hive_service.dart';
import '../../core/constants/app_constants.dart';
import 'package:share_plus/share_plus.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final AppLocal local;

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.local,
  });

  @override
  Widget build(BuildContext context) {
    HiveService.saveScore('debutant', score); // adapter selon le niveau réel
    return Scaffold(
      appBar: AppBar(title: Text(local.translate('finish'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${local.translate('score')}: $score/$total',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Share.share(
                  AppConstants.shareMessageTemplate.replaceAll(
                    '{score}',
                    '$score',
                  ),
                );
              },
              child: Text(local.translate('share_score')),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text('Back Home'),
            ),
          ],
        ),
      ),
    );
  }
}
