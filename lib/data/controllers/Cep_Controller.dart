import 'dart:convert';

import 'package:http/http.dart' as http;

class CepController {
  CepController._();

  static Future<Map<String, dynamic>> searchCep(String cep) async {
    Map<String, dynamic> map;
    String url = "http://viacep.com.br/ws/$cep/json/";
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      map = json.decode(response.body);
    } else if (response.statusCode == 400) {
      map = {'error': 'Cep incorreto.'};
    } else {
      map = {'error': 'Ocorreu um erro, tente novamente'};
    }
    return map;
  }
}
