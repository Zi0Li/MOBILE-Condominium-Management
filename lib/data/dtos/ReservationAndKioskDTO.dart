import 'package:tcc/data/models/Kiosk.dart';
import 'package:tcc/data/models/Reservation.dart';

class ReservationAndKioskDTO {
  Reservation? reservation;
  Kiosk? kiosk;

  ReservationAndKioskDTO({
    required this.reservation,
    required this.kiosk,
  });

  factory ReservationAndKioskDTO.fromMap(Map map) {
    return ReservationAndKioskDTO(
      reservation: Reservation.fromMap(map['reservation']),
      kiosk: Kiosk.fromMap(map['kiosk']),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map;
    map = {
      'reservation': reservation,
      'kiosk': kiosk,
    };
    return map;
  }

  @override
  String toString() {
    return "ReservationAndKioskDTO(reservation: $reservation | kiosk: $kiosk)";
  }
}
