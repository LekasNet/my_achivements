// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// Future<bool> adminCheck(String username, String password) async {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   CollectionReference users = db.collection('users');
//
//   try {
//     var querySnapshot = await users.where('username', isEqualTo: username).get();
//     if (querySnapshot.docs.isEmpty) {
//       return false; // Пользователь не найден
//     }
//
//     var user = querySnapshot.docs.first;
//     if (user['password'] == password) {
//       if (user['admin'] != null) return true;
//       return false;
//     } else {
//       return false; // Пароль не совпадает
//     }
//   } catch (e) {
//     print("Error logging in: $e");
//     return false;
//   }
// }