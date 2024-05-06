import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId') != null;  // Проверяем, сохранён ли идентификатор пользователя
  }
}


final cardBorders = BorderRadius.circular(10);

var pageName = 'Новости';

const List<String> roles = ["Школьник", "Студент", "Гражданин"];

Color color = Color(0xFF262E57);