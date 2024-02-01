import 'package:flutter/material.dart';
import 'package:tcc/pages/acesss/welcome.dart';

void main(List<String> args) {
  runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomePage()
    );
  }
}
