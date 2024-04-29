import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String address, bool withToken = false});
  Future post({required String address, required Object object});
}

const String url = "http://192.168.0.234:8080";
String token = "";

class HttpClient implements IHttpClient {
  final client = http.Client();
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  @override
  Future get({required String address, bool withToken = false}) async {
    print("$url$address");
    if (withToken) {
      return await client.get(Uri.parse("$url$address"),
          headers: requestHeaders);
    } else {
      return await client.get(Uri.parse("$url$address"));
    }
  }

  @override
  Future<dynamic> post(
      {required String address, required Object object}) async {
    print("TOKEN post: $token");
    print('ADDRESS: $url$address | OBJETO: ${object.toString()}');
    return client.post(
      Uri.parse("$url$address"),
      headers: requestHeaders,
      body: jsonEncode(object),
    );
  }
}
