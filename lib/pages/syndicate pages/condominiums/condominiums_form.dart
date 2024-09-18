import 'package:flutter/material.dart';
import 'package:tcc/data/controllers/Cep_Controller.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/repositories/Condominium_Repository.dart';
import 'package:tcc/data/stores/Condominium_Store.dart';
import 'package:tcc/pages/syndicate%20pages/condominiums/condominiums_list.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/widgets/showDialog.dart';
import 'package:tcc/widgets/snackMessage.dart';

class CondominiumsShow extends StatefulWidget {
  final Condominium? condominium;
  CondominiumsShow({this.condominium, super.key});

  @override
  State<CondominiumsShow> createState() => _CondominiumsShowState();
}

class _CondominiumsShowState extends State<CondominiumsShow> {
  CondominiumStore store = CondominiumStore(
    repository: CondominiumRepository(
      client: HttpClient(),
    ),
  );

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _numberAddressController =
      TextEditingController();
  final TextEditingController _ufController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();

  List<dynamic> blockList = [];
  List<dynamic> aptList = [];
  String _title = "Cadastrar";
  bool _enabledAddressForm = false;

  @override
  void initState() {
    super.initState();
    if (widget.condominium != null) {
      _nameController.text = widget.condominium!.name!;
      _codeController.text = widget.condominium!.code!.toString();
      _cnpjController.text = widget.condominium!.cnpj!;
      _cepController.text = widget.condominium!.cep!.toString();
      _streetController.text = widget.condominium!.street!;
      _districtController.text = widget.condominium!.district!;
      _numberAddressController.text =
          widget.condominium!.number_address!.toString();
      _ufController.text = widget.condominium!.uf!;
      _cityController.text = widget.condominium!.city!;
      _referenceController.text = widget.condominium!.reference!;
      blockList = widget.condominium!.block!;
      aptList = widget.condominium!.number_apt!;
      _title = "Editar";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      appBar: AppBarWidget(
        title: '${_title} condomínio',
        actions: [
          (widget.condominium != null)
              ? IconButton(
                  onPressed: () {
                    WidgetShowDialog.DeleteShowDialog(
                      context,
                      _nameController.text,
                      Icons.delete_forever,
                      _deleteCondominium,
                    );
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: Config.orange,
                    size: 28,
                  ),
                )
              : Container()
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dados do condominio',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            InputWidget(
              'Nome',
              _nameController,
              TextInputType.text,
              Icons.home_work_outlined,
            ),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: InputWidget(
                    'Cnpj',
                    _cnpjController,
                    TextInputType.number,
                    Icons.description_outlined,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 2,
                  child: InputWidget(
                    'Código',
                    _codeController,
                    TextInputType.number,
                    Icons.numbers,
                    enabled: false,
                  ),
                )
              ],
            ),
            Divider(),
            GestureDetector(
              onTap: () => _saveBlockAndApt(blockList, 'bloco'),
              child: Row(
                children: [
                  Text(
                    'Bloco',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '+',
                    style: TextStyle(
                      color: Config.orange,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  )
                ],
              ),
            ),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                for (int i = 0; i < blockList.length; i++)
                  _cardBlockAndApt(blockList, i),
              ],
            ),
            Divider(),
            GestureDetector(
              onTap: () => _saveBlockAndApt(aptList, 'apartamento'),
              child: Row(
                children: [
                  Text(
                    'Apartamento',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '+',
                    style: TextStyle(
                        color: Config.orange,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  )
                ],
              ),
            ),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                for (int i = 0; i < aptList.length; i++)
                  _cardBlockAndApt(aptList, i),
              ],
            ),
            Divider(),
            Text(
              'Endereço',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InputWidget(
                    'Cep',
                    _cepController,
                    TextInputType.number,
                    Icons.location_on_outlined,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: _searchCep,
                  icon: Icon(
                    Icons.search,
                    color: Config.white,
                  ),
                  style: IconButton.styleFrom(
                    disabledBackgroundColor: Config.grey400,
                    backgroundColor: Config.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
            InputWidget(
              'Rua',
              _streetController,
              TextInputType.text,
              Icons.horizontal_distribute,
              enabled: _enabledAddressForm,
            ),
            InputWidget(
              "Bairro",
              _districtController,
              TextInputType.text,
              Icons.turn_sharp_left,
              enabled: _enabledAddressForm,
            ),
            InputWidget(
              'Cidade',
              _cityController,
              TextInputType.text,
              Icons.location_city,
              enabled: _enabledAddressForm,
            ),
            Row(
              children: [
                Expanded(
                  child: InputWidget(
                    'UF',
                    _ufController,
                    TextInputType.text,
                    Icons.map_outlined,
                    enabled: _enabledAddressForm,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InputWidget(
                    'Numero',
                    _numberAddressController,
                    TextInputType.text,
                    Icons.onetwothree,
                    enabled: _enabledAddressForm,
                  ),
                )
              ],
            ),
            InputWidget(
              'Referência',
              _referenceController,
              TextInputType.text,
              Icons.add_home_outlined,
              enabled: _enabledAddressForm,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _saveCondominium,
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
                      _title,
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
    );
  }

  Widget _cardBlockAndApt(List list, int index) {
    return InkWell(
      onTap: () {
        WidgetShowDialog.DeleteShowDialog(
          context,
          list[index],
          Icons.delete_forever_outlined,
          () {
            setState(() {
              list.remove(list[index]);
              Navigator.pop(context);
            });
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Config.grey400,
          ),
        ),
        child: FittedBox(
          child: Center(
            child: Text(list[index]),
          ),
        ),
      ),
    );
  }

  void _saveBlockAndApt(List list, String text) {
    TextEditingController _blockAndAptController = TextEditingController();

    WidgetShowDialog.CustomShowDialog(
      context: context,
      text: 'Adicionar um $text:',
      body: [
        InputWidget(
          text,
          _blockAndAptController,
          TextInputType.text,
          Icons.home_work_outlined,
        ),
      ],
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            fixedSize: Size(130, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                width: 1,
                color: Colors.black26,
              ),
            ),
          ),
          child: Text(
            'Cancelar',
            style: TextStyle(
              fontSize: 18,
              color: Config.grey800,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              list.add(_blockAndAptController.text);
            });
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: Config.orange,
            fixedSize: Size(130, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: Config.orange),
            ),
          ),
          child: Text(
            'Adicionar',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _saveCondominium() {
    Map<String, dynamic> condominium = {
      "id": (widget.condominium != null) ? widget.condominium!.id : null,
      "cnpj": _cnpjController.text,
      "name": _nameController.text,
      "cep": int.parse(_cepController.text),
      "street": _streetController.text,
      "district": _districtController.text,
      "number_address": int.parse(_numberAddressController.text),
      "uf": _ufController.text,
      "block": blockList,
      "number_apt": aptList,
      "city": _cityController.text,
      "reference": _referenceController.text,
      "syndicate": {"id": Config.user.id}
    };

    if (widget.condominium == null) {
      store.postCondomium(condominium).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CondominiumsList(),
          ),
        );
        WidgetSnackMessage.notificationSnackMessage(
          context: context,
          mensage: "${_nameController.text} foi criado com sucesso!",
        );
      });
    } else {
      store.putCondomium(condominium).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CondominiumsList(),
          ),
        );
        WidgetSnackMessage.notificationSnackMessage(
          context: context,
          mensage: "${_nameController.text} foi atualizado com sucesso!",
        );
      });
    }
  }

  void _searchCep() async {
    Map<String, dynamic> address =
        await CepController.searchCep(_cepController.text);
    if (address['error'] == null) {
      setState(() {
        _streetController.text = address['logradouro'];
        _districtController.text = address['bairro'];
        _cityController.text = address['localidade'];
        _ufController.text = address['uf'];
        _enabledAddressForm = true;
      });
    } else {
      WidgetSnackMessage.notificationSnackMessage(
        context: context,
        mensage: address['error'],
        icon: Icons.error_outline,
        backgroundColor: Config.red,
      );
    }
  }

  void _deleteCondominium() {
    store.deleteCondomium(widget.condominium!.id!);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CondominiumsList(),
      ),
    );
    WidgetSnackMessage.notificationSnackMessage(
      context: context,
      mensage: "${widget.condominium!.name!} deletado com sucesso!",
    );
  }
}
