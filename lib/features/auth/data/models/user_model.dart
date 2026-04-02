import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fikr/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.email,
    required super.name,
    super.photoUrl,
    required super.createdAt,
    required super.isOnline,
  });

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      email: email,
      name: name,
      photoUrl: photoUrl,
      createdAt: createdAt,
      isOnline: isOnline,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      photoUrl: map['photoUrl'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      isOnline: map['isOnline'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'isOnline': isOnline,
    };
  }
}
