import 'package:flutter/material.dart';
import 'package:my_uni/utils/constants.dart';
import 'package:my_uni/views/screens/pages_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: const PagesScreen(),
    );
  }
}
