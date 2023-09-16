import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'views/screens/pages_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: Student listelerken image url geçersizse debugda crash yiyor dibag kapatmak için sol alttan breackpoint kapatılabilir
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fırat Üniversitesi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: const PagesScreen(),
    );
  }
}
