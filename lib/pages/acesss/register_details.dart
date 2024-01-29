import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';

class RegisterDetailsPage extends StatefulWidget {
  const RegisterDetailsPage({super.key});

  @override
  State<RegisterDetailsPage> createState() => _RegisterDetailsPageState();
}

class _RegisterDetailsPageState extends State<RegisterDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Column(
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
                      onTap: () {
                      },
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
                    _text('Bloco: ', 'A'),
                    _text('Apartamento: ', '101'),
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
              ],
            ),
          )
        ],
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
}
