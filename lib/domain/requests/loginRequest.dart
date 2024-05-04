import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> login(String username, String password, void Function() rerun) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('users');

  try {
    var querySnapshot = await users.where('username', isEqualTo: username).get();
    if (querySnapshot.docs.isEmpty) {
      return false; // Пользователь не найден
    }

    var user = querySnapshot.docs.first;
    if (user['password'] == password) {
      // Пароль совпадает, сохраняем данные в SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', user.id);
      await prefs.setString('username', username);
      await prefs.setString('email', user['email']);
      // Можно сохранить и другие необходимые данные
      return true;
    } else {
      return false; // Пароль не совпадает
    }
  } catch (e) {
    print("Error logging in: $e");
    rerun();
    return false;
  }
}
