// data/repositories/user_repository_impl.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser(UserEntity user, String password) async {
    try {
      final userId = const Uuid().v4();
      print('[signUpUser] Generated User ID: $userId');

      final userModel = UserModel(
        id: userId,
        name: user.name,
        email: user.email,
        password: password,
        employmentStatus: user.employmentStatus,
      );

      final userMap = userModel.toMap();

      await _firestore.collection('user_db').doc(userId).set(userMap);

      return "Success";
    } on FirebaseException catch (e) {
      return e.message ?? "Firebase error";
    } catch (e) {
      return "An unexpected error occurred";
    }
  }

  @override
  Future<UserEntity?> getUserProfile(String userId) async {
    try {
      final snapshot = await _firestore.collection('user_db').doc(userId).get();
      if (snapshot.exists) {
        return UserModel.fromMap(snapshot.data()!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
