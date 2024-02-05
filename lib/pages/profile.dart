import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc/pages/home.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawer.dart';
import 'package:tcc/widgets/input.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _bithController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  String dropdownBlock = 'K';
  String dropdownApartament = Config.Apartment[0];
  String? _img;

  bool _page = true;

  Color _profileButtonColor = Config.orange;
  Color _profileTextColor = Config.white;
  Color _enderecoButtonColor = Config.white;
  Color _enderecoTextColor = Config.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Perfil',
      ),
      drawer: DrawerApp(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                          });
                        }
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Config.grey400,
                        border: Border.all(
                          width: 1,
                          color: Config.grey400,
                        ),
                      ),
                      child: Center(
                        child: _img == null
                            ? Icon(
                                Icons.person,
                                size: 40,
                                color: Config.black,
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
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Marcelo A. Erreiro Zioli',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Config.grey_letter,
                        ),
                      ),
                      Text(
                        "K - 303",
                        style: TextStyle(
                          fontSize: 14,
                          color: Config.grey600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _clickButton(),
                    child: _button('Dados pessoais', _profileButtonColor,
                        _profileTextColor),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => _clickButton(),
                    child: _button(
                        'Endereço', _enderecoButtonColor, _enderecoTextColor),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              _page
                  ? Column(
                      children: [
                        InputWidget(
                          'Nome',
                          _nicknameController,
                          TextInputType.text,
                          Icons.person_outline_rounded,
                        ),
                        InputWidget("Telefone", _numberController,
                            TextInputType.number, Icons.phone_android_outlined),
                        InputWidget('E-mail', _bithController,
                            TextInputType.number, Icons.email_outlined),
                        InputWidget(
                          'Rg',
                          _rgController,
                          TextInputType.number,
                          Icons.wallet_rounded,
                        ),
                        InputWidget(
                          'Cpf',
                          _cpfController,
                          TextInputType.number,
                          Icons.description_outlined,
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Config.text(
                            'Nome: ', 'Condomínio Terra de Santa Cruz', 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Config.text('Rua: ', 'Rio Claro', 18),
                            Config.text('N°: ', '10', 18),
                          ],
                        ),
                        Config.text('Bairro: ', 'Vila Progresso', 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Config.text('Estado: ', 'SP', 18),
                            Config.text('Cidade: ', 'Assis', 18),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Config.text('Bloco: ', dropdownBlock, 18),
                            Config.text(
                                'Apartamento: ', dropdownApartament, 18),
                          ],
                        ),
                      ],
                    ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        fixedSize: Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          width: 1,
                          color: Config.grey400,
                        ),
                      ),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Config.black,
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
                          color: Config.grey400,
                        ),
                      ),
                      child: Text(
                        'Salvar',
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

  void _clickButton() {
    setState(() {
      _page = _page ? false : true;

      _profileButtonColor = _page ? Config.orange : Config.white;
      _profileTextColor = _page ? Config.white : Config.black;

      _enderecoButtonColor = _page ? Config.white : Config.orange;
      _enderecoTextColor = _page ? Config.black : Config.white;
    });
  }

  Widget _button(String label, Color colorButton, Color colorText) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorButton,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: Config.grey400,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: colorText,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Config.grey600,
    );
  }
}
