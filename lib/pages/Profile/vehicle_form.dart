// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Vehicle.dart';
import 'package:tcc/data/repositories/Vehicle_Repository.dart';
import 'package:tcc/data/stores/Vehicle_Store.dart';
import 'package:tcc/pages/Profile/profile.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/error_message.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/widgets/loading.dart';

class VehicleForm extends StatefulWidget {
  Vehicle? vehicle;
  String title;
  VehicleForm({this.vehicle, required this.title, super.key});

  @override
  State<VehicleForm> createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  VehicleStore store = VehicleStore(
    repository: VehicleRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    if (widget.vehicle != null) {
      _plateController.text = widget.vehicle!.plate!;
      _brandController.text = widget.vehicle!.brand!;
      _colorController.text = widget.vehicle!.color!;
      _modelController.text = widget.vehicle!.model!;
      _yearController.text = widget.vehicle!.year!;
      selectTypeVehicle = widget.vehicle!.type!;
    }
  }

  String? selectTypeVehicle;
  TextEditingController _plateController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "${widget.title} veículo",
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: AnimatedBuilder(
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
          )),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputWidget(
            'Modelo',
            _modelController,
            TextInputType.text,
            Icons.car_crash_outlined,
          ),
          InputWidget("Placa", _plateController, TextInputType.text,
              Icons.nineteen_mp_outlined),
          InputWidget('Marca', _brandController, TextInputType.text,
              Icons.ballot_outlined),
          InputWidget(
            'Cor',
            _colorController,
            TextInputType.text,
            Icons.color_lens_outlined,
          ),
          InputWidget(
            'Ano',
            _yearController,
            TextInputType.text,
            Icons.calendar_month_rounded,
          ),
          SizedBox(
            height: 10,
          ),
          DropdownMenu<dynamic>(
            width: 230,
            initialSelection: selectTypeVehicle,
            label: Text(
              'Tipo',
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
                selectTypeVehicle = value!;
              });
            },
            dropdownMenuEntries:
                Config.typeVehicle.map<DropdownMenuEntry<String>>(
              (String value) {
                return DropdownMenuEntry<String>(
                  value: value,
                  label: value,
                );
              },
            ).toList(),
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    _saveVehicle();
                  },
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
          )
        ],
      ),
    );
  }

  void _saveVehicle() {
    Map<String, dynamic> Vehicle = {
      "brand": _brandController.text,
      "model": _modelController.text,
      "year": _yearController.text,
      "plate": _plateController.text,
      "color": _colorController.text,
      "type": selectTypeVehicle,
      "resident": {"id": Config.resident.id}
    };
    store.postVehicle(Vehicle).then((value) {
      if (value.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
      }
    });
  }
}
