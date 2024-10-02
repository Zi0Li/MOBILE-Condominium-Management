import 'package:flutter/material.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/employee_drawer.dart';

class EmployeeHomepage extends StatefulWidget {
  const EmployeeHomepage({super.key});

  @override
  State<EmployeeHomepage> createState() => _EmployeeHomepageState();
}

class _EmployeeHomepageState extends State<EmployeeHomepage> {
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
              Row(
                children: [
                  Expanded(
                    child: _cardReport(
                        "Denúncias Anônimas", Icons.person_off_outlined, 10),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: _cardReport("Reportes/Tickets",
                        Icons.report_gmailerrorred_sharp, 10),
                  ),
                ],
              ),
              Divider(
                color: Config.grey400,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardReport(String label, IconData icon, int listLenght) {
    return SizedBox(
      height: 80,
      child: Material(
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
}
