import 'package:cloud_firestore/cloud_firestore.dart';


Stream<List<DocumentSnapshot>> getArticles() {
  return FirebaseFirestore.instance
      .collection('articles')
      .orderBy('pubdate', descending: true) // Сортировка по дате публикации
      .snapshots()
      .asyncMap((snapshot) async {
    // Для каждого документа получаем тег и проверяем enddate
    var docs = snapshot.docs;
    await Future.forEach<DocumentSnapshot>(docs, (doc) async {
      var data = doc.data() as Map<String, dynamic>;
      // Проверяем и обновляем state
      if (data['enddate'] != null) {
        DateTime endDate = (data['enddate'] as Timestamp).toDate();
        if (endDate.isBefore(DateTime.now())) {
          // Обновляем state на false, если текущая дата позже enddate
          await doc.reference.update({'state': false});
        }
      }
    });
    return docs;
  });
}



