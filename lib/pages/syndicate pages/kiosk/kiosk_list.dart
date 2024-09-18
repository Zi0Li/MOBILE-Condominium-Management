import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/models/Kiosk.dart';
import 'package:tcc/data/repositories/Kiosk_repository.dart';
import 'package:tcc/data/repositories/Syndicate_Repository.dart';
import 'package:tcc/data/stores/Kiosk_Store.dart';
import 'package:tcc/data/stores/Syndicate_Store.dart';
import 'package:tcc/pages/syndicate%20pages/kiosk/kiosk_form.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/syndicate_drawer.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';

class KioskListPage extends StatefulWidget {
  const KioskListPage({super.key});

  @override
  State<KioskListPage> createState() => _KioskListPageState();
}

class _KioskListPageState extends State<KioskListPage> {
  List<Condominium> condominiums = [];
  List<Kiosk> kiosks = [];
  Condominium? selectCondominium;

  SyndicateStore syndicateStore = SyndicateStore(
    repository: SyndicateRepository(
      client: HttpClient(),
    ),
  );

  KioskStore kioskStore = KioskStore(
    repository: KioskRepository(
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
      backgroundColor: Config.white,
      drawer: SyndicateDrawerApp(),
      appBar: AppBarWidget(
        title: 'Quiosques',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KioskFormPage(
                    condominium: selectCondominium,
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
      body: AnimatedBuilder(
        animation: Listenable.merge(
          [
            syndicateStore.erro,
            syndicateStore.isLoading,
            syndicateStore.state,
          ],
        ),
        builder: (context, child) {
          if (syndicateStore.isLoading.value) {
            return Center(
              child: WidgetLoading.containerLoading(),
            );
          } else if (syndicateStore.erro.value.isNotEmpty) {
            return WidgetError.containerError(
              syndicateStore.erro.value,
              () {
                syndicateStore.erro.value = '';
              },
            );
          } else {
            return _body();
          }
        },
      ),
    );
  }

  Widget _body() {
    return Padding(
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
              _getKiosks(newValue.id!);
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
          Divider(),
          ListView.builder(
            itemCount: kiosks.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => _kioskCard(index),
          )
        ],
      ),
    );
  }

  Widget _kioskCard(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KioskFormPage(
              condominium: selectCondominium,
              kiosk: kiosks[index],
            ),
          ),
        ),
        title: Text(kiosks[index].type!),
        subtitle: Text(kiosks[index].description!),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Config.grey400,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _getCondominiums() {
    syndicateStore.getSyndicateById(Config.user.id).then((syndicate) {
      setState(() {
        condominiums = syndicate.first.condominiums!;
        selectCondominium = syndicate.first.condominiums!.first;
        _getKiosks(syndicate.first.condominiums!.first.id);
      });
    });
  }

  void _getKiosks(int id) {
    kioskStore.getAllKioskByCondominium(id).then((value) {
      setState(() {
        kiosks = value;
      });
    });
  }
}
