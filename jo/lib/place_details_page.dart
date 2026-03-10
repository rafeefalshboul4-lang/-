import 'package:flutter/material.dart';

class PlaceDetailsPage extends StatelessWidget {
  final String title;
  final String description;

  const PlaceDetailsPage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          description,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}