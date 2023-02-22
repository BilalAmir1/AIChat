import 'package:chatgpt/home.dart';
import 'package:chatgpt/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHAT AI',
      home: splashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
