import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: Config.dark_purple,
        title: Text(
          'Reservas',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
