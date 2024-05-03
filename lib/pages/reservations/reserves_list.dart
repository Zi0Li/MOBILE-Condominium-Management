import 'package:flutter/material.dart';
import 'package:tcc/pages/reservations/reserves_form.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawer.dart';

class ReservesList extends StatefulWidget {
  const ReservesList({super.key});

  @override
  State<ReservesList> createState() => _ReservesListState();
}

class _ReservesListState extends State<ReservesList> {
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
      body: SingleChildScrollView(
        child: Center(
          child: Text('Nenhuma reserva realizada'),
        ),
      ),
    );
  }
}
