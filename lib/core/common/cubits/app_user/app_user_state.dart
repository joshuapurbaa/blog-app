part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedId extends AppUserState {
  final User user;

  AppUserLoggedId(this.user);
}
