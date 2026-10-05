import 'package:flutter/material.dart';
import 'presentation/signup.dart';

void main() {
  runApp(const MuseApp());
}

class MuseApp extends StatelessWidget {
  const MuseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MUSE',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFFCF8),
      ),
      home: const SignUpPage(),
    );
  }
}