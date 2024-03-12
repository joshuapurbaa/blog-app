import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  static route() {
    return MaterialPageRoute<void>(
      builder: (_) => const BlogPage(),
    );
  }

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Blog Page'),
      ),
    );
  }
}
