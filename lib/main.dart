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

/// Главный экран: StatefulWidget.
class HotelsInfoPage extends StatefulWidget {
  const HotelsInfoPage({super.key});

  @override
  State<HotelsInfoPage> createState() => _HotelsInfoPageState();
}

class _HotelsInfoPageState extends State<HotelsInfoPage> {
  static const List<String> _images = [
    'assets/images/hotel1.png',
    'assets/images/hotel2.png',
    'assets/images/hotel3.png',
    'assets/images/hotel4.png',
    'assets/images/hotel.png',
  ];

  // Индекс текущей картинки — состояние виджета.
  int _currentIndex = 0;

  // Циклическая смена изображений.
  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Приложения для бронирования отелей',
          style: TextStyle(fontFamily: 'Pacifico', fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            ),
            const SizedBox(height: 16),
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
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // Смена картинки по нажатию на неё.
                  child: GestureDetector(
                    onTap: _nextImage,
                    child: Container(
                      height: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          _images[_currentIndex],
                          width: 300,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1. Поиск отеля по городу и датам'),
                        SizedBox(height: 8),
                        Text('2. Бронирование номера'),
                        SizedBox(height: 8),
                        Text('3. Отзывы и рейтинг отеля'),
                        SizedBox(height: 8),
                        Text('4. Онлайн-оплата брони'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Смена картинки по нажатию на кнопку.
            Center(
              child: ElevatedButton(
                onPressed: _nextImage,
                child: Text(
                  'Следующее фото (${_currentIndex + 1} из ${_images.length})',
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 12),
                Text(
                  'Чумак Д.Е., группа ИКБО-66-23',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}