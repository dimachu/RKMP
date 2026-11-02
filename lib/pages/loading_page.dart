import 'package:flutter/material.dart';

import '../routes.dart';

/// Экран заставки: через 4 секунды автоматически
/// заменяется экраном авторизации.
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Имитация инициализации (загрузка настроек, БД)
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Иконка
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade50,
                  border: Border.all(color: Colors.green, width: 3),
                ),
                child: const Icon(Icons.hotel, size: 60, color: Colors.green),
              ),
              const SizedBox(height: 32),
              // Название приложения
              const Text(
                'Отели',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Pacifico', fontSize: 40),
              ),
              const SizedBox(height: 8),
              const Text(
                'Бронирование отелей онлайн',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              const CircularProgressIndicator(color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}
