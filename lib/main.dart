import 'package:flutter/material.dart';
import 'package:paper_app/screens/traces.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '스마트팟 고객사 전용 페이지',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromRGBO(1, 20, 57, 1)),
        useMaterial3: true,
      ),
      home: const TracesScreen(),
    );
  }
}