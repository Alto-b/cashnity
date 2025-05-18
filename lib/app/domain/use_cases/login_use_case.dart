import 'package:cashnity/app/domain/entities/user_entity.dart';
import 'package:cashnity/app/domain/repositories/login_repository.dart';
import 'package:either_dart/either.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<Either<String, UserEntity>> call(String email, String password) {
    return repository.loginUser(email, password);
  }
}
