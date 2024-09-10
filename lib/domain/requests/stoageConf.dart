import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<void> uploadFile() async {
  // Выбор файла из галереи
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    File file = File(pickedFile.path);
    try {
      // Загрузка файла в Firebase Storage
      await FirebaseStorage.instance
          .ref('uploads/${file.path.split('/').last}')
          .putFile(file);
      print('Файл успешно загружен!');
    } on FirebaseException catch (e) {
      print('Ошибка загрузки файла: $e');
    }
  }
}


Future<void> downloadFile() async {
  try {
    String downloadURL = await FirebaseStorage.instance
        .ref('uploads/your_file_name')
        .getDownloadURL();

    print('Ссылка для скачивания файла: $downloadURL');
  } on FirebaseException catch (e) {
    print('Ошибка при скачивании файла: $e');
  }
}


