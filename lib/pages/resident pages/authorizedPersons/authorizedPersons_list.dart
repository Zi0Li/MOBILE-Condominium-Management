import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/repositories/AuthorizedPersons_Repository.dart';
import 'package:tcc/data/stores/AuthorizedPersons_Store.dart';
import 'package:tcc/pages/resident%20pages/authorizedPersons/authorizedPersons_form.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/resident_drawer.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';

class AuthorizedPersonsListPage extends StatefulWidget {
  const AuthorizedPersonsListPage({super.key});

  @override
  State<AuthorizedPersonsListPage> createState() =>
      _AuthorizedPersonsListPageState();
}

class _AuthorizedPersonsListPageState extends State<AuthorizedPersonsListPage> {
  @override
  void initState() {
    super.initState();
    _getAuthorizedPersons();
  }

  final AuthorizedPersonsStore store = AuthorizedPersonsStore(
    repository: AuthorizedPersonsRepository(
      client: HttpClient(),
    ),
  );

  int _contList = 0;
  bool teste = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      drawer: ResidentDrawerApp(),
      appBar: AppBarWidget(
        title: 'Pessoas autorizadas (${_contList}/4)',
        actions: [
          (_contList != 4)
              ? IconButton(
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
                    size: 28,
                  ),
                )
              : Container()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: AnimatedBuilder(
          animation:
              Listenable.merge([store.erro, store.isLoading, store.state]),
          builder: (context, child) {
            if (store.isLoading.value) {
              return Center(
                child: WidgetLoading.containerLoading(),
              );
            } else if (store.erro.value.isNotEmpty) {
              return WidgetError.containerError(
                  store.erro.value, () => store.erro.value = '');
            } else {
              return _body();
            }
          },
        ),
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
      itemCount: store.state.value.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AuthorizedPersonsAddPage(
                  authorizedPersons: store.state.value[index],
                ),
              ),
            );
          },
          title: Text(
            store.state.value[index].name!,
            style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
          ),
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(width: 1, color: Config.grey400),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                Config.logoName(store.state.value[index].name!).toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          subtitle: Text(store.state.value[index].kinship!),
        );
      },
    );
  }

  void _getAuthorizedPersons() {
    store.getAuthorizedPersonsByResident(Config.user.id).then((value) {
      setState(() {
        _contList = value.length;
      });
    });
  }
}
