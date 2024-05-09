import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/repositories/AuthorizedPersons_Repository.dart';
import 'package:tcc/data/stores/AuthorizedPersons_Store.dart';
import 'package:tcc/pages/authorizedPersons.dart/authorizedPersons_add.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawer.dart';
import 'package:tcc/widgets/loading.dart';

class AuthorizedPersonsListPage extends StatefulWidget {
  const AuthorizedPersonsListPage({super.key});

  @override
  State<AuthorizedPersonsListPage> createState() =>
      _AuthorizedPersonsListPageState();
}

class _AuthorizedPersonsListPageState extends State<AuthorizedPersonsListPage> {
  final AuthorizedPersonsStore store = AuthorizedPersonsStore(
    repository: AuthorizedPersonsRepository(
      client: HttpClient(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      drawer: DrawerApp(),
      appBar: AppBarWidget(
        title: 'Pessoas autorizadas (${Config.resident.authorizedPersons.length}/4)',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthorizedPersonsAddPage(),
                ),
              );
            },
            icon: Icon(
              Icons.add,
              color: Config.orange,
            ),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: AnimatedBuilder(
            animation:
                Listenable.merge([store.erro, store.isLoading, store.state]),
            builder: (context, child) {
              if (store.isLoading.value) {
                return WidgetLoading.containerLoading();
              } else {
                return _body();
              }
            },
          )),
    );
  }

  Widget _body() {
    return ListView.builder(
      itemCount: Config.resident.authorizedPersons.length,
      itemBuilder: (context, index) {
        List<String> aux = Config.resident.authorizedPersons[index].name.split(' ');
        String logoName = aux[0][0];
        logoName += aux[aux.length - 1][0];
        return ListTile(
          onLongPress: () {},
          title: Text(
            Config.resident.authorizedPersons[index].name!,
            style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
          ),
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: Config.grey400),
            ),
            child: Center(
              child: Text(
                logoName.toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          subtitle: Text(Config.resident.authorizedPersons[index].kinship!),
        );
      },
    );
  }
}