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


void SearchingQuery(String query) {
  print("Поиск по запросу: $query");  // Пример функции, замените на вашу реализацию
}