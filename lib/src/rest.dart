import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FRRest {
  // * Create Model
  static Future<void> create({
    required Map<String, dynamic> data,
    required DocumentReference ref,
  }
  ) async {
    try {
      await ref.set(data);
    } catch (e) {
      rethrow;
    }
  }

  // * Update Model
  static Future<void> update({
    required Map<String, dynamic> data,
    required DocumentReference ref,
  }) async {
    try {
      return await ref.update(data);
    } catch (e) {
      rethrow;
    }
  }

  // * Fetch ONE Document and return MODEL
  static Future<T> fetchModel<T>({
    required DocumentReference ref,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    try {
      final snapshot = await ref.get();
      final data = snapshot.data();
      return fromMap(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  // * Fetch MANY Documents and return MODELs
  static Future<List<T>> fetchModels<T>({
    required Query query,
    required T Function(Map<String, dynamic>) fromMap,
    int? limit,
    DocumentSnapshot? lastDocumentSnapshot,
  }) async {
    var editableQuery = query;

    if (limit != null) {
      editableQuery = editableQuery.limit(limit);
    }

    if (lastDocumentSnapshot != null) {
      editableQuery = editableQuery.startAfterDocument(lastDocumentSnapshot);
    }

    try {
      final snapshots = await editableQuery.get();
      final List<T> models = [];

      for (var snapshot in snapshots.docs) {
        try {
          final model = fromMap(snapshot.data() as Map<String, dynamic>);
          models.add(model);
        } catch (e) {
          final map = snapshot.data() as Map<String, dynamic>;
          debugPrint('---------- Start ----------');
          debugPrint('error: ${e.toString()}');
          debugPrint('where: Fetch MODELs');
          debugPrint('query: ${query.parameters}');
          debugPrint('docID: ${map["id"]}');
          debugPrint('---------- End ----------');
        }
      }
      return models;
    } catch (e) {
      rethrow;
    }
  }

  // * Listen ONE Document and return MODEL
  static Stream<T> listenModel<T>({
    required DocumentReference ref,
    required T Function(Map<String, dynamic>) fromMap,
  }) {
    try {
      return ref
          .snapshots()
          .map((event) => fromMap(event.data() as Map<String, dynamic>));
    } catch (e) {
      rethrow;
    }
  }

  // * Fetch MANY Documents and return MODELs
  static Stream<List<T>> listenModels<T>({
    required Query query,
    required T Function(Map<String, dynamic>) fromMap,
    int? limit,
  }) {
    var editableQuery = query;

    if (limit != null) {
      editableQuery = editableQuery.limit(limit);
    }

    try {
      final snapshots = editableQuery.snapshots().map((snapshots) {
        final List<T> models = [];

        for (var snapshot in snapshots.docs) {
          try {
            final model = fromMap(snapshot.data() as Map<String, dynamic>);
            models.add(model);
          } catch (e) {
            final map = snapshot.data() as Map<String, dynamic>;
          debugPrint('---------- Start ----------');
          debugPrint('error: ${e.toString()}');
          debugPrint('where: Listen MODELs');
          debugPrint('query: ${query.parameters}');
          debugPrint('docID: ${map["id"]}');
          debugPrint('---------- End ----------');
          }
        }
        return models;
      });
      return snapshots;
    } catch (e) {
      rethrow;
    }
  }
}
