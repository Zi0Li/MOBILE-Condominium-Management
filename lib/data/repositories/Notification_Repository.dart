import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Notification.dart';
import 'package:tcc/widgets/config.dart';

abstract class INotificationRepository {
  Future<List<NotificationMessage>> findAllByIdCondominium(int id);
  Future<void> delete(int id);
  Future<NotificationMessage> create(Map<String, dynamic> notification);
}

class NotificationRepository implements INotificationRepository {
  final IHttpClient client;

  NotificationRepository({required this.client});

  @override
  Future<List<NotificationMessage>> findAllByIdCondominium(int id) async {
    final response = await client.get(
        address: "/notification/condominium=$id", withToken: true);
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List<NotificationMessage> notificationList = [];
      body.map((item) {
        notificationList.add(NotificationMessage.fromMap(item));
      }).toList();
      return notificationList;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<NotificationMessage> create(Map<String, dynamic> notification) async {
    final response = await client.post(
      address: "/notification",
      object: notification,
      withToken: true,
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return NotificationMessage.fromMap(body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<void> delete(int id) async {
    final response = await client.delete(address: "/notification/$id");
    if (response.statusCode == 200) {
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException("Error");
    }
  }
}
