import 'package:equatable/equatable.dart';

enum UserRole { user, admin }

class UserModel extends Equatable {
  final String id;
  final String email;
  final String username;
  final String displayName;
  final String? photoUrl;
  final String? bio;
  final UserRole role;
  final List<String> followers;
  final List<String> following;
  final DateTime createdAt;
  final bool isVerified;

  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.displayName,
    this.photoUrl,
    this.bio,
    this.role = UserRole.user,
    this.followers = const [],
    this.following = const [],
    required this.createdAt,
    this.isVerified = false,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      email: data['email']?? '',
      username: data['username']?? '',
      displayName: data['displayName']?? '',
      photoUrl: data['photoUrl'],
      bio: data['bio'],
      role: data['role'] == 'admin'? UserRole.admin : UserRole.user,
      followers: List<String>.from(data['followers']?? []),
      following: List<String>.from(data['following']?? []),
      createdAt: DateTime.parse(data['createdAt']),
      isVerified: data['isVerified']?? false,
    );
  }

  Map<String, dynamic> toMap() => {
    'email': email,
    'username': username,
    'displayName': displayName,
    'photoUrl': photoUrl,
    'bio': bio,
    'role': role.name,
    'followers': followers,
    'following': following,
    'createdAt': createdAt.toIso8601String(),
    'isVerified': isVerified,
  };

  @override
  List<Object?> get props => [id, email, username];
}
