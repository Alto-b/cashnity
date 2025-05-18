// lib/data/models/user_model.dart

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String email,
    required String password,
    required String employmentStatus,
  }) : super(
          id: id,
          name: name,
          email: email,
          password: password,
          employmentStatus: employmentStatus,
        );

  // From Firestore
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'],
      employmentStatus: map['employment_status'] ?? '',
    );
  }

  // To Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'employment_status': employmentStatus,
    };
  }
}
