import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Syndicate.dart';
import 'package:tcc/data/repositories/Syndicate_Repository.dart';
import 'package:tcc/data/stores/Syndicate_Store.dart';
import 'package:tcc/pages/acesss/login.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/widgets/loading.dart';

class RegisterSyndicateLoginPage extends StatefulWidget {
  final Syndicate syndicate;
  RegisterSyndicateLoginPage({required this.syndicate, super.key});

  @override
  State<RegisterSyndicateLoginPage> createState() =>
      _RegisterSyndicateLoginPageState();
}

class _RegisterSyndicateLoginPageState
    extends State<RegisterSyndicateLoginPage> {
  SyndicateStore store = SyndicateStore(
    repository: SyndicateRepository(
      client: HttpClient(),
    ),
  );

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        backgroundColor: Config.orange,
        height: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Config.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SmartCondo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Config.light_purple,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Config.white),
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 10,
                              color: Config.light_purple,
                            ),
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Config.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Config.white,
                        size: 32,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  store.erro,
                  store.isLoading,
                  store.state,
                ]),
                builder: (context, child) {
                  if (store.erro.value.isNotEmpty) {
                    return WidgetError.containerError(
                      store.erro.value,
                      () => setState(() => store.erro.value = ""),
                    );
                  } else if (store.isLoading.value) {
                    return Center(
                      child: WidgetLoading.containerLoading(),
                    );
                  } else {
                    return _body();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login',
          style: TextStyle(
            fontSize: 22,
            color: Config.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        InputWidget(
          'E-mail',
          _emailController,
          TextInputType.emailAddress,
          Icons.email_outlined,
        ),
        InputWidget(
          'Senha',
          _passwordController,
          TextInputType.text,
          Icons.lock_outline,
          obscureText: true,
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: _register,
                child: Text(
                  'Próximo',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Config.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void _register() {
    dynamic syndicate = {
      "cpf": widget.syndicate.cpf,
      "name": widget.syndicate.name,
      "phone": widget.syndicate.phone,
      "rg": widget.syndicate.rg,
      "email": _emailController.text,
    };
    dynamic register = {
      "login": _emailController.text,
      "password": _passwordController.text,
      "role": Config.sindico,
      "user_id": 0
    };

    store.postSyndicateById(syndicate, register).then(
      (value) {
        if (store.erro.value.isEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        }
      },
    );
  }
}
