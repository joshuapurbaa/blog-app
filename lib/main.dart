import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(
          AuthIsUserLoggedInEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          print('state main ::: $state');
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          print('isLoggedIn main ::: $isLoggedIn');
          if (isLoggedIn) {
            return const Scaffold(
              body: Center(
                child: Text('User is logged in.'),
              ),
            );
          } else {
            return const SignInPage();
          }
        },
      ),
    );
  }
}
