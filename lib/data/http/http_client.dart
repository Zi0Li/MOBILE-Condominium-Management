import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String address, bool withToken = false});
  Future post(
      {required String address,
      required Object object,
      bool withToken = false});
}

const String url = "http://192.168.0.211:8080";
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
      {required String address,
      required Object object,
      bool withToken = false}) async {
    print('ADDRESS: $url$address | OBJETO: ${object.toString()} | "TOKEN post: $token"');
    if (withToken) {
      return client.post(
        Uri.parse("$url$address"),
        headers: requestHeaders,
        body: jsonEncode(object),
      );
    } else {
      return client.post(
        Uri.parse("$url$address"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(object),
      );
    }
  }
}
