import 'package:tcc/data/models/Kiosk.dart';
import 'package:tcc/data/models/Reservation.dart';

class ReservationAndKioskDTO {
  List<Reservation>? reservation;
  Kiosk? kiosk;

  ReservationAndKioskDTO({
    required this.reservation,
    required this.kiosk,
  });

  factory ReservationAndKioskDTO.fromMap(Map map) {
    List<Reservation>? reservationList = [];
    map['reservation'].map((item) {
        final Reservation reservation = Reservation.fromMap(item);
        reservationList.add(reservation);
      }).toList();
    return ReservationAndKioskDTO(
      reservation: reservationList,
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
