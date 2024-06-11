import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/repositories/Reservation_Repository.dart';
import 'package:tcc/data/stores/Reservation_Store.dart';
import 'package:tcc/pages/resident%20pages/reservations/reserves_calender.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/resident_drawer.dart';
import 'package:tcc/widgets/error.dart';
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
      drawer: ResidentDrawerApp(),
      appBar: AppBarWidget(
        title: 'Reservas',
        actions: [
          IconButton(
            onPressed: () {
              initializeDateFormatting().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservesForm(),
                  ),
                );
              });
            },
            icon: Icon(
              Icons.add,
              color: Config.orange,
            ),
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge(
            [store.erro, store.isLoading, store.state, store.stateDTO]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return Center(
              child: WidgetLoading.containerLoading(),
            );
          } else if (store.erro.value.isNotEmpty) {
            return WidgetError.containerError(
                store.erro.value, () => store.erro.value = '');
          } else {
            if (store.stateDTO.value.isNotEmpty) {
              return _body();
            } else {
              return Center(
                child: Text(
                  'Nenhuma reserva encontrada!',
                  style: TextStyle(fontSize: 18),
                ),
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
          child: InkWell(
            onTap: () => _showDialogDelete(index),
            child: ReservationCard(
              reservationAndKioskDTO: store.stateDTO.value[index],
            ),
          ),
        );
      },
    );
  }

  void _showDialogDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.delete_forever,
          size: 36,
          color: Colors.black,
        ),
        title: Text(
          'Deseja mesmo excluir a reserva ${store.stateDTO.value[index].reservation!.first.description}?',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              fixedSize: Size(130, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 1, color: Colors.black26),
              ),
            ),
            child: Text(
              'Cancelar',
              style: TextStyle(fontSize: 18, color: Config.grey800),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              _deleteReservation(store.stateDTO.value[index].reservation!.first.id!);
            },
            style: TextButton.styleFrom(
              backgroundColor: Config.orange,
              fixedSize: Size(130, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 1, color: Config.orange),
              ),
            ),
            child: Text('Sim, excluir',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }

    void _getReservation() {
    store.getReservationByResident(Config.user.id);
  }

  void _deleteReservation(int id){
    store.deleteReservation(id).then((value){
      Navigator.pop(context);
      _getReservation();
    });
  }
}
