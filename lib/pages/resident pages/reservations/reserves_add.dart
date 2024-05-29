// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Kiosk.dart';
import 'package:tcc/data/repositories/Reservation_Repository.dart';
import 'package:tcc/data/stores/Reservation_Store.dart';
import 'package:tcc/pages/resident%20pages/reservations/reserves_list.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/widgets/snackMessage.dart';

class ReservesAddPage extends StatefulWidget {
  Kiosk? kiosk;
  DateTime? dateTime;
  ReservesAddPage({required this.kiosk, required this.dateTime, super.key});

  @override
  State<ReservesAddPage> createState() => _ReservesAddPageState();
}

class _ReservesAddPageState extends State<ReservesAddPage> {
  ReservationStore store = ReservationStore(
    repository: ReservationRepository(
      client: HttpClient(),
    ),
  );

  TextEditingController _dateController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String? selectedDropDown;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('d/MM/y').format(widget.dateTime!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Nova reserva",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quiosque:',
                style: TextStyle(
                  color: Config.grey_letter,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              ListTile(
                title: Text("${widget.kiosk!.type}"),
                subtitle: Text("${widget.kiosk!.description}"),
              ),
              Divider(),
              InputWidget(
                "Data",
                _dateController,
                TextInputType.none,
                Icons.date_range_outlined,
                enabled: false,
              ),
              InputWidget(
                "Descrição",
                _descriptionController,
                TextInputType.text,
                Icons.description_outlined,
              ),
              DropdownMenu<dynamic>(
                width: 250,
                initialSelection: selectedDropDown,
                label: Text(
                  'Qtd. convidados',
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
                    selectedDropDown = value!;
                  });
                },
                dropdownMenuEntries:
                    _numberGuests().map<DropdownMenuEntry<String>>(
                  (String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  },
                ).toList(),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        _saveReserves();
                      },
                      child: Text(
                        'Reservar',
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

  void _saveReserves() {
    Map<String, dynamic> reservation = {
      "date": widget.dateTime.toString(),
      "description": _descriptionController.text,
      "resident": {"id": Config.resident.id},
      "kiosk": {"id": widget.kiosk!.id}
    };

    store.postReservation(reservation).then((value) {
      if (value.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReservesList(),
          ),
        );
        WidgetSnackMessage.notificationSnackMessage(
          context: context,
          mensage: "${widget.kiosk!.type} foi reservado com sucesso!",
        );
      }else {
        Navigator.pop(context);
        WidgetSnackMessage.notificationSnackMessage(
          context: context,
          mensage: "Erro ao reservar o quiosque!",
          backgroundColor: Config.red,
        );
      }
    });
  }

  List<String> _numberGuests({int qtd = 25}) {
    List<String> list = [];
    for (var i = 0; i < qtd; i++) {
      list.add((i + 1).toString());
    }
    return list;
  }
}
