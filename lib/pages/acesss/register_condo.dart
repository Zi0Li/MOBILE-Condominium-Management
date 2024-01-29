import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc/pages/acesss/register_profile.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';

class RegisterCondoPage extends StatefulWidget {
  const RegisterCondoPage({super.key});

  @override
  State<RegisterCondoPage> createState() => _RegisterCondoPageState();
}

class _RegisterCondoPageState extends State<RegisterCondoPage> {
  String code = '';
  bool condominio = false;

  final block = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
  ];
  static final Apartment = [
    '101',
    '102',
    '103',
    '104',
    '201',
    '202',
    '203',
    '204',
    '301',
    '302',
    '303',
    '304',
    '401',
    '402',
    '403',
    '404',
  ];
  
  String selectedBlockValue = 'A';
  String selectedApartamentValue = '101';

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
          (condominio)
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confirme o condomínio',
                          style: TextStyle(
                            fontSize: 22,
                            color: Config.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(),
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
                        Divider(),
                        Text(
                          'Selecione seu bloco/apto',
                          style: TextStyle(
                            fontSize: 22,
                            color: Config.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Bloco: ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Config.grey800,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),

                              // dropdown below..
                              child: DropdownButton<String>(
                                value: selectedBlockValue,
                                onChanged: (String? newValue) =>
                                    setState(() => selectedBlockValue = newValue!),
                                items: block
                                    .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            ))
                                    .toList(),

                                // add extra sugar..
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 42,
                                underline: SizedBox(),
                              ),
                            ), Spacer(),
                            Text(
                              'Apartamento: ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Config.grey800,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),

                              // dropdown below..
                              child: DropdownButton<String>(
                                value: selectedApartamentValue,
                                onChanged: (String? newValue) =>
                                    setState(() => selectedApartamentValue = newValue!),
                                items: Apartment
                                    .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            ))
                                    .toList(),

                                // add extra sugar..
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 42,
                                underline: SizedBox(),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    condominio = false;
                                  });
                                },
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Config.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: Config.grey400),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterProfilePage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Confirmar',
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
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Digite o codigo do condomínio',
                          style: TextStyle(
                            fontSize: 20,
                            color: Config.black,
                          ),
                        ),
                        Text(
                          'Não tem o codigo? Entre em contato com seu síndico(a) para que envie o codigo do seu condomínio.',
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 16,
                            color: Config.grey600,
                          ),
                        ),
                        inputCoding(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Reset',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Config.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: Config.grey400),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  print(code);
                                  if (code == '12345') {
                                    setState(() {
                                      code = '';
                                      condominio = true;
                                    });
                                  } else {
                                    code = '';
                                  }
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
                  ),
                ),
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

  Widget inputCoding() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 68,
            width: 64,
            child: TextField(
              onChanged: (value) {
                if (value.length == 1) {
                  code += value;
                  FocusScope.of(context).nextFocus();
                }
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 68,
            width: 64,
            child: TextField(
              onChanged: (value) {
                if (value.length == 1) {
                  code += value;
                  FocusScope.of(context).nextFocus();
                }
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 68,
            width: 64,
            child: TextField(
              onChanged: (value) {
                if (value.length == 1) {
                  code += value;
                  FocusScope.of(context).nextFocus();
                }
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 68,
            width: 64,
            child: TextField(
              onChanged: (value) {
                if (value.length == 1) {
                  code += value;
                  FocusScope.of(context).nextFocus();
                }
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 68,
            width: 64,
            child: TextField(
              onChanged: (value) {
                if (value.length == 1) {
                  code += value;
                  FocusScope.of(context).nextFocus();
                }
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
