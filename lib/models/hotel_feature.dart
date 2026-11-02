import 'package:flutter/material.dart';

/// Пункт основного экрана (функция приложения).
class HotelFeature {
  final String title;
  final String subtitle;
  final IconData icon;
  final String image;
  final String description;

  const HotelFeature({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.image,
    required this.description,
  });
}

/// Список пунктов, которые выводятся на основном экране
/// и открываются на экране детализации.
const List<HotelFeature> hotelFeatures = [
  HotelFeature(
    title: 'Поиск отеля по городу и датам',
    subtitle: 'Подбор вариантов под ваш запрос',
    icon: Icons.search,
    image: 'assets/images/hotel1.png',
    description:
        'Пользователь указывает город, даты заезда и выезда, количество '
        'гостей, а приложение показывает список доступных отелей. Результаты '
        'можно отфильтровать по цене, рейтингу, расстоянию до центра и '
        'удобствам, а также посмотреть отели на карте.',
  ),
  HotelFeature(
    title: 'Бронирование номера',
    subtitle: 'Выбор номера и оформление заявки',
    icon: Icons.bed,
    image: 'assets/images/hotel2.png',
    description:
        'На странице отеля можно сравнить категории номеров, посмотреть '
        'фотографии, условия отмены и включённое питание. После выбора номера '
        'пользователь заполняет данные гостя и подтверждает бронирование за '
        'несколько нажатий.',
  ),
  HotelFeature(
    title: 'Отзывы и рейтинг отеля',
    subtitle: 'Мнения гостей и оценки отелей',
    icon: Icons.star,
    image: 'assets/images/hotel3.png',
    description:
        'Гости, которые уже проживали в отеле, оставляют оценки чистоты, '
        'сервиса, расположения и соотношения цены и качества. Средний рейтинг '
        'и отзывы помогают выбрать надёжный вариант.',
  ),
  HotelFeature(
    title: 'Онлайн-оплата брони',
    subtitle: 'Безопасная оплата со смартфона',
    icon: Icons.payment,
    image: 'assets/images/hotel4.png',
    description:
        'Бронирование можно оплатить банковской картой или через платёжные '
        'сервисы прямо в приложении. Данные карты передаются в защищённом '
        'виде, а чек и подтверждение брони приходят на электронную почту.',
  ),
];
