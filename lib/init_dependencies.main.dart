part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(
    () => supabase.client,
  );

  // core

  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
}

void _initAuth() {
  // datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    // repository
    ..registerFactory<AuthRepository>(
      () => AuthRepoImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // usecase
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    // bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
