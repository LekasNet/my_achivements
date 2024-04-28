import 'package:cloud_firestore/cloud_firestore.dart';

void getDataFromFirestore() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    DocumentSnapshot documentSnapshot = await firestore.collection('articles').doc('0').get();

    if (documentSnapshot.exists) {
      print('Document data: ${documentSnapshot.data()}');
    } else {
      print('Document does not exist!');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}


// Future<List<QueryDocumentSnapshot>> searchArticles(String searchQuery) async {
//   List<QueryDocumentSnapshot> combinedResults = [];
//
//   // Выполнение запроса по полю title
//   QuerySnapshot titleResults = await FirebaseFirestore.instance
//       .collection('articles')
//       .where('title', isEqualTo: searchQuery)
//       .get();
//   combinedResults.addAll(titleResults.docs);
//
//   // Выполнение запроса по полю description
//   QuerySnapshot descriptionResults = await FirebaseFirestore.instance
//       .collection('articles')
//       .where('description', isEqualTo: searchQuery)
//       .get();
//   combinedResults.addAll(descriptionResults.docs);
//
//   // Выполнение запроса по тегам, если searchQuery не пустой
//   if (searchQuery.isNotEmpty) {
//     QuerySnapshot tagResults = await FirebaseFirestore.instance
//         .collection('articles')
//         .where('tags', arrayContains: searchQuery)
//         .get();
//     combinedResults.addAll(tagResults.docs);
//   }
//
//   // Удаление возможных дубликатов
//   final ids = Set<String>();
//   combinedResults = combinedResults.where((doc) => ids.add(doc.id)).toList();
//
//   return combinedResults;
// }

Future<List<DocumentSnapshot>> searchArticles(String searchQuery) async {
  // Загрузка потенциально релевантных документов
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('articles')
      .get();

  // Фильтрация документов на стороне клиента
  var searchResults = snapshot.docs.where((doc) {
    final data = doc.data() as Map<String, dynamic>;
    final title = data['title'].toString().toLowerCase();
    final description = data['description'].toString().toLowerCase();
    // Можете добавить поиск по тегам, если это нужно
    return title.contains(searchQuery.toLowerCase()) || description.contains(searchQuery.toLowerCase());
  }).toList();

  return searchResults;
}
