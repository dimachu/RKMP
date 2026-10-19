import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

/// Корневой виджет приложения.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Отели',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}