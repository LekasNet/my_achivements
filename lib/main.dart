import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'firebase_options.dart';

import 'package:my_achievements/presentation/routes/navigator.dart';
import 'package:my_achievements/presentation/mainParent.dart';
import 'package:my_achievements/commons/theme.dart';



void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Делаем статус бар прозрачным
      statusBarIconBrightness: Brightness.light, // Темные иконки для светлого фона
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  initializeDateFormatting('ru_RU').then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery
        .of(context)
        .platformBrightness;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // statusBarIconBrightness: brightness == Brightness.dark
      //     ? Brightness.light
      //     : Brightness.dark, // Автоматическое переключение цвета иконок
      statusBarIconBrightness: Brightness.light
    ));
    return MaterialApp(
      title: 'Мои достижения',
      debugShowCheckedModeBanner: false,
      themeMode: AppTheme.themeMode,
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ru', 'RU'), // Русский язык
        // Другие поддерживаемые языки
      ],
      locale: const Locale('ru', 'RU'),
      home: ChangeNotifierProvider(
        create: (context) => TabManager(),
        child: const Scaffold(
            resizeToAvoidBottomInset: false,
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


