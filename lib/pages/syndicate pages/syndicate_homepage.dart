import 'package:flutter/material.dart';
import 'package:tcc/data/controllers/Login_Controller.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/repositories/Syndicate_Repository.dart';
import 'package:tcc/data/stores/Syndicate_Store.dart';
import 'package:tcc/pages/acesss/welcome.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawer.dart';
import 'package:tcc/widgets/loading.dart';

class SyndicateHomePage extends StatefulWidget {
  const SyndicateHomePage({super.key});

  @override
  State<SyndicateHomePage> createState() => _SyndicateHomePageState();
}

class _SyndicateHomePageState extends State<SyndicateHomePage> {
  SyndicateStore syndicateStore = SyndicateStore(
    repository: SyndicateRepository(
      client: HttpClient(),
    ),
  );

  int contAuthorizedPersons = 0;

  @override
  void initState() {
    super.initState();
    _getSyndicate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      drawer: DrawerApp(),
      appBar: AppBar(
        backgroundColor: Config.backgroundColor,
        toolbarHeight: 56,
        title: Text(
          'Tela inicial',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Config.orange,
          ),
        ),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            syndicateStore.erro,
            syndicateStore.isLoading,
            syndicateStore.state,
          ]),
          builder: (context, child) {
            if (syndicateStore.isLoading.value) {
              return WidgetLoading.containerLoading();
            } else {
              return _body();
            }
          },
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: 'Pessoas autorizadas ',
                  style: TextStyle(
                    color: Config.grey_letter,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(
                      text: '0/4',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Config.grey400,
              ),
              Divider(
                color: Config.grey400,
              ),
              Text(
                'Próxima reserva',
                style: TextStyle(
                  color: Config.grey_letter,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _getSyndicate() {
    syndicateStore.isLoading.value = true;
    LoginController.internal().getAllLogins().then((value) {
      print('VALUE LOGIN - $value');
      if (value.isNotEmpty) {
        syndicateStore.getSyndicateById(value.first.id).then((syndicate) {
          Config.user = syndicateStore.state.value.first;
        });
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomePage(),
          ),
        );
      }
    });
  }
}
