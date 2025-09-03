import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const OptionTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(title: Text(text), onTap: onTap),
    );
  }
}
