import 'package:flutter/cupertino.dart';
import  'package:flutter/material.dart';
import 'dart:math';

import '../commons/GradientCard.dart';
import '../templates/inputDecoration.dart';
import '../templates/registrationMenu.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isLogin = true; // Состояние для переключения между логином и регистрацией

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Отступ от краёв экрана
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30), // Уменьшенное скругление рамки
            child: GradientCenterContainer(
              child: RegistrationProcess(),
            ),
          ),
        ),
      ),
    );
  }
}
