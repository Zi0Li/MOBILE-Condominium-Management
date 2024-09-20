import 'package:flutter/material.dart';
import 'package:tcc/data/controllers/Login_Controller.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Login.dart';
import 'package:tcc/data/repositories/Authentication_Repository.dart';
import 'package:tcc/data/stores/Authentication_Store.dart';
import 'package:tcc/pages/acesss/register_condo.dart';
import 'package:tcc/pages/employee%20pages/employee_homepage.dart';
import 'package:tcc/pages/resident%20pages/resident_homepage.dart';
import 'package:tcc/pages/syndicate%20pages/syndicate_homepage.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/widgets/loading.dart';

class LoginPage extends StatefulWidget {
  final Login? login;
  const LoginPage({this.login, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthenticationStore store = AuthenticationStore(
    repository: AuthenticationRepository(
      client: HttpClient(),
    ),
  );

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _checkBox = false;

  @override
  void initState() {
    super.initState();
    if (widget.login != null) {
      _emailController.text = widget.login!.email!;
      _passwordController.text = widget.login!.password!;
      _checkBox = (widget.login!.remember == 1) ? true : false;
    } else {
      _getLogin();
    }
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
                      print('TESTE');
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
                _managerOrResident(context);
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

  Future _managerOrResident(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Você é',
          style: TextStyle(color: Colors.black),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterCondoPage(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Config.grey400,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.people_alt_outlined,
                        color: Config.orange,
                        size: 32,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Morador',
                        style: TextStyle(color: Config.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Config.grey400,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.home_work_outlined,
                        color: Config.orange,
                        size: 32,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: Text(
                          'Síndico/Operário',
                          style: TextStyle(color: Config.black, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigatorPage() {
    Config.user = store.state.value[0].entity;
    if (store.state.value[0].role == Config.morador) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResidentHomePage(),
        ),
      );
    } else if (store.state.value[0].role == Config.sindico) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SyndicateHomePage(),
        ),
      );
    } else if (store.state.value[0].role == Config.funcionario) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeeHomepage(),
        ),
      );
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
    LoginController.internal().getAllLogins().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          _emailController.text = value.first.email!;
          _passwordController.text = value.first.password!;
          _checkBox = (value.first.remember == 1) ? true : false;
        });
      }
    });
  }
}
