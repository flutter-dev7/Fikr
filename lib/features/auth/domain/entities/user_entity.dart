class UserEntity {
  final String uid;
  final String email;
  final String name;
  final String? photoUrl;
  final DateTime createdAt;
  final bool isOnline;

  UserEntity({
    required this.uid,
    required this.email,
    required this.name,
    this.photoUrl,
    required this.createdAt,
    required this.isOnline,
  });
}
