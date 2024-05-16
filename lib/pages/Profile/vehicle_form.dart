// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Vehicle.dart';
import 'package:tcc/data/repositories/Vehicle_Repository.dart';
import 'package:tcc/data/stores/Vehicle_Store.dart';
import 'package:tcc/pages/Profile/profile.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/widgets/loading.dart';
import 'package:tcc/widgets/showDialog.dart';
import 'package:tcc/widgets/snackMessage.dart';

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
      _selectTypeVehicle = widget.vehicle!.type!;
    }
  }

  String? _selectTypeVehicle;
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
        actions: [
          (widget.vehicle != null)
              ? IconButton(
                  onPressed: () {
                    WidgetShowDialog.DeleteShowDialog(
                      context,
                      _modelController.text,
                      Icons.delete_forever,
                      _deleteVehicle,
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
                return WidgetError.containerError(
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
            initialSelection: _selectTypeVehicle,
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
                _selectTypeVehicle = value!;
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
                    _saveAndUpdateVehicle();
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

  void _saveAndUpdateVehicle() {
    Map<String, dynamic> vehicle = {
      "id": (widget.vehicle != null) ? widget.vehicle!.id : null,
      "brand": _brandController.text,
      "model": _modelController.text,
      "year": _yearController.text,
      "plate": _plateController.text,
      "color": _colorController.text,
      "type": _selectTypeVehicle,
      "resident": {"id": Config.resident.id}
    };

    if (widget.vehicle != null) {
      store.putVehicle(vehicle).then((value) {
        print(value);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
      });
    } else {
      store.postVehicle(vehicle).then((value) {
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

  void _deleteVehicle() {
    store.deleteVehicle(widget.vehicle!.id!).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
      WidgetSnackMessage.notificationSnackMessage(
        context: context,
        mensage: "${widget.vehicle!.model!} excluído com sucesso!",
        backgroundColor: Config.green,
        icon: Icons.check,
      );
    });
  }
}
