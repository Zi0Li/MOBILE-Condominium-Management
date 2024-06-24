import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/models/Kiosk.dart';
import 'package:tcc/data/repositories/Kiosk_repository.dart';
import 'package:tcc/data/stores/Kiosk_Store.dart';
import 'package:tcc/pages/syndicate%20pages/kiosk/kiosk_list.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/widgets/snackMessage.dart';

class KioskFormPage extends StatefulWidget {
  final Kiosk? kiosk;
  final Condominium? condominium;
  const KioskFormPage({this.kiosk, this.condominium, super.key});

  @override
  State<KioskFormPage> createState() => _KioskFormPageState();
}

class _KioskFormPageState extends State<KioskFormPage> {
  KioskStore store = KioskStore(
    repository: KioskRepository(
      client: HttpClient(),
    ),
  );

  String _title = "Cadastrar";

  TextEditingController _typeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.kiosk != null) {
      _typeController.text = widget.kiosk!.type!;
      _descriptionController.text = widget.kiosk!.description!;
      _title = "Editar";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '$_title quiosque',
        actions: [
          (widget.kiosk != null)
              ? IconButton(
                  onPressed: _deleteKiosk,
                  icon: Icon(
                    Icons.delete_outline,
                    color: Config.orange,
                    size: 28,
                  ),
                )
              : Container()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputWidget(
                'Tipo',
                _typeController,
                TextInputType.text,
                Icons.outdoor_grill_outlined,
              ),
              Text(
                'ex: churrasqueira, salão de festa, galpão, etc...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              InputWidget(
                'Descrição',
                _descriptionController,
                TextInputType.text,
                Icons.description_outlined,
                maxLine: 10,
              ),
              Text(
                'ex: informações gerais, items, regras, etc...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _saveAndUpdateKiosk,
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
                        _title,
                        style: TextStyle(
                          color: Config.backgroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteKiosk() {
    store.deleteKiosk(widget.kiosk!.id!).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KioskListPage(),
        ),
      );
      WidgetSnackMessage.notificationSnackMessage(
        context: context,
        mensage: "${_typeController.text} foi deletado com sucesso!",
      );
    });
  }

  void _saveAndUpdateKiosk() {
    Map<String, dynamic> kiosk = {
      "id": (widget.kiosk != null) ? widget.kiosk!.id : null,
      "description": _descriptionController.text,
      "type": _typeController.text,
      "condominium": {"id": widget.condominium!.id}
    };

    if (widget.kiosk != null) {
      store.putKiosk(kiosk).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KioskListPage(),
          ),
        );
        WidgetSnackMessage.notificationSnackMessage(
          context: context,
          mensage: "${_typeController.text} foi editado com sucesso!",
        );
      });
    } else {
      store.postKiosk(kiosk).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KioskListPage(),
          ),
        );
        WidgetSnackMessage.notificationSnackMessage(
          context: context,
          mensage: "${_typeController.text} foi criado com sucesso!",
        );
      });
    }
  }
}
