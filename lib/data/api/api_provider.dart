import 'dart:convert';
import 'package:get/get.dart';

import '../../utils/global/globals_functions.dart';
import 'api_config.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  final client = http.Client();

  static String url = 'https://asia-northeast1-claha-pato.cloudfunctions.net/';

  Future<dynamic> _post(String path, {data}) async {
    try {
      var response = await client.post(
          Uri.parse(
            '$url${ApiConfig.api[path]}',
          ),
          headers: {"Content-Type": "application/json"},
          body: data);
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body) as Map;
        return decodedResponse;
      }
    } catch (e) {
      showError('error_default'.tr);
    } finally {
      client.close();
    }
  }

  // Future<dynamic> _get(String path, {queryParameters}) async {
  //   return (await _dio.get(path, queryParameters: queryParameters)).data;
  // }

  Future<dynamic> stripePayment(data) {
    return _post('stripePayment', data: data);
  }
}
