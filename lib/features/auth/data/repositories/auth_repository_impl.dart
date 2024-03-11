import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/constants/static_string.dart';
import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepoImpl(
    this.authRemoteDataSource,
    this.connectionChecker,
  );

  @override
  AuthResult<User> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = authRemoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure('User not logged in'));
        }

        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }

      final user = await authRemoteDataSource.getCurrentUserData();

      if (user == null) {
        return left(Failure('User not logged in'));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  AuthResult<User> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    final result = _getUser(
      () async => await authRemoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
    return result;
  }

  @override
  AuthResult<User> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) {
    final result = _getUser(
      () async => await authRemoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
    return result;
  }

  AuthResult<User> _getUser(Future<User> Function() fn) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(
          Failure(StaticString.noConnectionMessage),
        );
      }

      final result = await fn();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
