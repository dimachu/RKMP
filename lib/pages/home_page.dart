import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/hotel_feature.dart';
import '../routes.dart';
import 'profile_page.dart';

/// Основной экран с нижней панелью навигации (NavigationBar).
/// Вкладка 0 — главная, вкладка 1 — профиль.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  /// Переход на экран детализации. Если там нажали пункт
  /// NavigationBar, экран вернёт его индекс — переключаем вкладку.
  Future<void> _openDetail(HotelFeature feature) async {
    final result =
        await Navigator.pushNamed(context, Routes.detail, arguments: feature);
    if (!mounted) return;
    if (result is int) {
      setState(() => _selectedIndex = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HotelsInfoPage(onOpenDetail: _openDetail),
          ProfilePage(onBack: () => setState(() => _selectedIndex = 0)),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.green.shade50,
        indicatorColor: Colors.green.shade200,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
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

/// Содержимое главной вкладки (код основного экрана из практической №4).
class HotelsInfoPage extends StatelessWidget {
  final ValueChanged<HotelFeature> onOpenDetail;

  const HotelsInfoPage({super.key, required this.onOpenDetail});

  @override
  Widget build(BuildContext context) {
    // Адаптивность по платформе: на десктопе и в вебе отступы больше
    final bool isDesktopOrWeb = kIsWeb ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux;
    final double platformPadding = isDesktopOrWeb ? 40 : 16;

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
            SizedBox(height: platformPadding),
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
            SizedBox(height: platformPadding),
            // Горизонтальный ListView со скруглёнными изображениями
            const ImageRow(),
            SizedBox(height: platformPadding),
            // Карточки пунктов: список или сетка в 2 столбца
            FeatureList(
              onTap: onOpenDetail,
              spacing: platformPadding / 2,
            ),
            SizedBox(height: platformPadding / 2),
            const Divider(),
            SizedBox(height: platformPadding / 2),
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

/// Карточки пунктов основного экрана.
/// Ширина экрана > 600 — сетка в 2 столбца (GridView), иначе — список.
class FeatureList extends StatelessWidget {
  final ValueChanged<HotelFeature> onTap;
  final double spacing;

  const FeatureList({super.key, required this.onTap, this.spacing = 8});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width > 600) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: hotelFeatures.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 80, // высота карточки
          crossAxisSpacing: 12,
          mainAxisSpacing: spacing,
        ),
        itemBuilder: (context, index) =>
            _FeatureCard(feature: hotelFeatures[index], onTap: onTap),
      );
    }

    return ListView.separated(
      // вложенный список внутри прокручиваемого экрана
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hotelFeatures.length,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) =>
          _FeatureCard(feature: hotelFeatures[index], onTap: onTap),
    );
  }
}

/// Одна карточка пункта.
class _FeatureCard extends StatelessWidget {
  final HotelFeature feature;
  final ValueChanged<HotelFeature> onTap;

  const _FeatureCard({required this.feature, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Center(
        child: ListTile(
          leading: Icon(feature.icon, color: Colors.green),
          title: Text(feature.title,
              maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(feature.subtitle,
              maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          onTap: () => onTap(feature),
        ),
      ),
    );
  }
}
