import 'package:cloud_firestore/cloud_firestore.dart';
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
      await prefs.setString('lastName', user['lastName']);
      await prefs.setString('firstName', user['firstName']);
      await prefs.setString('middleName', user['middleName']);
      await prefs.setString('role', user['role']);
      if (user['admin'] != null) await prefs.setBool('isAdmin', user['admin']);
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
