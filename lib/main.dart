import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:my_achivements/pages/tourList.dart';
import 'package:my_achivements/commons/colors.dart';
import 'package:my_achivements/templates/customAppBar.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Делаем статус бар прозрачным
      statusBarIconBrightness: Brightness.dark, // Темные иконки для светлого фона
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery
        .of(context)
        .platformBrightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark, // Автоматическое переключение цвета иконок
    ));
    return MaterialApp(
      title: 'Мои достижения',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: SafeArea(
            top: true,
            bottom: false,
            child: TourList()
        )
      ),
    );
  }
}


