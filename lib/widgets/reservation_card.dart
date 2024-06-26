// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/data/dtos/ReservationAndKioskDTO.dart';
import 'package:tcc/data/models/Kiosk.dart';
import 'package:tcc/data/models/Reservation.dart';
import 'package:tcc/widgets/config.dart';

class ReservationCard extends StatelessWidget {
  ReservationAndKioskDTO reservationAndKioskDTO;
  ReservationCard({required this.reservationAndKioskDTO, super.key});

  @override
  Widget build(BuildContext context) {
    List<Reservation> reservations = reservationAndKioskDTO.reservation!;
    Kiosk kiosk = reservationAndKioskDTO.kiosk!;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: Config.grey600,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reservations.first.description!,
              style: TextStyle(
                color: Config.orange,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            Divider(
              color: Config.grey400,
            ),
            Row(
              children: [
                Config.text('Local: ', kiosk.type!, 16),
              ],
            ),
            Config.text('Descrição: ', kiosk.description!, 16),
            Row(
              children: [
                Config.text('Início: ', DateFormat('d/MM/y').format(DateTime.parse(reservations.first.date!)), 16),
                Spacer(),
                Config.text('Convidados: ', '25', 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
