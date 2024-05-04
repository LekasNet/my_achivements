import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveUserData({
  required String email,
  required String username,
  required String password,
  required String lastName,
  required String firstName,
  String? middleName,
  required DateTime dateOfBirth,
  required String role,
  bool isActive = true,
}) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('users');

  return await users.add({
    'email': email,
    'username': username,
    'password': password,  // Обычно пароли не хранят в базе данных в открытом виде!
    'lastName': lastName,
    'firstName': firstName,
    'middleName': middleName ?? 'Отсутствует',
    'dateOfBirth': dateOfBirth,
    'role': role,
    'isActive': isActive
  }).then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
