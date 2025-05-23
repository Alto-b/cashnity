// lib/domain/entities/user_entity.dart

class UserEntity {
  final String id;
  final String name;
  final String email;
  final String password;
  final String employmentStatus;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.employmentStatus,
  });
}
