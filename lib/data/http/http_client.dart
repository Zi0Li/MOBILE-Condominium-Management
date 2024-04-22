import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String address});
  Future post({required String address, required Object object});
}

const String url = "http://192.168.0.211:8080";
String token = "";

class HttpClient implements IHttpClient {
  final client = http.Client();
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
  };

  @override
  Future get({required String address}) async {
    print("$url$address");
    return await client.get(Uri.parse("$url$address"), headers: requestHeaders);
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