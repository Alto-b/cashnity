// domain/repositories/user_repository.dart

import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<String> signUpUser(UserEntity user, String password);
  Future<UserEntity?> getUserProfile(String userId);
}
