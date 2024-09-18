import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tcc/data/repositories/Report_Repository.dart';
import 'package:tcc/data/stores/Report_Store.dart';
import 'package:tcc/pages/resident%20pages/report/report_menu.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/widgets/snackMessage.dart';

class ReportFormPage extends StatefulWidget {
  final type;
  ReportFormPage({required this.type, super.key});

  @override
  State<ReportFormPage> createState() => _ReportFormPageState();
}

class _ReportFormPageState extends State<ReportFormPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<Map<String, String>> listImagePath = [];
  String _obsrvation =
      'Nenhum dos seus dados serão exibidos, evitando a sua identificação.';

  ReportStore store = ReportStore(
    repository: ReportRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    if (widget.type == "Ticket") {
      _obsrvation =
          'Seus dados serão exibidos, desta forma será possível a sua identificação.';
    }
    _dateController.text =
        _dateController.text = DateFormat('d/MM/y').format(DateTime.now());
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      appBar: AppBarWidget(
        title: 'Denúncia ${widget.type.toLowerCase()}',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _obsrvation,
                style: TextStyle(
                  color: Config.grey600,
                  fontStyle: FontStyle.italic,
                ),
              ),
              InputWidget(
                'Titulo',
                _titleController,
                TextInputType.text,
                Icons.title_rounded,
              ),
              InputWidget(
                'Data',
                _dateController,
                TextInputType.text,
                Icons.date_range,
                enabled: false,
              ),
              InputWidget(
                'Descrição',
                _descriptionController,
                TextInputType.multiline,
                Icons.description_outlined,
                maxLine: null,
              ),
              TextButton.icon(
                onPressed: () {
                  _selectImage();
                },
                icon: Icon(
                  Icons.image_search,
                  color: Config.white,
                ),
                label: Text(
                  'Imagem',
                  style: TextStyle(
                    color: Config.white,
                    fontSize: 16,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Config.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      width: 1,
                      color: Config.white,
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: listImagePath.length,
                itemBuilder: (context, index) =>
                    _image(listImagePath[index], index),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        _saveReport();
                      },
                      style: TextButton.styleFrom(
                        fixedSize: Size.fromHeight(52),
                        backgroundColor: Config.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          width: 1,
                          color: Config.orange,
                        ),
                      ),
                      child: Text(
                        'Reportar',
                        style: TextStyle(
                          color: Config.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectImage() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Imagem da '),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton.icon(
                onPressed: () {
                  ImagePicker()
                      .pickImage(source: ImageSource.gallery)
                      .then((file) {
                    if (file == null) {
                      return;
                    } else {
                      setState(() {
                        listImagePath.add(
                          {'title': file.name, 'path': file.path},
                        );
                      });
                    }
                  });

                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.image_outlined,
                  color: Config.orange,
                  size: 32,
                ),
                label: Text(
                  'Galeria',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: TextButton.styleFrom(
                  alignment: Alignment(-1, 0),
                  fixedSize: Size.fromWidth(double.maxFinite),
                  backgroundColor: Config.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Config.grey400),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Config.grey600,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton.icon(
                onPressed: () {
                  ImagePicker()
                      .pickImage(source: ImageSource.camera)
                      .then((file) {
                    if (file == null) {
                      return;
                    } else {
                      setState(() {
                        listImagePath.add(
                          {'title': file.name, 'path': file.path},
                        );
                      });
                    }
                  });

                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.camera_alt_outlined,
                  color: Config.orange,
                  size: 32,
                ),
                label: Text(
                  'Câmera',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: TextButton.styleFrom(
                  alignment: Alignment(-1, 0),
                  fixedSize: Size.fromWidth(double.maxFinite),
                  backgroundColor: Config.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Config.grey400),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Config.grey600,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                fixedSize: Size.fromHeight(10),
                backgroundColor: Config.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Config.grey400)),
                side: BorderSide(
                  width: 1,
                  color: Config.grey600,
                ),
              ),
              child: Text(
                'Cancelar',
                style: TextStyle(color: Config.grey800),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _image(Map<String, String> image, int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(
          image['title'].toString(),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              listImagePath.removeAt(index);
            });
          },
          child: Icon(
            Icons.delete_outlined,
            color: Config.orange,
            size: 30,
          ),
        ),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 0.5, color: Config.grey800),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(
                File(
                  image['path'].toString(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveReport() {
    Map<String, dynamic> report = {
      "title": _titleController.text,
      "type": widget.type,
      "description": _descriptionController.text,
      "status": "Enviado",
      "date": _dateController.text,
      "view": false,
      "condominium": {"id": Config.user.condominium.id},
      "resident": {"id": Config.user.id}
    };
    store.create(report).then(
      (value) {
        if (value != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportMenuPage(),
            ),
          );
          WidgetSnackMessage.notificationSnackMessage(
            context: context,
            mensage: "${widget.type} foi criado com sucesso",
          );
        }
      },
    );
  }
}
