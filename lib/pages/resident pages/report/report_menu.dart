import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Report.dart';
import 'package:tcc/data/repositories/Report_Repository.dart';
import 'package:tcc/data/stores/Report_Store.dart';
import 'package:tcc/pages/resident%20pages/report/report_form.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/resident_drawer.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';
import 'package:tcc/widgets/showDialog.dart';
import 'package:tcc/widgets/snackMessage.dart';

class ReportMenuPage extends StatefulWidget {
  const ReportMenuPage({super.key});

  @override
  State<ReportMenuPage> createState() => _ReportMenuPageState();
}

class _ReportMenuPageState extends State<ReportMenuPage> {
  List<Report> reports = [];

  ReportStore store = ReportStore(
    repository: ReportRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    _getReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      drawer: ResidentDrawerApp(),
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
                    ReportFormPage(type: "Anônima"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: _button(
                    "Reportar/Ticket",
                    Icons.report_gmailerrorred_sharp,
                    ReportFormPage(type: "Ticket"),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          AnimatedBuilder(
            animation: Listenable.merge([
              store.erro,
              store.isLoading,
              store.state,
            ]),
            builder: (context, child) {
              if (store.isLoading.value) {
                return Flexible(
                  child: Center(
                    child: WidgetLoading.containerLoading(),
                  ),
                );
              } else if (store.erro.value.isNotEmpty) {
                return WidgetError.containerError(
                  store.erro.value,
                  () => store.erro.value = "",
                );
              } else {
                if (reports.isNotEmpty) {
                  return _reportListView();
                } else {
                  return Flexible(
                    child: Center(
                      child: Text(
                        "Nenhum reporte realizado.",
                        style: TextStyle(
                          color: Config.grey_letter,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }

  Widget _reportListView() {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: false,
        itemCount: reports.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.report_gmailerrorred_rounded),
            title: Text(reports[index].title!),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text((reports[index].view!) ? "Visualizado" : "Enviado"),
                Text(reports[index].type!)
              ],
            ),
            onTap: () {
              return WidgetShowDialog.DeleteShowDialog(
                context,
                reports[index].title!,
                Icons.delete_forever_outlined,
                () => _deleteReport(reports[index]),
              );
            },
          );
        },
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
            splashColor: Config.orange,
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
                    color: Config.orange,
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

  void _deleteReport(Report report) {
    store.delete(report.id!).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReportMenuPage(),
        ),
      );
      WidgetSnackMessage.notificationSnackMessage(
        context: context,
        mensage: "${report.title} foi deletado com sucesso",
      );
    });
  }

  void _getReport() {
    store.getReportByResident(Config.user.id).then(
      (value) {
        print(value);
        reports = value;
      },
    );
  }
}
