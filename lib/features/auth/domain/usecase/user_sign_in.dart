import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/auth_usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements AuthUsecase<User, UserSignInParams> {
  final AuthRepository repository;

  UserSignIn(this.repository);

  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await repository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  const UserSignInParams({
    required this.email,
    required this.password,
  });
}
