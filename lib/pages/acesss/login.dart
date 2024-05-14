import 'package:flutter/material.dart';
import 'package:tcc/data/controllers/Login_Controller.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Login.dart';
import 'package:tcc/data/repositories/Authentication_Repository.dart';
import 'package:tcc/data/stores/Authentication_Store.dart';
import 'package:tcc/pages/acesss/register_condo.dart';
import 'package:tcc/pages/home.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/widgets/loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthenticationStore store = AuthenticationStore(
    repository: AuthenticationRepository(
      client: HttpClient(),
    ),
  );

  Login? login;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _checkBox = false;

  @override
  void initState() {
    super.initState();
    _getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        height: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: AnimatedBuilder(
            animation:
                Listenable.merge([store.state, store.isLoading, store.erro]),
            builder: (context, child) {
              if (store.erro.value.isNotEmpty) {
                return WidgetError.containerError(store.erro.value, () {
                  setState(() {
                    store.erro.value = '';
                  });
                });
              } else if (store.isLoading.value) {
                return WidgetLoading.containerLoading();
              } else {
                return _loginPage();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _loginPage() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'SmartCondo',
              style: TextStyle(
                color: Config.orange,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 130,
          ),
          Text(
            'Seja bem-vindo',
            style: TextStyle(
              color: Config.orange,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          InputWidget(
            'Email',
            _emailController,
            TextInputType.emailAddress,
            Icons.email_outlined,
          ),
          InputWidget(
            'Senha',
            _passwordController,
            TextInputType.text,
            Icons.lock_outlined,
            obscureText: true,
          ),
          Row(
            children: [
              Checkbox(
                checkColor: Config.white,
                side: BorderSide(color: Config.orange),
                activeColor: Config.orange,
                value: _checkBox,
                onChanged: (value) {
                  setState(() {
                    _checkBox = _checkBox ? false : true;
                  });
                },
              ),
              Text(
                "Lembrar-me",
                style: TextStyle(
                  color: Config.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Esqueci a senha',
                  style: TextStyle(
                    color: Config.orange,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.maxFinite,
              height: 52,
              child: TextButton(
                onPressed: () {
                  store
                      .getLogin(_emailController.text, _passwordController.text)
                      .then((value) {
                    if (value.isNotEmpty) {
                      _saveLogin();
                      _navigatorPage();
                    }
                  });
                },
                child: Text(
                  'Login',
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
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterCondoPage(),
                  ),
                );
              },
              child: Text(
                'ou Registra-se',
                style: TextStyle(
                  color: Config.grey800,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _navigatorPage() {
    if (store.state.value[0].role == Config.morador) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else if (store.state.value[0].role == Config.sindico) {
    } else if (store.state.value[0].role == Config.funcionario) {
    } else {}
  }

  void _saveLogin() {
    LoginController.internal().deletaAll();
    if (_checkBox) {
      LoginController.internal().saveLogin(
        Login(
          id: store.state.value[0].entity.id,
          email: _emailController.text,
          password: _passwordController.text,
          remember: (_checkBox) ? 1 : 0,
        ),
      );
    } else {
      LoginController.internal().saveLogin(
        Login(
          id: store.state.value[0].entity.id,
          email: "",
          password: "",
          remember: 0,
        ),
      );
    }
  }

  void _getLogin() {
    store.isLoading.value = true;
    LoginController.internal().getAllLogins().then((value) {
      if (value.isNotEmpty) {
        login = value[0];
        _emailController.text = login!.email!;
        _passwordController.text = login!.password!;
        _checkBox = (login!.remember == 1) ? true : false;
      }
      store.isLoading.value = false;
    });
  }
}
