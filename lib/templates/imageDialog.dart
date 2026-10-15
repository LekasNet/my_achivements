import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

void showImageDialog(BuildContext context ,String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            // Затемнение фона
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // Закрытие диалога при нажатии на фон
              },
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            // Окно с изображением
            Center(
              child: Image.network(imageUrl),
            ),
          ],
        ),
      );
    },
  );
}

// Функция для проверки расширения файла и отображения изображения
void onFileTap(BuildContext context ,Reference reference) async {
  String fileName = reference.name.toLowerCase();

  if (fileName.endsWith('.png') || fileName.endsWith('.jpg')) {
    try {
      String downloadUrl = await reference.getDownloadURL();
      showImageDialog(context, downloadUrl);
    } catch (e) {
      print('Ошибка загрузки изображения: $e');
    }
  } else {
    print('Это не изображение');
  }
}