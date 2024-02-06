import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/input.dart';

class AnonymousPage extends StatefulWidget {
  const AnonymousPage({super.key});

  @override
  State<AnonymousPage> createState() => _AnonymousPageState();
}

class _AnonymousPageState extends State<AnonymousPage> {
  TextEditingController _anonymousController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  String? selectedCategoryValue;
  List<Map<String, String>> listImagePath = [];
  List<String> listCategory = [
    'Administração',
    'Funcionário',
    'Manutenção',
    'Morador',
    'Reclamação',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Reportar',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Categoria: ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Config.grey800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String?>(
                      value: selectedCategoryValue,
                      onChanged: (String? newValue) =>
                          setState(() => selectedCategoryValue = newValue!),
                      items: listCategory
                          .map<DropdownMenuItem<String?>>(
                            (String? value) => DropdownMenuItem<String?>(
                              value: value,
                              child: Text(value!),
                            ),
                          )
                          .toList(),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      underline: SizedBox(),
                    ),
                  ),
                ],
              ),
              InputWidget(
                'Titulo',
                _titleController,
                TextInputType.text,
                Icons.title_rounded,
              ),
              InputWidget(
                'Descrição',
                _anonymousController,
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
              ),SizedBox(height: 10,),
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
}
