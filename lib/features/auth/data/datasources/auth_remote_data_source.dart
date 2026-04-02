import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fikr/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSource(this.auth, this.firestore);

  Future<UserModel?> signUp(String name, String email, String password) async {
    final result = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user;
    if (user == null) return null;

    final newUser = UserModel(
      uid: user.uid,
      email: email,
      name: name,
      photoUrl: user.photoURL,
      createdAt: DateTime.now(),
      isOnline: true,
    );

    await firestore.collection('users').doc(user.uid).set(newUser.toMap());

    return newUser;
  }

  Future<UserModel?> login(String email, String password) async {
    var result = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final doc = await firestore.collection('users').doc(result.user!.uid).get();

    return UserModel.fromMap(doc.data()!);
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Stream<UserModel?> authState() {
    return auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;

      final doc = await firestore.collection('users').doc(user.uid).get();

      return UserModel.fromMap(doc.data()!);
    });
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
