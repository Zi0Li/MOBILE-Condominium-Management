import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String address, bool withToken = false});
  Future put({required String address, required Object object});
  Future delete({required String address});
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
    // print('GET(ADDRESS: $url$address |  TOKEN: $token)');
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
    print(
        'POST(ADDRESS: $url$address | OBJETO: ${object.toString()} | TOKEN: $token)');
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

  @override
  Future<dynamic> put({required String address, required Object object}) async {
    print(
        'PUT(ADDRESS: $url$address | OBJETO: ${object.toString()} | TOKEN: $token)');

    return client.put(
      Uri.parse("$url$address"),
      headers: requestHeaders,
      body: jsonEncode(object),
    );
  }

  @override
  Future<dynamic> delete({required String address}) {
    print('DELETE(ADDRESS: $url$address | TOKEN: $token)');

    return client.delete(
      Uri.parse("$url$address"),
      headers: requestHeaders,
    );
  }
}