import 'package:flutter/material.dart';
import 'package:login_with_bloc/pages/home.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Name',
      home: HomePage(),
    );
  }
}
