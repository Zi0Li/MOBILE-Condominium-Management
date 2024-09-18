import 'dart:convert';

import 'package:tcc/data/dtos/ReservationAndKioskDTO.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Reservation.dart';
import 'package:tcc/widgets/config.dart';

abstract class IReservationRepository {
  Future<List<ReservationAndKioskDTO>> getReservationByResident(int id);
  Future<Reservation> postReservation(Map<String, dynamic> reservation);
  Future<void> deleteReservation(int id);
}

class ReservationRepository implements IReservationRepository {
  final IHttpClient client;

  ReservationRepository({required this.client});

  @override
  Future<List<ReservationAndKioskDTO>> getReservationByResident(int id) async {
    final response =
        await client.get(address: "/reservation/resident=$id", withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<ReservationAndKioskDTO> reservationList = [];
      body.map((item) {
        reservationList.add(ReservationAndKioskDTO.fromMap(item));
      }).toList();
      return reservationList;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<Reservation> postReservation(Map<String, dynamic> reservation) async {
    final response = await client.post(
        address: "/reservation", object: reservation, withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Reservation.fromMap(body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<void> deleteReservation(int id) async {
    final response = await client.delete(address: "/reservation/$id");
    if (response.statusCode == 200) {
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException("Erro desconhecido!");
    }
  }
}
