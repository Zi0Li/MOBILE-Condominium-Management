import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/repositories/Kiosk_repository.dart';
import 'package:tcc/data/stores/Kiosk_Store.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawer.dart';
import 'package:tcc/widgets/input.dart';
import 'package:intl/intl.dart';

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
)..addAll(_kEventSource);

Map<DateTime, List<Event>> _kEventSource = Map.fromIterable(
  List.generate(50, (index) => index),
  key: (item) {
    return DateTime.utc(2024, 6, item * 5);
  }, //define a data da agenda
  value: (item) => [
    Event('Event $item | TESTE 1'),
    Event('Event $item | TESTE 2'),
  ], //Lista de eventos da data
);

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 6, kToday.day);

class ReservesForm extends StatefulWidget {
  const ReservesForm({super.key});

  @override
  State<ReservesForm> createState() => _ReservesFormState();
}

class _ReservesFormState extends State<ReservesForm> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  KioskStore kioskStore = KioskStore(
    repository: KioskRepository(
      client: HttpClient(),
    ),
  );

  TextEditingController _nounController = TextEditingController();
  TextEditingController _dateStartController = TextEditingController();
  TextEditingController _dateEndController = TextEditingController();
  TextEditingController _guestController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    _getAllDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      drawer: DrawerApp(),
      appBar: AppBarWidget(
        title: 'Cadastrar reserva',
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay, // O minimo de dia do calendario
            lastDay: kLastDay, // O maximo de dia no calendario
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek
                .monday, // primeiro dia que ficara no calendario
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) {
              //Define o primeiro dia do mes
              print("FOCUSDAY - $focusedDay");
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          InputWidget(
            'Local',
            _nounController,
            TextInputType.text,
            Icons.location_on_outlined,
          ),
          InputWidget(
            'Convidados',
            _guestController,
            TextInputType.text,
            Icons.format_list_numbered_rounded,
          ),
          Row(
            children: [
              Flexible(
                child: _inputCallender(),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: InputWidget(
                  'Data termino',
                  _dateEndController,
                  TextInputType.text,
                  Icons.date_range_outlined,
                ),
              ),
            ],
          ),
          Divider(
            color: Config.light_purple,
            height: 1,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    fixedSize: Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(
                      width: 1,
                      color: Config.light_purple,
                    ),
                  ),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Config.light_purple,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {},
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
                    'Salvar',
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
    );
  }

  Widget _inputCallender() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        child: TextFormField(
          validator: Config.validator,
          controller: _dateStartController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Data de inicio",
            hintStyle: TextStyle(
              color: Config.grey400,
            ),
            prefixIcon: Icon(
              Icons.date_range_outlined,
              color: Config.grey600,
            ),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
              currentDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: Config.orange, // header background color
                      onPrimary: Colors.white, // header text color
                      onSurface: Config.black, // body text color
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black, // button text color
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedDate != null) {
              setState(() {
                _dateStartController.text =
                    DateFormat('dd/MM/yyyy').format(pickedDate);
                ;
              });
            }
          },
        ),
      ),
    );
  }

  void _getAllDetails() {
    kioskStore
        .getAllDetails(Config.resident.id)
        .then((value) => print('VALUE: $value'));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    //print('Puxando todos os eventos $day');
    // Implementation example
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print(
        'Selecionou um dia | selectedDay: $selectedDay | focusedDay $focusedDay');
    if (!isSameDay(_selectedDay, selectedDay)) {
      print('TESTE');
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
      print('SELECTEDEVENTS $_selectedEvents');
    }
  }
}

class Event {
  final String title;
  const Event(this.title);

  @override
  String toString() => title;
}