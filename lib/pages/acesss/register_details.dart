// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/data/repositories/Resident_Repository.dart';
import 'package:tcc/data/stores/Resident_Store.dart';
import 'package:tcc/pages/acesss/login.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/error_message.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/widgets/loading.dart';

class RegisterDetailsPage extends StatefulWidget {
  Condominium? condominium;
  Resident? resident;
  String? password;
  RegisterDetailsPage({
    required this.condominium,
    required this.resident,
    required this.password,
    super.key,
  });

  @override
  State<RegisterDetailsPage> createState() => _RegisterDetailsPageState();
}

class _RegisterDetailsPageState extends State<RegisterDetailsPage> {
  ResidentStore store = ResidentStore(
    repository: ResidentRepository(
      client: HttpClient(),
    ),
  );

  String selectedBlockValue = '';
  String selectedApartamentValue = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailController.text = widget.resident!.email!;
    _nameController.text = widget.resident!.name!;
    _phoneController.text = widget.resident!.phone!;
    _cpfController.text = widget.resident!.cpf!;
    _rgController.text = widget.resident!.rg!;
    selectedApartamentValue = widget.resident!.apt!;
    selectedBlockValue = widget.resident!.block!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          backgroundColor: Config.orange,
          height: 0,
        ),
        body: AnimatedBuilder(
          animation:
              Listenable.merge([store.erro, store.isLoading, store.state]),
          builder: (context, child) {
            if (store.isLoading.value) {
              return Center(
                child: WidgetLoading.containerLoading(),
              );
            } else if (store.erro.value.isNotEmpty) {
              return ErrorMessage.containerError(
                  store.erro.value, () => store.erro.value = '');
            } else {
              return _body();
            }
          },
        ));
  }

  Widget _body() {
    return SingleChildScrollView(
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
                Config.text('Nome: ', widget.condominium!.name!, 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Config.text('Rua: ', widget.condominium!.street!, 18),
                    Config.text('N°: ',
                        widget.condominium!.number_address!.toString(), 18),
                  ],
                ),
                Config.text('Bairro: ', widget.condominium!.district!, 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Config.text('Estado: ', widget.condominium!.uf!, 18),
                    Config.text('Cidade: ', widget.condominium!.city!, 18),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Config.text('Bloco: ', selectedBlockValue, 18),
                    Config.text('Apartamento: ', selectedApartamentValue, 18),
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
                Config.text('Nome: ', _nameController.text, 18),
                Config.text('Rg: ', _rgController.text, 18),
                Config.text('Cpf: ', _cpfController.text, 18),
                Config.text('E-mail: ', _emailController.text, 18),
                Config.text('Phone: ', _phoneController.text, 18),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          _registerResident();
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
                setState(() {});
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
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _registerResident() {
    dynamic resident = {
      "cpf": _cpfController.text,
      "name": _nameController.text,
      "phone": _phoneController.text,
      "rg": _rgController.text,
      "email": _emailController.text,
      "apt": selectedApartamentValue,
      "block": selectedBlockValue,
      "condominium": {"id": widget.condominium!.id}
    };
    dynamic register = {
      "login": _emailController.text,
      "password": widget.password,
      "role": Config.morador,
      "user_id": 0
    };
    store.postResident(resident, register).then((value) {
      if (store.erro.value.isEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    });
  }
}
