import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Syndicate.dart';
import 'package:tcc/data/repositories/Authentication_Repository.dart';
import 'package:tcc/data/repositories/Syndicate_Repository.dart';
import 'package:tcc/data/stores/Authentication_Store.dart';
import 'package:tcc/data/stores/Syndicate_Store.dart';

class TestePage extends StatefulWidget {
  const TestePage({super.key});

  @override
  State<TestePage> createState() => _TestePageState();
}

class _TestePageState extends State<TestePage> {

  final AuthenticationStore store = AuthenticationStore(
    repository: AuthenticationRepository(
      client: HttpClient(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TESTE')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              store.getSyndicate().then((value){
                print(value);
                print(token);
              });
            },
            child: Text('TESTE'),
          ),
        ],
      ),
    );
  }
}
