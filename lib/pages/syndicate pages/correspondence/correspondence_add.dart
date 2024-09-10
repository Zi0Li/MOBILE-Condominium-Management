import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/data/repositories/Correspondence_Repository.dart';
import 'package:tcc/data/repositories/Resident_Repository.dart';
import 'package:tcc/data/stores/Correspondence_Store.dart';
import 'package:tcc/data/stores/Resident_Store.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/input.dart';

class CorrespondenceAddPage extends StatefulWidget {
  const CorrespondenceAddPage({super.key});

  @override
  State<CorrespondenceAddPage> createState() => _CorrespondenceAddPageState();
}

class _CorrespondenceAddPageState extends State<CorrespondenceAddPage> {
  Resident? resident;

  ResidentStore residentStore = ResidentStore(
    repository: ResidentRepository(
      client: HttpClient(),
    ),
  );

  CorrespondenceStore correspondenceStore = CorrespondenceStore(
    repository: CorrespondenceRepository(
      client: HttpClient(),
    ),
  );

  TextEditingController _senderController = TextEditingController();
  TextEditingController _hoursController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  var _cpfOrRgController = new MaskedTextController(mask: '000.000.000-00');

  @override
  void initState() {
    super.initState();
    _cpfOrRgController.beforeChange = (String previous, String next) {
      if (next.length > 12) {
        if (_cpfOrRgController.mask != '000.000.000-00')
          _cpfOrRgController.updateMask('000.000.000-00');
      } else {
        if (_cpfOrRgController.mask != '00.000.000-0')
          _cpfOrRgController.updateMask('00.000.000-0');
      }
      return true;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Adicionar uma correspondência',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dados do pacote',
                style: TextStyle(
                  color: Config.grey_letter,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              InputWidget(
                "Remetente",
                _senderController,
                TextInputType.name,
                Icons.send_outlined,
              ),
              InputWidget(
                "Data",
                _dateController,
                TextInputType.datetime,
                Icons.date_range_rounded,
              ),
              InputWidget(
                "Horas",
                _hoursController,
                TextInputType.datetime,
                Icons.timer_outlined,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Dados do pacote',
                style: TextStyle(
                  color: Config.grey_letter,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(233, 233, 233, 1),
                        ),
                        child: TextFormField(
                          controller: _cpfOrRgController,
                          style: TextStyle(fontSize: 14),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Digite cpf ou rg',
                            hintStyle: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () => _getSearch(_cpfOrRgController.text),
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
                  ),
                ],
              ),
              if (resident != null) _cardResident(resident!),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _createCorrepondence,
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
                        "Cadastrar",
                        style: TextStyle(
                          color: Config.backgroundColor,
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

  Widget _cardResident(Resident resident) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage("img/perfil.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resident.name!,
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                    Divider(),
                    Text(
                      "${resident.block} - ${resident.apt}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Divider(),
                    Config.text('CPF: ', resident.cpf!, 18),
                    Config.text('RG: ', resident.rg!, 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _getSearch(String? search) {
    resident = null;
    if (search!.isNotEmpty) {
      residentStore.getResidentSearch(search).then(
        (value) {
          setState(() {
            print(value);
            resident = value;
          });
        },
      );
    } else {
      setState(() {
        resident = null;
      });
    }
    FocusScope.of(context).nextFocus();
    _cpfOrRgController.clear();
  }

  void _createCorrepondence() {
    if (resident != null) {
      Map<String, dynamic> correspondence = {
        'sender': _senderController.text,
        'date': _dateController.text,
        'hours': _hoursController.text,
        'resident': {
          'id': resident!.id,
        }
      };

      correspondenceStore.create(correspondence).then(
        (value) {
          print(value);
        },
      );
    } else {}
  }
}
