import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyFirebasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('articles').doc('0').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Ошибка: ${snapshot.error}");
          }
          if (snapshot.hasData) {
            return Text("Данные: ${snapshot.data?['tag']}");
          } else {
            return Text("Данные не найдены");
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
