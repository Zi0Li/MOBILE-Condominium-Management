import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/repositories/Reservation_Repository.dart';
import 'package:tcc/data/stores/Reservation_Store.dart';
import 'package:tcc/pages/reservations/reserves_form.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawer.dart';
import 'package:tcc/widgets/error_message.dart';
import 'package:tcc/widgets/loading.dart';
import 'package:tcc/widgets/reservation_card.dart';

class ReservesList extends StatefulWidget {
  const ReservesList({super.key});

  @override
  State<ReservesList> createState() => _ReservesListState();
}

class _ReservesListState extends State<ReservesList> {
  @override
  void initState() {
    super.initState();
    _getReservation();
  }

  final ReservationStore store = ReservationStore(
    repository: ReservationRepository(
      client: HttpClient(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      drawer: DrawerApp(),
      appBar: AppBarWidget(
        title: 'Reservas',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReservesForm(),
                ),
              );
            },
            icon: Icon(
              Icons.add,
              color: Config.orange,
            ),
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([store.erro, store.isLoading, store.state, store.stateDTO]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return Center(child: WidgetLoading.containerLoading(),);
          } else if (store.erro.value.isNotEmpty) {
            return ErrorMessage.containerError(
                store.erro.value, () => store.erro.value = '');
          } else {
            if (store.stateDTO.value.isNotEmpty) {
              return _body();
            } else {
              return Center(
                child: Text('Nenhuma reserva encontrada!', style: TextStyle(fontSize: 18),),
              );
            }
          }
        },
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: store.stateDTO.value.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: ReservationCard(reservationAndKioskDTO: store.stateDTO.value[index]),
        );
      },
    );
  }

  void _getReservation() {
    store.getReservationByResident(Config.resident.id);
  }
}
