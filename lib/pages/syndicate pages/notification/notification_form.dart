import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/repositories/Notification_Repository.dart';
import 'package:tcc/data/stores/Notification_store.dart';
import 'package:tcc/pages/syndicate%20pages/notification/notification_list.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/widgets/snackMessage.dart';

class NotificationFormPage extends StatefulWidget {
  final Condominium condominium;
  const NotificationFormPage({required this.condominium, super.key});

  @override
  State<NotificationFormPage> createState() => _NotificationFormPageState();
}

class _NotificationFormPageState extends State<NotificationFormPage> {
  NotificationStore store = NotificationStore(
    repository: NotificationRepository(
      client: HttpClient(),
    ),
  );

  TextEditingController _descriptionController = TextEditingController();
  String? _selectType;
  String? _selectCategory;

  List<String> _type = [
    "Comum",
    "Importante",
    "Urgente",
  ];

  List<String> _category = [
    "Financeiro",
    "Regras/Diretrizes",
    "Reforma",
    "Estrutura",
    "Notificação",
    "Outros",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      appBar: AppBarWidget(
        title: 'Adicionar notificação',
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.home_work_outlined,
                  size: 30,
                ),
                title: Text(
                  widget.condominium.name!,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(),
              DropdownMenu<dynamic>(
                width: 230,
                initialSelection: _selectType,
                label: Text(
                  'Tipo',
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
                    _selectType = value!;
                  });
                },
                dropdownMenuEntries: _type.map<DropdownMenuEntry<String>>(
                  (dynamic value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  },
                ).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownMenu<dynamic>(
                width: 230,
                initialSelection: _selectCategory,
                label: Text(
                  'Categoria',
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
                    _selectCategory = value!;
                  });
                },
                dropdownMenuEntries: _category.map<DropdownMenuEntry<String>>(
                  (dynamic value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  },
                ).toList(),
              ),
              InputWidget(
                'Descrição',
                _descriptionController,
                TextInputType.text,
                Icons.description_outlined,
                maxLine: 10,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _createNotification,
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
                        "Salvar",
                        style: TextStyle(
                          color: Config.white,
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

  void _createNotification() {
    Map<String, dynamic> notification = {
      "description": _descriptionController.text,
      "type": _selectType,
      "category": _selectType,
      "condominium": {"id": widget.condominium.id}
    };

    store.create(notification).then(
      (value) {
        if (store.erro.value.isEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotitificationListPage(),
            ),
          );
          WidgetSnackMessage.notificationSnackMessage(
            context: context,
            mensage: "Notificação foi criada com sucesso!",
          );
        } else {
          WidgetSnackMessage.notificationSnackMessage(
            context: context,
            backgroundColor: Config.red,
            icon: Icons.close,
            mensage: "Ops! Ocorreu um erro, tente novamente.",
          );
        }
      },
    );
  }
}
