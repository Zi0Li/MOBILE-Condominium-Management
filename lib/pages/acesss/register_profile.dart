// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/pages/acesss/register_details.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/input.dart';

class RegisterProfilePage extends StatefulWidget {
  Condominium? condominium;
  String? block;
  String? apt;
  RegisterProfilePage({
    required this.condominium,
    required this.block,
    required this.apt,
    super.key,
  });

  @override
  State<RegisterProfilePage> createState() => _RegisterProfilePageState();
}

class _RegisterProfilePageState extends State<RegisterProfilePage> {
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
                                color: Config.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 10,
                              color: Config.white,
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
                  Text(
                    'Dados pessoais',
                    style: TextStyle(
                      fontSize: 22,
                      color: Config.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: InputWidget(
                          'Rg',
                          _rgController,
                          TextInputType.number,
                          Icons.wallet_rounded,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        flex: 1,
                        child: InputWidget(
                          'Cpf',
                          _cpfController,
                          TextInputType.number,
                          Icons.description_outlined,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Resident resident = Resident(
                                id: null,
                                name: _nameController.text,
                                rg: _rgController.text,
                                cpf: _cpfController.text,
                                block: widget.block,
                                apt: widget.apt,
                                phone: _phoneController.text,
                                email: _emailController.text);
                                
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterDetailsPage(
                                  condominium: widget.condominium,
                                  resident: resident,
                                ),
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
}
