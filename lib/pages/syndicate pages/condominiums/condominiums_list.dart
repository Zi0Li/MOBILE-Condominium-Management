import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/repositories/Syndicate_Repository.dart';
import 'package:tcc/data/stores/Syndicate_Store.dart';
import 'package:tcc/pages/syndicate%20pages/condominiums/condominiums_form.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/syndicate_drawer.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';

class CondominiumsList extends StatefulWidget {
  const CondominiumsList({super.key});

  @override
  State<CondominiumsList> createState() => _CondominiumsListState();
}

class _CondominiumsListState extends State<CondominiumsList> {
  SyndicateStore store = SyndicateStore(
    repository: SyndicateRepository(
      client: HttpClient(),
    ),
  );

  List<Condominium> condominiums = [];

  @override
  void initState() {
    super.initState();
    _getCondominiums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SyndicateDrawerApp(),
      appBar: AppBarWidget(
        title: 'Condominios',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CondominiumsShow(),
                ),
              );
            },
            icon: Icon(
              Icons.add,
              color: Config.orange,
              size: 28,
            ),
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.erro,
          store.isLoading,
          store.state,
        ]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return Center(
              child: WidgetLoading.containerLoading(),
            );
          } else if (store.erro.value.isNotEmpty) {
            return WidgetError.containerError(
                store.erro.value, () => store.erro.value = '');
          } else {
            if (condominiums.isNotEmpty) {
              return _body();
            } else {
              return Center(
                child: Text(
                  'Nenhuma condomínio cadastrado',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Wrap(
              children: [
                for (int i = 0; i < condominiums.length; i++)
                  _cardCondominium(condominiums[i])
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardCondominium(Condominium condominium) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CondominiumsShow(condominium: condominium),
          ),
        ),
        child: Container(
          width: 180,
          height: 100,
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
                  size: 45,
                  color: Config.orange,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        condominium.name!,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Text(
                        "Código: ${condominium.code!.toString()}",
                        style: TextStyle(
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getCondominiums() {
    store.getSyndicateById(Config.user.id).then(
      (value) {
        condominiums.addAll(value.first.condominiums);
      },
    );
  }
}
