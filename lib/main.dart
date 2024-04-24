import 'package:flutter/material.dart';
import 'package:tcc/Teste.dart';
import 'package:tcc/pages/acesss/login.dart';
import 'package:tcc/pages/acesss/register_condo.dart';
import 'package:tcc/pages/acesss/welcome.dart';
import 'package:tcc/pages/home.dart';

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
    return Scaffold(body: RegisterCondoPage());
  }
}