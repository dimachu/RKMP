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

/// Главный экран.
class HotelsInfoPage extends StatelessWidget {
  const HotelsInfoPage({super.key});

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
            // Заголовок
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
            // Описание ПО
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
            // Горизонтальный ListView со скруглёнными изображениями
            const ImageRow(),
            const SizedBox(height: 16),
            // Вертикальный ListView из карточек
            const FeatureList(),
            const SizedBox(height: 8),
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
                Flexible(
                  child: Text(
                    'Чумак Д.Е., группа ИКБО-66-23',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Горизонтальный список изображений со скруглёнными углами.
class ImageRow extends StatelessWidget {
  const ImageRow({super.key});

  static const List<String> images = [
    'assets/images/hotel1.png',
    'assets/images/hotel2.png',
    'assets/images/hotel3.png',
    'assets/images/hotel4.png',
    'assets/images/hotel.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // у горизонтального ListView высота должна быть задана
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                images[index],
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Вертикальный список функций приложения в виде карточек.
class FeatureList extends StatelessWidget {
  const FeatureList({super.key});

  static const List<String> titles = [
    'Поиск отеля по городу и датам',
    'Бронирование номера',
    'Отзывы и рейтинг отеля',
    'Онлайн-оплата брони',
  ];

  static const List<String> subtitles = [
    'Подбор вариантов под ваш запрос',
    'Выбор номера и оформление заявки',
    'Мнения гостей и оценки отелей',
    'Безопасная оплата со смартфона',
  ];

  static const List<IconData> icons = [
    Icons.search,
    Icons.bed,
    Icons.star,
    Icons.payment,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // вложенный список внутри прокручиваемого экрана
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Icon(icons[index], color: Colors.green),
            title: Text(titles[index]),
            subtitle: Text(subtitles[index]),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(titles[index]),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        );
      },
    );
  }
}