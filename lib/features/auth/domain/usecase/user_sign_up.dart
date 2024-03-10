import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/auth_usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements AuthUsecase<User, UserSignUpParams> {
  final AuthRepository repository;

  UserSignUp(this.repository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await repository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  const UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
