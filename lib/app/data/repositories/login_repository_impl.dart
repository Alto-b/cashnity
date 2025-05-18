import 'package:cashnity/app/data/models/user_model.dart';
import 'package:cashnity/app/domain/entities/user_entity.dart';
import 'package:cashnity/app/domain/repositories/login_repository.dart';
import 'package:cashnity/app/domain/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';

class LoginRepositoryImpl implements LoginRepository {
  final FirebaseFirestore _firestore;

  LoginRepositoryImpl(this._firestore);

  @override
  Future<Either<String, UserEntity>> loginUser(
      String email, String password) async {
    try {
      final snapshot = await _firestore
          .collection('user_db')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return const Left("Email not found.");
      }

      final userMap = snapshot.docs.first.data();
      final user = UserModel.fromMap(userMap);

      if (user.password != password) {
        return const Left("Incorrect password.");
      }

      return Right(user);
    } catch (e) {
      return Left("Login failed: $e");
    }
  }
}
