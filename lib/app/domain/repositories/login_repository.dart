import 'package:cashnity/app/domain/entities/user_entity.dart';
import 'package:either_dart/either.dart';

abstract class LoginRepository {
  Future<Either<String, UserEntity>> loginUser(String email, String password);
}
