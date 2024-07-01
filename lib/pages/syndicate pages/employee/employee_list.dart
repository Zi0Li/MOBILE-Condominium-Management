import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/models/Employee.dart';
import 'package:tcc/data/repositories/Employee_Respository.dart';
import 'package:tcc/data/repositories/Syndicate_Repository.dart';
import 'package:tcc/data/stores/Employee_Store.dart';
import 'package:tcc/data/stores/Syndicate_Store.dart';
import 'package:tcc/pages/syndicate%20pages/employee/employee_form.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/syndicate_drawer.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  EmployeeStore employeeStore = EmployeeStore(
    repository: EmployeeRepository(
      client: HttpClient(),
    ),
  );

  SyndicateStore syndicateStore = SyndicateStore(
    repository: SyndicateRepository(
      client: HttpClient(),
    ),
  );

  List<Condominium> condominiums = [];
  List<Employee> employees = [];
  Condominium? selectCondominium;

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
        title: 'Funcionários',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployeeFormPage(
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
        animation: Listenable.merge([
          employeeStore.erro,
          employeeStore.isLoading,
          employeeStore.state,
          syndicateStore.erro,
          syndicateStore.isLoading,
          syndicateStore.state,
        ]),
        builder: (context, child) {
          if (employeeStore.isLoading.value || syndicateStore.isLoading.value) {
            return Center(
              child: WidgetLoading.containerLoading(),
            );
          } else if (employeeStore.erro.value.isNotEmpty ||
              syndicateStore.erro.value.isNotEmpty) {
            String error = (employeeStore.erro.value.isNotEmpty)
                ? employeeStore.erro.value
                : syndicateStore.erro.value;
            return Center(
              child: WidgetError.containerError(error, () {
                (employeeStore.erro.value.isNotEmpty)
                    ? employeeStore.erro.value = ''
                    : syndicateStore.erro.value = '';
              }),
            );
          } else {
            if (employeeStore.state.value.isNotEmpty) {
              return _body();
            } else {
              return Center(
                child: Text(
                  "Nenhum funcionário cadastrado neste condomínio",
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
              _getEmployee(selectCondominium!.id!);
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
              itemCount: employees.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => _employeeCard(
                employees[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _employeeCard(Employee employee) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeeFormPage(
            employee: employee,
            condominium: selectCondominium,
          ),
        ),
      ),
      title: Text(
        employee.name!,
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
            Config.logoName(employee.name!).toUpperCase(),
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
      subtitle: Text(employee.position!),
    );
  }

  void _getCondominiums() {
    syndicateStore.getSyndicateById(Config.user.id).then((syndicate) {
      setState(() {
        condominiums = syndicate.first.condominiums!;
        selectCondominium = syndicate.first.condominiums!.first;
        _getEmployee(selectCondominium!.id!);
      });
    });
  }

  void _getEmployee(int id) {
    employeeStore.getEmployeeByCondominium(id).then((value) {
      setState(() {
        employees = employeeStore.state.value;
      });
    });
  }
}
