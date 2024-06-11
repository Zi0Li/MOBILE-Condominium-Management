import 'package:flutter/material.dart';
import 'package:tcc/data/controllers/Login_Controller.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/repositories/Employee_Respository.dart';
import 'package:tcc/data/repositories/Syndicate_Repository.dart';
import 'package:tcc/data/stores/Employee_Store.dart';
import 'package:tcc/data/stores/Syndicate_Store.dart';
import 'package:tcc/pages/acesss/welcome.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/syndicate_drawer.dart';
import 'package:tcc/widgets/error.dart';
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

  EmployeeStore employeeStore = EmployeeStore(
    repository: EmployeeRepository(
      client: HttpClient(),
    ),
  );

  int contAuthorizedPersons = 0;
  Condominium? selectCondominium;
  List<Condominium> condominiums = [];

  @override
  void initState() {
    super.initState();
    _getSyndicate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      drawer: SyndicateDrawerApp(),
      appBar: AppBar(
        backgroundColor: Config.backgroundColor,
        toolbarHeight: 56,
        actions: [
          (selectCondominium == null)
              ? Container()
              : DropdownButton<Condominium>(
                  value: selectCondominium,
                  alignment: Alignment.bottomRight,
                  onChanged: (Condominium? newValue) => setState(() {
                    selectCondominium = newValue!;
                    _updateInformations(newValue.id!);
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
        ],
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
              _cardNotification(
                'Atualmente você não tem correspondência',
                Icons.markunread_mailbox_outlined,
              ),
              SizedBox(
                height: 10,
              ),
              _cardNotification(
                'Você não tem nenhuma notificação',
                Icons.notifications_none_outlined,
              ),
              Divider(
                color: Config.grey400,
              ),
              Row(
                children: [
                  Expanded(
                    child: _button(
                      "Denúncias Anônimas",
                      Icons.person_off_outlined,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: _button(
                      "Reportes/Tickets",
                      Icons.report_gmailerrorred_sharp,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Config.grey400,
              ),
              Text(
                'Funcionários',
                style: TextStyle(
                  color: Config.grey_letter,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              AnimatedBuilder(
                animation: Listenable.merge([
                  employeeStore.erro,
                  employeeStore.isLoading,
                  employeeStore.state,
                ]),
                builder: (context, child) {
                  if (employeeStore.isLoading.value) {
                    return Center(
                      child: WidgetLoading.containerLoading(),
                    );
                  } else if (employeeStore.erro.value.isNotEmpty) {
                    return WidgetError.containerError(employeeStore.erro.value,
                        () => employeeStore.erro.value = '');
                  } else {
                    if (employeeStore.state.value.isNotEmpty) {
                      return _cardEmployee();
                    } else {
                      return _isEmpty('Nenhum funcionário cadastrado!');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardEmployee() {
    return Container(
      height: 115,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Center(
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 10,
            runSpacing: 10,
            children: [
              for (int i = 0; i < employeeStore.state.value.length; i++)
                Container(
                  width: 200,
                  height: 110,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 1,
                      color: Config.grey400,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Config.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Config.grey400,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'FOTO',
                              style: TextStyle(color: Config.orange),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          employeeStore.state.value[i].name!,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        employeeStore.state.value[i].position!,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(String label, IconData icon) {
    return SizedBox(
      height: 80,
      child: Material(
        color: Config.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(color: Config.grey400),
        ),
        child: InkWell(
          splashColor: Config.orange,
          onTap: () => print('Teste'),
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
                      '1',
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

  void _getSyndicate() {
    syndicateStore.isLoading.value = true;
    LoginController.internal().getAllLogins().then((value) {
      if (value.isNotEmpty) {
        syndicateStore.getSyndicateById(value.first.id).then((syndicate) {
          setState(() {
            Config.user = syndicate.first;
            condominiums = syndicate.first.condominiums!;
            selectCondominium = syndicate.first.condominiums!.first;
            _updateInformations(syndicate.first.condominiums!.first.id!);
          });
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

  void _updateInformations(int id) {
    _getEmployeeByCondominium(id);
  }

  void _getEmployeeByCondominium(int id) {
    employeeStore.getEmployeeByCondominium(id);
  }

  Widget _isEmpty(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: Config.grey_letter,
          fontSize: 16,
        ),
      ),
    );
  }
}
