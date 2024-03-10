import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  AuthResult<User> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  AuthResult<User> loginWithEmailPassword({
    required String email,
    required String password,
  });
  AuthResult<User> currentUser();
}

typedef AuthResult<T> = Future<Either<Failure, T>>;
