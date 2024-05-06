// article_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> submitArticle({
  required String title,
  required String description,
  required String tags,
  required String imageUrl,
  required String category,
  DateTime? enddate
}) async {
  try {
    await FirebaseFirestore.instance.collection('articles').add({
      'title': title,
      'description': description,
      'tag': tags.split(',').map((tag) => tag.trim()).toList(),
      'image': imageUrl,
      'category': category,
      'isActive': true,
      'pubdate': FieldValue.serverTimestamp(),
      if (enddate != null) 'enddate': enddate,
    });
    print("Статья успешно добавлена");
  } catch (error) {
    print("Ошибка при добавлении статьи: $error");
    throw Exception('Ошибка при добавлении статьи');
  }
}

