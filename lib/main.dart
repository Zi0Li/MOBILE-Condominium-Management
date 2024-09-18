import 'package:flutter/material.dart';
import 'package:tcc/data/controllers/Login_Controller.dart';
import 'package:tcc/data/models/Login.dart';
import 'package:tcc/pages/acesss/login.dart';
import 'package:tcc/pages/acesss/welcome.dart';

void main(List<String> args) {
  runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Login? login;
  @override
  Widget build(BuildContext context) {

    _getLogin();

    return StreamBuilder(
      stream: Stream.value(login),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return WelcomePage();
        } else {
          return LoginPage(
            login: login,
          );
        }
      },
    );
  }

  void _getLogin() {
    LoginController.internal().getAllLogins().then((value) {
      if (value.isNotEmpty && value.first.remember == 1) {
        setState(() {
          login = value.first;
        });
      } else {
        login == null;
      }
    });
  }
}
