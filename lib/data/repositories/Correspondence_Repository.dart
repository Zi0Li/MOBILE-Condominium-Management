import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Correspondence.dart';

abstract class ICorrespondenceRepository {
  Future<Correspondence> create(Map<String, dynamic> correspondence);
}

class CorrespondenceRepository implements ICorrespondenceRepository {
  final IHttpClient client;

  CorrespondenceRepository({required this.client});

  @override
  Future<Correspondence> create(Map<String, dynamic> map) async {
    final response = await client.post(address: "/correspondence", object: map, withToken: true);
    if (response.statusCode == 200) {
      return Correspondence.fromMap(map);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException("Error");
    }
  }
}
