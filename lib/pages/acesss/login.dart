import 'package:flutter/material.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 final TextEditingController _emailController = TextEditingController();
 final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.dark_purple,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Text('Login'),
              ),
              InputWidget(
                'Email',
                _emailController,
                TextInputType.emailAddress,
              ),
              InputWidget(
                'Senha',
                _passwordController,
                TextInputType.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
