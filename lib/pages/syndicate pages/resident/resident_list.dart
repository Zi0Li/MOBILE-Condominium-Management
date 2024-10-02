import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/data/repositories/Resident_Repository.dart';
import 'package:tcc/data/repositories/Syndicate_Repository.dart';
import 'package:tcc/data/stores/Resident_Store.dart';
import 'package:tcc/data/stores/Syndicate_Store.dart';
import 'package:tcc/pages/syndicate%20pages/resident/resident_view.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';

class ResidentListPage extends StatefulWidget {
  const ResidentListPage({super.key});

  @override
  State<ResidentListPage> createState() => _ResidentListPageState();
}

class _ResidentListPageState extends State<ResidentListPage> {
  List<Condominium> condominiums = [];
  List<Resident> residents = [];
  Condominium? selectCondominium;

  ResidentStore residentStore = ResidentStore(
    repository: ResidentRepository(
      client: HttpClient(),
    ),
  );

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
      backgroundColor: Config.white,
      drawer: Config.managersDrawer(),
      appBar: AppBarWidget(
        title: "Moradores",
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          residentStore.erro,
          residentStore.isLoading,
          residentStore.state,
        ]),
        builder: (context, child) {
          if (residentStore.isLoading.value) {
            return Center(
              child: WidgetLoading.containerLoading(),
            );
          } else if (residentStore.erro.value.isNotEmpty) {
            return WidgetError.containerError(
                residentStore.erro.value, () => residentStore.erro.value = '');
          } else {
            if (residentStore.state.value.isNotEmpty) {
              return _body();
            } else {
              return Center(
                child: Text(
                  "Nenhum morador cadastrado neste condomínio",
                  style: TextStyle(
                    color: Config.grey_letter,
                    fontSize: 16,
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
              _getResident(selectCondominium!.id!);
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
          Expanded(
            child: ListView.builder(
              itemCount: residents.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => _residentCard(
                residents[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _residentCard(Resident resident) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResidentViewPage(resident: resident),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Config.grey400,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Config.grey400,
                    ),
                    image: DecorationImage(
                      image: AssetImage('img/perfil.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              resident.name!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        resident.email!,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            resident.block!,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(" - "),
                          Text(
                            resident.apt!,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            resident.phone!,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getResident(int id) {
    residentStore.getResidentsByCondominium(id).then(
      (value) {
        residents = value;
      },
    );
  }

  void _getCondominiums() {
    syndicateStore.getSyndicateById(Config.user.id).then((syndicate) {
      setState(() {
        condominiums = syndicate.first.condominiums!;
        selectCondominium = syndicate.first.condominiums!.first;
        _getResident(selectCondominium!.id!);
      });
    });
  }
}
