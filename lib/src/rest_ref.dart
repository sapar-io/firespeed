import 'package:cloud_firestore/cloud_firestore.dart';

class FRRef {
  static final root = FirebaseFirestore.instance;
  static collection(String collectionPath) => root.collection(collectionPath);
  static doc(String collectionPath, String documentPath) =>
      root.collection(collectionPath).doc(documentPath);
}
