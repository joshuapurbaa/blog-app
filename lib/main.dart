import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';

void main() async {
  await initDependencies();
  runApp(
    const App(),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const SignInPage(),
    );
  }
}
