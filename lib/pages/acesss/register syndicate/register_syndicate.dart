import 'package:flutter/material.dart';
import 'package:tcc/data/models/Syndicate.dart';
import 'package:tcc/pages/acesss/register%20syndicate/register_syndicate_login.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/input.dart';

class RegisterSyndicatePage extends StatefulWidget {
  const RegisterSyndicatePage({super.key});

  @override
  State<RegisterSyndicatePage> createState() => _RegisterSyndicatePageState();
}

class _RegisterSyndicatePageState extends State<RegisterSyndicatePage> {
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
                                color: Config.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '1',
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
                                  '2',
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
                  SizedBox(
                    width: 15,
                  ),
                  InputWidget(
                    'Cpf',
                    _cpfController,
                    TextInputType.number,
                    Icons.description_outlined,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Syndicate syndicate = Syndicate(
                              id: null,
                              name: _nameController.text,
                              rg: _rgController.text,
                              cpf: _cpfController.text,
                              phone: _phoneController.text,
                              email: null,
                              condominiums: null,
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RegisterSyndicateLoginPage(
                                  syndicate: syndicate,
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
