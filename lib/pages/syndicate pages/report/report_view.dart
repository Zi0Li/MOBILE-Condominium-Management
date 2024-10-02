import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Report.dart';
import 'package:tcc/data/repositories/Report_Repository.dart';
import 'package:tcc/data/stores/Report_Store.dart';
import 'package:tcc/pages/syndicate%20pages/report/report_list.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';

class ReportViewPage extends StatefulWidget {
  final Report report;
  final int condominium_id;
  ReportViewPage(
      {required this.report, required this.condominium_id, super.key});

  @override
  State<ReportViewPage> createState() => _ReportViewPageState();
}

class _ReportViewPageState extends State<ReportViewPage> {
  String _title = 'ticket';
  Report? report;
  String? _selectedStatus = '';

  List<String> _status = [
    'Em andamento',
    'Concluído',
    'Cancelado',
  ];

  ReportStore store = ReportStore(
    repository: ReportRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    report = widget.report;

    if (report!.type != "Ticket") _title = "anônimo";

    _selectedStatus = report!.status;
    _updateReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      appBar: AppBarWidget(
        title: 'Reporte - ${_title}',
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reportante',
              style: TextStyle(
                color: Config.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            _residentCard(report),
            Text(
              'Denúncia',
              style: TextStyle(
                color: Config.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Text(
                  'Status: ',
                  style: TextStyle(
                    color: Config.black,
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Config.orange,
                  onTap: () {
                    _statusShowDialog();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Config.grey400,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      _selectedStatus!,
                      style: TextStyle(
                        color: Config.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
            ListTile(
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        report!.title!,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        report!.date!,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Divider()
                ],
              ),
              subtitle: Text(
                report!.description!,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Text(
              'Fotos',
              style: TextStyle(
                color: Config.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Center(
              child: Wrap(
                spacing: MediaQuery.of(context).size.width / 40,
                runSpacing: MediaQuery.of(context).size.height / 80,
                children: [for (int i = 0; i < 9; i++) _cardPhoto()],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _residentCard(Report? report) {
    return (report!.type == "Ticket")
        ? ListTile(
            title: Text(
              report.resident!.name!,
              style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
            ),
            subtitle:
                Text('${report.resident!.block} - ${report.resident!.apt}'),
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
                  Config.logoName(report.resident!.name!).toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          )
        : ListTile(
            title: Text(
              "Pessoa anônima.",
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
                child: Icon(Icons.tag_faces_outlined),
              ),
            ),
          );
  }

  Widget _cardPhoto() {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      height: MediaQuery.of(context).size.height / 4.5,
      decoration: BoxDecoration(
        color: Config.amber,
        image: DecorationImage(
          image: AssetImage("img/perfil.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> _statusShowDialog() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alterar status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownMenu<dynamic>(
                width: 230,
                initialSelection: _selectedStatus,
                label: Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Config.grey800,
                ),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Config.grey400,
                    ),
                  ),
                ),
                onSelected: (value) {
                  setState(() {
                    _selectedStatus = value!;
                    _updateReport();
                  });
                },
                dropdownMenuEntries: _status.map<DropdownMenuEntry<String>>(
                  (dynamic value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  },
                ).toList(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                fixedSize: Size.fromHeight(10),
                backgroundColor: Config.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: BorderSide(
                  width: 1,
                  color: Config.grey400,
                ),
              ),
              child: Text(
                'Voltar',
                style: TextStyle(color: Config.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportListPage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _updateReport() {
    Map<String, dynamic> att = {
      "id": report!.id,
      "date": report!.date,
      "type": report!.type,
      "title": report!.title,
      "status": _selectedStatus,
      "view": true,
      "description": report!.description,
      "condominium": {"id": widget.condominium_id},
      "resident": {"id": report!.resident!.id},
    };
    store.update(att);
  }
}
