import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Report.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/data/repositories/Report_Repository.dart';
import 'package:tcc/data/stores/Report_Store.dart';
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
  Resident? resident;
  Report? report;

  ReportStore store = ReportStore(
    repository: ReportRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    report = widget.report;
    resident = widget.report.resident;

    if (resident == null) _title = "anônimo";

    _updateStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _residentCard(resident),
            Text(
              'Denúncia',
              style: TextStyle(
                color: Config.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
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

  Widget _residentCard(Resident? resident) {
    return (resident != null)
        ? ListTile(
            title: Text(
              resident.name!,
              style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
            ),
            subtitle: Text('${resident.block} - ${resident.apt}'),
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
                  Config.logoName(resident.name!).toUpperCase(),
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

  void _updateStatus() {
    Map<String, dynamic> att = {
      "id": report!.id,
      "date": report!.date,
      "type": report!.type,
      "title": report!.title,
      "status": "Visualizado",
      "description": report!.description,
      "condominium": {"id": widget.condominium_id},
      "resident": (resident != null) ? {"id": resident!.id} : null
    };
    store.update(att);
  }
}
