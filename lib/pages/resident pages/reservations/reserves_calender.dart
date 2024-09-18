import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tcc/data/dtos/ReservationAndKioskDTO.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Kiosk.dart';
import 'package:tcc/data/repositories/Kiosk_repository.dart';
import 'package:tcc/data/stores/Kiosk_Store.dart';
import 'package:tcc/pages/resident%20pages/reservations/reserves_add.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';

List<ReservationAndKioskDTO> auxlist = [];

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 6, kToday.day);

class ReservesForm extends StatefulWidget {
  const ReservesForm({super.key});

  @override
  State<ReservesForm> createState() => _ReservesFormState();
}

class _ReservesFormState extends State<ReservesForm> {
  late final ValueNotifier<List<Kiosk>> _selectedReservations;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Kiosk> allKioks = [];

  KioskStore store = KioskStore(
    repository: KioskRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedReservations =
        ValueNotifier(_getReservationsForDay(_selectedDay!));

    _getAllDetails();
  }

  @override
  void dispose() {
    _selectedReservations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      appBar: AppBarWidget(
        title: 'Cadastrar reserva',
      ),
      body: AnimatedBuilder(
        animation:
            Listenable.merge([store.erro, store.isLoading, store.stateDTO]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return Center(
              child: WidgetLoading.containerLoading(),
            );
          } else if (store.erro.value.isNotEmpty) {
            return WidgetError.containerError(
                store.erro.value, () => store.erro.value = '');
          } else {
            return _body(store.stateDTO.value);
          }
        },
      ),
    );
  }

  Widget _body(List<ReservationAndKioskDTO> list) {
    return Column(
      children: [
        TableCalendar<Kiosk>(
          locale: 'pt_BR',
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          eventLoader: _getReservationsForDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          onDaySelected: _onDaySelected,
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Config.orange,
            ),
          ),
        ),
        Divider(),
        Expanded(
          child: ValueListenableBuilder<List<Kiosk>>(
            valueListenable: _selectedReservations,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: allKioks.length,
                itemBuilder: (context, index) {
                  String status = 'Disponível';
                  Color statusColor = Config.orange;
                  bool isReserved = false;
                  for (var i = 0; i < value.length; i++) {
                    if (allKioks[index].id == value[i].id) {
                      status = 'Indisponível';
                      statusColor = Config.grey600;
                      isReserved = true;
                    }
                  }

                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      onTap: () {
                        if (isReserved) {
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservesAddPage(
                                kiosk: allKioks[index],
                                dateTime: _focusedDay,
                              ),
                            ),
                          );
                        }
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${allKioks[index].type}'),
                          Text(
                            '$status',
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text('${allKioks[index].description}'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _getAllDetails() {
    store.getAllDetails(Config.user.id).then((value) {
      for (var element in value) {
        allKioks.add(element.kiosk!);
      }
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedReservations.value = _getReservationsForDay(selectedDay);
    }
  }

  List<Kiosk> _getReservationsForDay(DateTime day) {
    Map<DateTime, List<Kiosk>> reservations = {};

    for (var element in store.stateDTO.value) {
      for (var i = 0; i < element.reservation!.length; i++) {
        DateTime date = DateTime.parse(element.reservation![i].date!);
        if (!reservations.containsKey(date)) {
          reservations[date] = [];
        }
        reservations[date]!.add(element.kiosk!);
      }
    }

    return reservations[day] ?? [];
  }
}
