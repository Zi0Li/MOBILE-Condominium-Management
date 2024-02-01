import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc/pages/home.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/input.dart';

class RegisterDetailsPage extends StatefulWidget {
  const RegisterDetailsPage({super.key});

  @override
  State<RegisterDetailsPage> createState() => _RegisterDetailsPageState();
}

class _RegisterDetailsPageState extends State<RegisterDetailsPage> {
  String selectedBlockValue = 'A';
  String selectedApartamentValue = '101';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        backgroundColor: Config.orange,
        height: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Config.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SmartCondo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Config.light_purple,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Config.white),
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 10,
                              color: Config.light_purple,
                            ),
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Config.light_purple,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Config.white),
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 10,
                              color: Config.light_purple,
                            ),
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Config.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Config.white,
                        size: 32,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Condomínio',
                        style: TextStyle(
                          fontSize: 22,
                          color: Config.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _blockAndApartament(),
                        child: Icon(
                          Icons.edit_outlined,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _text('Nome: ', 'Condomínio Terra de Santa Cruz'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text('Rua: ', 'Rio Claro'),
                      _text('N°: ', '10'),
                    ],
                  ),
                  _text('Bairro: ', 'Vila Progresso'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text('Estado: ', 'SP'),
                      _text('Cidade: ', 'Assis'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text('Bloco: ', selectedBlockValue),
                      _text('Apartamento: ', selectedApartamentValue),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dados pessoais',
                        style: TextStyle(
                          fontSize: 22,
                          color: Config.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _editProfile(),
                        child: Icon(
                          Icons.edit_outlined,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _text('Nome: ', 'Marcelo A. Erreiro Zioli'),
                  _text('Rg: ', '22.505.068-X'),
                  _text('Cpf: ', '114.441.615-19'),
                  _text('E-mail: ', 'marceloaezioli@hotmail.com'),
                  _text('Phone: ', '(18) 9 9745-0597'),
                  Divider(),
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
                          child: Text(
                            'Próximo',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Config.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _text(String text1, String text2) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: text1,
        style: TextStyle(
          fontSize: 18,
          color: Config.grey800,
          fontWeight: FontWeight.w600,
        ),
        children: <TextSpan>[
          TextSpan(
            text: text2,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Config.grey600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _blockAndApartament() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bloco e Apartamento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownMenu<dynamic>(
                width: 230,
                initialSelection: selectedBlockValue,
                label: Text(
                  'Bloco',
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
                    selectedBlockValue = value!;
                  });
                },
                dropdownMenuEntries:
                    Config.block.map<DropdownMenuEntry<String>>(
                  (String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  },
                ).toList(),
              ),
              SizedBox(
                height: 15,
              ),
              DropdownMenu<dynamic>(
                width: 230,
                initialSelection: selectedApartamentValue,
                label: Text(
                  'Apartamento',
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
                      borderSide: BorderSide(color: Config.grey400)),
                ),
                onSelected: (value) {
                  setState(() {
                    selectedApartamentValue = value!;
                  });
                },
                dropdownMenuEntries:
                    Config.Apartment.map<DropdownMenuEntry<String>>(
                  (String value) {
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
                'Salvar',
                style: TextStyle(color: Config.white),
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

  Future<void> _editProfile() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dados pessoais'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputWidget(
                  'Nome',
                  _nameController,
                  TextInputType.name,
                  Icons.person_outline_rounded,
                ),
                InputWidget(
                  'E-mail',
                  _emailController,
                  TextInputType.emailAddress,
                  Icons.email_outlined,
                ),
                InputWidget(
                  'Telefone',
                  _phoneController,
                  TextInputType.phone,
                  Icons.phone_android_outlined,
                ),
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
                ),
              ],
            ),
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
                'Salvar',
                style: TextStyle(color: Config.white),
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
}
