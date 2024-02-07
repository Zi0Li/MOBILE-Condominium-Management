import 'package:flutter/material.dart';
import 'package:tcc/pages/report/anonymous.dart';
import 'package:tcc/pages/report/ticket.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';

class ReportMenuPage extends StatefulWidget {
  const ReportMenuPage({super.key});

  @override
  State<ReportMenuPage> createState() => _ReportMenuPageState();
}

class _ReportMenuPageState extends State<ReportMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Reportar',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: _button(
                    "Denúncia Anônima",
                    Icons.person_off_outlined,
                    AnonymousPage(),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: _button(
                    "Reportar/Ticket",
                    Icons.report_gmailerrorred_sharp,
                    ReportTicketPage(),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Flexible(
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.report_gmailerrorred_rounded),
                  title: Text('Report de numero $index'),
                  subtitle: Text('Protocolo: ${Config.randomNumber(qty: 6)}'),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _button(String label, IconData icon, Widget f) {
    return SizedBox(
      height: 80,
      child: ClipRect(
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            side: BorderSide(color: Config.grey400),
          ),
          color: Config.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            splashColor: Config.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => f),
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    color: Config.red,
                    size: 30,
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
      ),
    );
  }
}
