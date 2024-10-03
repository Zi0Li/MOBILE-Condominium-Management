import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Correspondence.dart';
import 'package:tcc/data/models/Report.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/data/repositories/AuthorizedPersons_Repository.dart';
import 'package:tcc/data/repositories/Correspondence_Repository.dart';
import 'package:tcc/data/repositories/Report_Repository.dart';
import 'package:tcc/data/repositories/Resident_Repository.dart';
import 'package:tcc/data/stores/AuthorizedPersons_Store.dart';
import 'package:tcc/data/stores/Correspondence_Store.dart';
import 'package:tcc/data/stores/Report_Store.dart';
import 'package:tcc/data/stores/Resident_Store.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/employee_drawer.dart';
import 'package:tcc/widgets/loading.dart';

class EmployeeHomepage extends StatefulWidget {
  const EmployeeHomepage({super.key});

  @override
  State<EmployeeHomepage> createState() => _EmployeeHomepageState();
}

class _EmployeeHomepageState extends State<EmployeeHomepage> {
  CorrespondenceStore correspondenceStore = CorrespondenceStore(
    repository: CorrespondenceRepository(
      client: HttpClient(),
    ),
  );

  ReportStore reportStore = ReportStore(
    repository: ReportRepository(
      client: HttpClient(),
    ),
  );

  ResidentStore residentStore = ResidentStore(
    repository: ResidentRepository(
      client: HttpClient(),
    ),
  );

  AuthorizedPersonsStore authorizedPersonsStore = AuthorizedPersonsStore(
    repository: AuthorizedPersonsRepository(
      client: HttpClient(),
    ),
  );

  Resident? resident;
  var _searchController = new MaskedTextController(mask: '000.000.000-00');
  bool _search = false;
  List<Report> reportsTicket = [];
  List<Report> reportsAnonymous = [];
  List<Correspondence> correspondences = [];

  @override
  void initState() {
    super.initState();
    _updateInformations(Config.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      appBar: AppBarWidget(
        title: "Tela inicial",
      ),
      drawer: EmployeeDrawerApp(),
      body: _body(),
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
              _cardNotification(
                'Quantidade de correspondências na portaria: ${correspondences.length}',
                Icons.markunread_mailbox_outlined,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: _cardReport("Denúncias Anônimas",
                        Icons.person_off_outlined, reportsAnonymous.length),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: _cardReport("Reportes/Tickets",
                        Icons.report_gmailerrorred_sharp, reportsTicket.length),
                  ),
                ],
              ),
              Divider(
                color: Config.grey400,
              ),
              Text(
                'Consultar morador',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              _searchBody(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardNotification(String title, IconData icon) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Config.grey600,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                icon,
                color: Config.orange,
                size: 36,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Config.grey_letter,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardReport(String label, IconData icon, int listLenght) {
    return SizedBox(
      height: 80,
      child: Material(
        color: Config.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(color: Config.grey400),
        ),
        child: InkWell(
          splashColor: Config.orange,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      icon,
                      color: Config.orange,
                      size: 30,
                    ),
                    Text(
                      listLenght.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Config.black,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ), // <-- Icon
                Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Config.black),
                ), // <-- Text
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchBody() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _inputSearch(),
            AnimatedBuilder(
              animation: Listenable.merge([
                residentStore.erro,
                residentStore.isLoading,
                authorizedPersonsStore.erro,
                authorizedPersonsStore.isLoading,
              ]),
              builder: (context, child) {
                if (residentStore.isLoading.value ||
                    authorizedPersonsStore.isLoading.value) {
                  return Center(
                    child: WidgetLoading.containerLoading(),
                  );
                } else if (resident != null) {
                  if (resident!.authorizedPersons!.isEmpty) {
                    return _cardResident(resident!);
                  } else {
                    return _cardAuthorizedPerson(resident!);
                  }
                } else {
                  if (_search) {
                    _search = false;
                    return Column(
                      children: [
                        Divider(),
                        _statusCard(false),
                        Divider(),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Nenhuma pesquisa realizada!',
                        style: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputSearch() {
    Color color = Color.fromRGBO(233, 233, 233, 1);
    return Row(
      children: [
        Flexible(
          child: SizedBox(
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
              child: TextFormField(
                controller: _searchController,
                style: TextStyle(fontSize: 14),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Digite cpf ou rg',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () => _getSearch(_searchController.text),
          icon: Icon(
            Icons.search,
            color: Config.white,
          ),
          style: IconButton.styleFrom(
            disabledBackgroundColor: Config.grey400,
            backgroundColor: Config.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardAuthorizedPerson(Resident resident) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        _statusCard(true),
        Divider(),
        Text(
          'Pessoa Autorizada',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage("img/perfil.jpg"),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resident.authorizedPersons!.first.name!,
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                    Divider(),
                    Config.text(
                        'CPF: ', resident.authorizedPersons!.first.cpf!, 18),
                    Config.text(
                        'RG: ', resident.authorizedPersons!.first.rg!, 18),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text(
          'Referente ao morador',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        ListTile(
          leading: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage("img/perfil.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            resident.name!,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
          subtitle: Text(
            "${resident.block!} - ${resident.apt!}",
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }

  Widget _cardResident(Resident resident) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        _statusCard(true),
        Divider(),
        Text(
          'MORADOR',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage("img/perfil.jpg"),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resident.name!,
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                    Divider(),
                    Text(
                      "${resident.block} - ${resident.apt}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Divider(),
                    Config.text('CPF: ', resident.cpf!, 18),
                    Config.text('RG: ', resident.rg!, 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statusCard(bool permission) {
    String text = 'Acesso liberado!';
    Color color = Config.green;
    IconData icon = Icons.check;
    if (!permission) {
      text = 'Acesso negado! Pessoa não encontrada.';
      color = Config.red;
      icon = Icons.close;
    }

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Config.white,
            size: 30,
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Config.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _getSearch(String? search) {
    resident = null;
    if (search!.isNotEmpty) {
      residentStore.getResidentSearch(search).then(
        (value) {
          if (value != null) {
            setState(() {
              resident = value;
            });
          } else {
            authorizedPersonsStore.getAuthorizedPersonsSearch(search).then(
              (value) {
                if (value != null) {
                  residentStore.erro.value = '';
                  resident = value;
                } else {
                  setState(() {
                    _search = true;
                  });
                }
              },
            );
          }
        },
      );
    } else {
      setState(() {
        resident = null;
      });
    }
    FocusScope.of(context).nextFocus();
    _searchController.clear();
  }

  void _updateInformations(int id) {
    _getReports(id);
    _getCorrespondece(id);
  }

  void _getCorrespondece(int id) {
    correspondenceStore.findByIdCondominium(id).then(
      (value) {
        setState(() {
          correspondences = value;
        });
      },
    );
  }

  void _getReports(int id) {
    reportStore.getReportByCondominium(id).then(
      (value) {
        setState(() {
          reportsTicket.clear();
          reportsAnonymous.clear();
          for (Report element in value) {
            if (element.type == "Ticket") {
              reportsTicket.add(element);
            } else {
              reportsAnonymous.add(element);
            }
          }
        });
      },
    );
  }
}
