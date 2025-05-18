// domain/usecases/get_user_profile_usecase.dart

import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<UserEntity?> call(String userId) {
    return repository.getUserProfile(userId);
  }
}
