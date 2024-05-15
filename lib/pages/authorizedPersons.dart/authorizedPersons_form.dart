// ignore_for_file: must_be_immutable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc/data/models/AuthorizedPersons.dart';
import 'package:tcc/data/repositories/AuthorizedPersons_Repository.dart';
import 'package:tcc/data/stores/AuthorizedPersons_Store.dart';
import 'package:tcc/pages/authorizedPersons.dart/authorizedPersons_list.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/widgets/showDialog.dart';
import 'package:tcc/widgets/snackMessage.dart';
import 'package:tcc/data/http/http_client.dart';

class AuthorizedPersonsAddPage extends StatefulWidget {
  AuthorizedPersons? authorizedPersons;
  AuthorizedPersonsAddPage({this.authorizedPersons, super.key});

  @override
  State<AuthorizedPersonsAddPage> createState() =>
      _AuthorizedPersonsAddPageState();
}

class _AuthorizedPersonsAddPageState extends State<AuthorizedPersonsAddPage> {
  @override
  void initState() {
    super.initState();
    if (widget.authorizedPersons != null) {
      _nameController.text = widget.authorizedPersons!.name!;
      _cpfController.text = widget.authorizedPersons!.cpf!;
      _rgController.text = widget.authorizedPersons!.rg!;
      _kinshipController.text = widget.authorizedPersons!.kinship!;
      _phoneController.text = widget.authorizedPersons!.phone!;
    }
  }

  AuthorizedPersonsStore store = AuthorizedPersonsStore(
    repository: AuthorizedPersonsRepository(
      client: HttpClient(),
    ),
  );

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _kinshipController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      appBar: AppBarWidget(
        title: 'Pessoas autorizadas',
        actions: [
          (widget.authorizedPersons != null)
              ? IconButton(
                  onPressed: () {
                    WidgetShowDialog.DeleteShowDialog(
                      context,
                      _nameController.text,
                      Icons.delete_forever,
                      _deleteauthorizedPersons,
                    );
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: Config.orange,
                    size: 28,
                  ),
                )
              : Container()
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Config.backgroundColor,
                        border: Border.all(
                          width: 1,
                          color: Config.grey800,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: _img == null
                          ? Icon(
                              Icons.person,
                              size: 60,
                              color: Config.grey800,
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    File(
                                      _img!,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          ImagePicker()
                              .pickImage(source: ImageSource.camera)
                              .then((file) {
                            if (file == null) {
                              return;
                            } else {
                              setState(() {
                                _img = file.path;
                                _photoController.text = file.path;
                              });
                            }
                          });
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Config.orange, width: 1),
                          ),
                        ),
                        label: Text(
                          'Adicionar foto',
                          style: TextStyle(color: Config.grey800),
                        ),
                        icon: Icon(
                          Icons.add_a_photo_outlined,
                          color: Config.orange,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Adicione a foto da pessoa',
                        style: TextStyle(fontSize: 14, color: Config.grey800),
                      )
                    ],
                  )
                ],
              ),
              InputWidget('Nome', _nameController, TextInputType.text,
                  Icons.person_outline_rounded),
              InputWidget('Rg', _rgController, TextInputType.text,
                  Icons.wallet_rounded),
              InputWidget('CPF', _cpfController, TextInputType.text,
                  Icons.description_outlined),
              InputWidget('Parentesco', _kinshipController, TextInputType.text,
                  Icons.family_restroom_rounded),
              InputWidget('Telefone', _phoneController, TextInputType.phone,
                  Icons.phone_android_outlined),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        fixedSize: Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          width: 1,
                          color: Config.grey800,
                        ),
                      ),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Config.grey800,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        _saveAuthorizedPersons();
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
                        'Salvar',
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

  void _saveAuthorizedPersons() {
    if (widget.authorizedPersons != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthorizedPersonsListPage(),
        ),
      );
    } else {
      Map<String, dynamic> authorizedPerson = {
        "name": _nameController.text,
        "cpf": _cpfController.text,
        "rg": _rgController.text,
        "kinship": _kinshipController.text,
        "phone": _phoneController.text,
        "resident": {"id": Config.resident.id}
      };
      store.postAuthorizedPersons(authorizedPerson).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuthorizedPersonsListPage(),
          ),
        );
      });
    }
  }

  void _deleteauthorizedPersons() {
    store.deleteAuthorizedPersons(widget.authorizedPersons!.id!).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthorizedPersonsListPage(),
        ),
      );
      WidgetSnackMessage.notificationSnackMessage(
        context: context,
        mensage: "${widget.authorizedPersons!.name!} excluído com sucesso!",
        backgroundColor: Config.green,
        icon: Icons.check,
      );
    });
  }
}
