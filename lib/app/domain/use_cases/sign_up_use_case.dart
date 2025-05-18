// domain/usecases/sign_up_user_usecase.dart

import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class SignUpUserUseCase {
  final UserRepository repository;

  SignUpUserUseCase(this.repository);

  Future<String> call(UserEntity user, String password) {
    return repository.signUpUser(user, password);
  }
}
