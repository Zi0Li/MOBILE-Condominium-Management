import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Correspondence.dart';
import 'package:tcc/data/repositories/Correspondence_Repository.dart';
import 'package:tcc/data/stores/Correspondence_Store.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/resident_drawer.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';

class CorrespondencePage extends StatefulWidget {
  const CorrespondencePage({super.key});

  @override
  State<CorrespondencePage> createState() => _CorrespondencePageState();
}

class _CorrespondencePageState extends State<CorrespondencePage> {
  CorrespondenceStore store = CorrespondenceStore(
    repository: CorrespondenceRepository(
      client: HttpClient(),
    ),
  );

  List<Correspondence> _correspondences = [];

  @override
  void initState() {
    super.initState();
    _getCorrespondenceByIdResident();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      drawer: ResidentDrawerApp(),
      appBar: AppBarWidget(
        title: 'Correspondências',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: AnimatedBuilder(
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
                store.erro.value,
                () => setState(() {
                  store.erro.value = '';
                }),
              );
            } else {
              if (_correspondences.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: _correspondences.length,
                  itemBuilder: (context, index) =>
                      _cardCorrespondence(_correspondences[index]),
                );
              } else {
                return Center(
                  child: Text('Sem nenhuma correspondencia'),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget _cardCorrespondence(Correspondence correspondence) {
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
                height: 100,
                width: 120,
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
                    Config.text(
                      'Retirar: ',
                      '5 dias',
                      16,
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

  void _getCorrespondenceByIdResident() {
    store.findByIdResident(Config.user.id).then(
      (value) {
        _correspondences = value;
      },
    );
  }
}
