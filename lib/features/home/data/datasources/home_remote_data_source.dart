import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fikr/features/auth/data/models/user_model.dart';

class HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSource(this.firestore);

  Stream<List<UserModel>> getUsers() {
    return firestore.collection('users').snapshots().map((snap) {
      return snap.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    });
  }
}
