import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/models/Report.dart';
import 'package:tcc/data/repositories/Report_Repository.dart';
import 'package:tcc/data/repositories/Syndicate_Repository.dart';
import 'package:tcc/data/stores/Report_Store.dart';
import 'package:tcc/data/stores/Syndicate_Store.dart';
import 'package:tcc/pages/syndicate%20pages/report/report_view.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/syndicate_drawer.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';

class ReportListPage extends StatefulWidget {
  const ReportListPage({super.key});

  @override
  State<ReportListPage> createState() => _ReportListPageState();
}

class _ReportListPageState extends State<ReportListPage> {
  List<Condominium> condominiums = [];
  List<Report> reportsTicket = [];
  List<Report> reportsAnonymous = [];
  List<Report> reports = [];
  Condominium? selectCondominium;

  List<IconData> _iconListButton = [
    Icons.report_gmailerrorred_sharp,
    Icons.person_off_outlined,
  ];

  List<String> _titleListButton = [
    'Tickets',
    'Anônimos',
  ];

  int selectButton = 0;

  SyndicateStore syndicateStore = SyndicateStore(
    repository: SyndicateRepository(
      client: HttpClient(),
    ),
  );

  ReportStore reportStore = ReportStore(
    repository: ReportRepository(
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
      drawer: SyndicateDrawerApp(),
      appBar: AppBarWidget(
        title: 'Reportes/Tickets',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            AnimatedBuilder(
              animation: Listenable.merge([
                reportStore.erro,
                reportStore.isLoading,
                reportStore.state,
                syndicateStore.erro,
                syndicateStore.isLoading,
                syndicateStore.state,
              ]),
              builder: (context, child) {
                if (reportStore.isLoading.value ||
                    syndicateStore.isLoading.value) {
                  return Center(
                    child: WidgetLoading.containerLoading(),
                  );
                } else if (reportStore.erro.value.isNotEmpty ||
                    syndicateStore.erro.value.isNotEmpty) {
                  String error = (reportStore.erro.value.isNotEmpty)
                      ? reportStore.erro.value
                      : syndicateStore.erro.value;
                  return Center(
                    child: WidgetError.containerError(error, () {
                      (reportStore.erro.value.isNotEmpty)
                          ? reportStore.erro.value = ''
                          : syndicateStore.erro.value = '';
                    }),
                  );
                } else {
                  if (reports.isNotEmpty) {
                    return _body();
                  } else {
                    return Flexible(
                      child: Center(
                        child: Text(
                          "Nenhum reporte(${_titleListButton[selectButton]}) feito neste condomínio.",
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
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
            _getReports(selectCondominium!.id!);
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
        Container(
          height: 45,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _iconListButton.length,
            itemBuilder: (context, index) {
              return _button(
                _iconListButton[index],
                _titleListButton[index],
                index,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return Flexible(
      child: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) => _cardReport(reports[index], index),
      ),
    );
  }

  Widget _cardReport(Report report, int index) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReportViewPage(
            report: report,
            condominium_id: selectCondominium!.id!,
          ),
        ),
      ),
      title: Text(
        report.title!,
      ),
      subtitle: Text(report.status!),
      trailing: Text(report.date!),
    );
  }

  Widget _button(IconData icon, String title, int index) {
    Color colorButton = Config.white;
    Color colorContent = Config.black;

    if (selectButton == index) {
      colorButton = Config.orange;
      colorContent = Config.white;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectButton = index;
            _reportListAtt();
          });
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorButton,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Config.grey400,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: colorContent,
              ),
              Text(
                title,
                style: TextStyle(
                  color: colorContent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getCondominiums() {
    syndicateStore.getSyndicateById(Config.user.id).then((syndicate) {
      setState(() {
        condominiums = syndicate.first.condominiums!;
        selectCondominium = syndicate.first.condominiums!.first;
        _getReports(selectCondominium!.id!);
      });
    });
  }

  void _getReports(int id) {
    reportStore.getReportByCondominium(id).then(
      (value) {
        setState(() {
          reportsTicket.clear();
          reportsAnonymous.clear();
          reports.clear();
          for (Report element in value) {
            if (element.resident != null) {
              reportsTicket.add(element);
            } else {
              reportsAnonymous.add(element);
            }
          }
          _reportListAtt();
        });
      },
    );
  }

  void _reportListAtt() {
    setState(() {
      (selectButton == 0)
          ? reports = reportsTicket
          : reports = reportsAnonymous;
    });
  }
}
