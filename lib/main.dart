import 'package:flutter/material.dart';

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
      home: const HotelsInfoPage(),
    );
  }
}

class HotelsInfoPage extends StatelessWidget {
  const HotelsInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Приложения для бронирования отелей'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ), // AppBar
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Блок "Название ПО"
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Отели\n(мобильные приложения для онлайн-бронирования отелей)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ), // Container

            const SizedBox(height: 16),

            // Блок "Описание ПО"
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Приложения для бронирования отелей — класс мобильного '
                    'программного обеспечения, позволяющего пользователю искать '
                    'отели по городу и датам, сравнивать номера и цены, изучать '
                    'отзывы и рейтинги, а также оформлять и оплачивать '
                    'бронирование прямо со смартфона, без обращения на ресепшн '
                    'или к оператору.',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 15),
              ),
            ), // Container

            const SizedBox(height: 16),

            // Блок "Картинка" + "Список" (Row: Expanded + Expanded)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Картинка (иконка-заглушка вместо изображения отеля)
                Expanded(
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.hotel,
                        size: 72,
                        color: Colors.green,
                      ),
                    ),
                  ), // Container
                ), // Expanded

                const SizedBox(width: 16),

                // Список ключевых функций ПО
                Expanded(
                  child: Container(
                    height: 160,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('1. Поиск отеля по городу и датам'),
                        SizedBox(height: 6),
                        Text('2. Бронирование номера'),
                        SizedBox(height: 6),
                        Text('3. Отзывы и рейтинг отеля'),
                        SizedBox(height: 6),
                        Text('4. Онлайн-оплата брони'),
                      ],
                    ), // Column
                  ), // Container
                ), // Expanded
              ],
            ), // Row

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),

            // Блок "Аватар" + "ФИО номер группы"
            Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.person, color: Colors.white),
                ), // CircleAvatar
                const SizedBox(width: 12),
                const Text(
                  'Чумак Д.Е., группа ИКБО-66-23',
                  style: TextStyle(fontSize: 16),
                ), // Text
              ],
            ), // Row
          ],
        ), // Column
      ), // SingleChildScrollView
    ); // Scaffold
  }
}