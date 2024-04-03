import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.green,
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFFFFF),
    surfaceTint: Colors.transparent,
  ),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  cardTheme: CardTheme(
    color: const Color(0xFFF6F6F6),
    shadowColor: Colors.grey,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4), // Радиус скругления углов карточки
      side: const BorderSide(
        color: Colors.grey, // Цвет границы
        width: 1, // Толщина границы в пикселях
      ),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xF5525252),
);
