import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/repositories/Syndicate_Repository.dart';
import 'package:tcc/data/stores/Syndicate_Store.dart';
import 'package:tcc/pages/syndicate%20pages/correspondence/correspondence_add.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/syndicate_drawer.dart';

class CorrespondenceListPage extends StatefulWidget {
  const CorrespondenceListPage({super.key});

  @override
  State<CorrespondenceListPage> createState() => _CorrespondenceListPageState();
}

class _CorrespondenceListPageState extends State<CorrespondenceListPage> {
  Condominium? selectCondominium;
  List<Condominium> condominiums = [];

  SyndicateStore syndicateStore = SyndicateStore(
    repository: SyndicateRepository(
      client: HttpClient(),
    ),
  );

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
        title: "Correspondências",
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CorrespondenceAddPage(),
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<Condominium>(
              value: selectCondominium,
              style: TextStyle(
                color: Config.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              onChanged: (Condominium? newValue) => setState(() {
                selectCondominium = newValue!;
              }),
              items: condominiums
                  .map<DropdownMenuItem<Condominium>>(
                    (Condominium? value) => DropdownMenuItem<Condominium>(
                      value: value,
                      child: Text(value!.name!),
                    ),
                  )
                  .toList(),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 42,
              underline: SizedBox(),
            ),
            AnimatedBuilder(
              animation: Listenable.merge([]),
              builder: (context, child) {
                return _body();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) => _cardCorrespondence(),
      ),
    );
  }

  Widget _cardCorrespondence() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2.5,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Config.grey400,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'img/correios.jpg',
                fit: BoxFit.fill,
                height: 130,
                width: 150,
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: screenWidth * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Config.text(
                            'Remetente: ',
                            'Mercado livre',
                            16,
                          ),
                        ),
                      ],
                    ),
                    Config.text(
                      'Entregue: ',
                      '12/04/2002',
                      16,
                    ),
                    Config.text(
                      'Chegou: ',
                      '12:34',
                      16,
                    ),
                    Divider(),
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(width: 1, color: Config.grey400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              Config.logoName("Nome do morador").toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Nome do morador',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Bloco-apt',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getCondominiums() {
    syndicateStore.getSyndicateById(Config.user.id).then((syndicate) {
      setState(() {
        condominiums = syndicate.first.condominiums!;
        selectCondominium = syndicate.first.condominiums!.first;
      });
    });
  }
}
