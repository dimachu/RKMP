import 'package:flutter/material.dart';

import '../models/hotel_feature.dart';

/// Экран детализации пункта основного экрана.
/// Пункт передаётся через arguments именованного маршрута.
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final feature =
        ModalRoute.of(context)!.settings.arguments as HotelFeature;

    return Scaffold(
      appBar: AppBar(
        // Стрелка «←» добавляется автоматически и вызывает Navigator.pop()
        title: Text(feature.title, style: const TextStyle(fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Картинка
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  feature.image,
                  width: 260,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(feature.icon, color: Colors.green),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feature.subtitle,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Описание пункта
            Text(feature.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
      // Нижняя панель как на макете: «Главная» возвращает назад,
      // «Профиль» возвращает на основной экран и открывает вкладку профиля
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.green.shade50,
        indicatorColor: Colors.green.shade200,
        selectedIndex: 0,
        onDestinationSelected: (index) => Navigator.pop(context, index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
