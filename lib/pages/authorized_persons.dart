import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawer.dart';
import 'package:tcc/widgets/input.dart';

class AuthorizedPersonsPage extends StatefulWidget {
  const AuthorizedPersonsPage({super.key});

  @override
  State<AuthorizedPersonsPage> createState() => _AuthorizedPersonsPageState();
}

class _AuthorizedPersonsPageState extends State<AuthorizedPersonsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _documentController = TextEditingController();
  final TextEditingController _kinshipController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  String? _img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      drawer: DrawerApp(),
      appBar: AppBar(
        backgroundColor: Config.dark_purple,
        title: Text(
          'Pessoas autorizadas',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
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
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Config.backgroundColor,
                  border: Border.all(
                    width: 1,
                    color: Config.dark_purple,
                  ),
                ),
                child: Center(
                  child: _img == null
                      ? Icon(
                          Icons.person,
                          size: 40,
                          color: Config.dark_purple,
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
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
            ),
            InputWidget('Nome', _nameController, TextInputType.text),
            InputWidget('Documento (RG / CPF)', _documentController,
                TextInputType.text),
            InputWidget('Parentesco', _kinshipController, TextInputType.text),
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
                        color: Config.dark_purple,
                      ),
                    ),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Config.dark_purple,
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
                    onPressed: () {},
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
    );
  }
}
