import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/models/Correspondence.dart';
import 'package:tcc/data/repositories/Correspondence_Repository.dart';
import 'package:tcc/data/repositories/Syndicate_Repository.dart';
import 'package:tcc/data/stores/Correspondence_Store.dart';
import 'package:tcc/data/stores/Syndicate_Store.dart';
import 'package:tcc/pages/syndicate%20pages/correspondence/correspondence_add.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';
import 'package:tcc/widgets/showDialog.dart';
import 'package:tcc/widgets/snackMessage.dart';

class CorrespondenceListPage extends StatefulWidget {
  const CorrespondenceListPage({super.key});

  @override
  State<CorrespondenceListPage> createState() => _CorrespondenceListPageState();
}

class _CorrespondenceListPageState extends State<CorrespondenceListPage> {
  Condominium? selectCondominium;
  List<Condominium> condominiums = [];
  List<Correspondence> correspondences = [];

  SyndicateStore syndicateStore = SyndicateStore(
    repository: SyndicateRepository(
      client: HttpClient(),
    ),
  );

  CorrespondenceStore correspondenceStore = CorrespondenceStore(
    repository: CorrespondenceRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    condominiums = Config.user.condominiums;
    selectCondominium = Config.user.condominiums.first;
    _getCorrespondece();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      drawer: Config.managersDrawer(),
      appBar: AppBarWidget(
        title: "Correspondências",
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CorrespondenceAddPage(
                    condominium: selectCondominium!,
                  ),
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
                _getCorrespondece();
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
              animation: Listenable.merge([
                correspondenceStore.isLoading,
                correspondenceStore.erro,
                correspondenceStore.state,
              ]),
              builder: (context, child) {
                if (correspondenceStore.isLoading.value) {
                  return Center(
                    child: WidgetLoading.containerLoading(),
                  );
                } else if (correspondenceStore.erro.value.isNotEmpty) {
                  return WidgetError.containerError(
                      correspondenceStore.erro.value, () {
                    setState(() {
                      correspondenceStore.erro.value;
                    });
                  });
                } else {
                  if (correspondences.isNotEmpty) {
                    return _body();
                  } else {
                    return Center(
                      child: Text('Sem nenhuma correspondência cadastrada'),
                    );
                  }
                }
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
        itemCount: correspondences.length,
        itemBuilder: (context, index) =>
            _cardCorrespondence(correspondences[index]),
      ),
    );
  }

  Widget _cardCorrespondence(Correspondence correspondence) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        WidgetShowDialog.DeleteShowDialog(
          context,
          "a correspondência? ",
          Icons.delete,
          () => _deleteCorrespondence(correspondence.id!),
        );
      },
      child: Padding(
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
                              correspondence.sender!,
                              16,
                            ),
                          ),
                        ],
                      ),
                      Config.text(
                        'Entregue: ',
                        correspondence.date!,
                        16,
                      ),
                      Config.text(
                        'Chegou: ',
                        correspondence.hours!,
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
                              border:
                                  Border.all(width: 1, color: Config.grey400),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                Config.logoName(correspondence.resident!.name!)
                                    .toUpperCase(),
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
                                correspondence.resident!.name!,
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '${correspondence.resident!.block!}-${correspondence.resident!.apt!}',
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
      ),
    );
  }

  void _getCorrespondece() {
    correspondenceStore.findByIdCondominium(selectCondominium!.id!).then(
      (value) {
        setState(() {
          correspondences = value;
        });
      },
    );
  }

  void _deleteCorrespondence(int id) {
    correspondenceStore.delete(id).then(
      (value) {
        if (correspondenceStore.erro.value.isEmpty) {
          WidgetSnackMessage.notificationSnackMessage(
            context: context,
            mensage: "Correspondência deletada com sucesso",
            icon: Icons.check,
          );
          _getCorrespondece();
        } else {
          WidgetSnackMessage.notificationSnackMessage(
            context: context,
            mensage: "Ops, ocorreu um erro!",
            icon: Icons.close,
            backgroundColor: Config.red,
          );
        }
        Navigator.pop(context);
      },
    );
  }
}
