import 'dart:io';

import 'package:http/http.dart' as http;

import 'exceptions/custom_exceptions.dart';

class NetworkService {

  static NetworkService _service;

  factory NetworkService() {
    if (_service == null) {
      _service = NetworkService._instance();
    }

    return _service;
  }

  NetworkService._instance(); 

  final String _baseUrl = "https://reqres.in/api";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http
          .get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.body;
        // print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException("Request Not Valid");
      case 401:
        throw Exception("Something went wrong");
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw Exception("Something went wrong");
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
