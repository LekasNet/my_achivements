import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:my_achievements/presentation/routes/navigator.dart';
import 'package:my_achievements/presentation/mainParent.dart';
import 'package:my_achievements/commons/theme.dart';



void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Делаем статус бар прозрачным
      statusBarIconBrightness: Brightness.dark, // Темные иконки для светлого фона
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
      themeMode: AppTheme.themeMode,
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      home: ChangeNotifierProvider(
        create: (context) => TabManager(),
        child: Scaffold(
          body: SafeArea(
              top: true,
              bottom: false,
              child: MainParentBuilder(),
          )
        ),
      ),
    );
  }
}


