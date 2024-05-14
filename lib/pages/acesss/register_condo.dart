import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/repositories/Condominium_Repository.dart';
import 'package:tcc/data/stores/Condominium_Store.dart';
import 'package:tcc/pages/acesss/register_profile.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';


class RegisterCondoPage extends StatefulWidget {
  const RegisterCondoPage({super.key});

  @override
  State<RegisterCondoPage> createState() => _RegisterCondoPageState();
}

class _RegisterCondoPageState extends State<RegisterCondoPage> {
  List<String> code = ['0', '0', '0', '0', '0'];
  bool condominio = false;

  String selectedBlockValue = 'A';
  String selectedApartamentValue = '101';

  final CondominiumStore store = CondominiumStore(
    repository: CondominiumRepository(
      client: HttpClient(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        backgroundColor: Config.orange,
        height: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                ),
              ],
            ),
          ),
          Flexible(
            child: AnimatedBuilder(
              animation:
                  Listenable.merge([store.state, store.erro, store.isLoading]),
              builder: (context, child) {
                if (store.isLoading.value) {
                  return WidgetLoading.containerLoading();
                } else if (store.erro.value.isNotEmpty) {
                  return WidgetError.containerError(store.erro.value, (){
                    setState(() {
                      store.erro.value = '';
                    });
                  });
                } else {
                  if (store.state.value.isEmpty) {
                    return _insertCodingToCondominium();
                  } else {
                    return _ConfirmCondominium();
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _inputCoding() {
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
                  code[0] = value;
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
                  code[1] = value;
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
                  code[2] = value;
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
                  code[3] = value;
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
                  code[4] = value;
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

  Widget _ConfirmCondominium() {
    return Padding(
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
            Config.text('Nome: ', store.state.value[0].name!, 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Config.text('Rua: ', store.state.value[0].street!, 18),
                Config.text('N°: ',
                    store.state.value[0].number_address!.toString(), 18),
              ],
            ),
            Config.text('Bairro: ', store.state.value[0].district!, 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Config.text(
                    'Estado: ', store.state.value[0].uf!.toUpperCase(), 18),
                Config.text('Cidade: ', store.state.value[0].city!, 18),
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton<String>(
                    value: selectedBlockValue,
                    onChanged: (String? newValue) =>
                        setState(() => selectedBlockValue = newValue!),
                    items: store.state.value[0].block!
                        .map<DropdownMenuItem<String>>(
                          (dynamic value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 42,
                    underline: SizedBox(),
                  ),
                ),
                Spacer(),
                Text(
                  'Apartamento: ',
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    value: selectedApartamentValue,
                    onChanged: (String? newValue) =>
                        setState(() => selectedApartamentValue = newValue!),
                    items: store.state.value[0].number_apt!
                        .map<DropdownMenuItem<String>>(
                          (dynamic value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
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
                        store.state.value.clear();
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
                        side: BorderSide(width: 1, color: Config.grey400),
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
                          builder: (context) => RegisterProfilePage(
                            condominium: store.state.value[0],
                            block: selectedBlockValue,
                            apt: selectedApartamentValue,
                          ),
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
    );
  }

  Widget _insertCodingToCondominium() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        child: SingleChildScrollView(
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
              _inputCoding(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        String sumCode = '';
                        for (var i = 0; i < code.length; i++) {
                          sumCode += code[i];
                        }
                        store
                            .getCondominiumByCode(int.parse(sumCode))
                            .then((value) {
                          print(store.state.value);
                        });
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
    );
  }
}
