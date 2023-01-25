import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../utils/global/globals_functions.dart';
import '../../utils/global/globals_variable.dart';

final interceptor = InterceptorsWrapper(
  onRequest: (options, handler) {
    // options.headers['Authorization'] =
    //     'Bearer ' + (global_variable.idToken ?? '');
    loading.value = true;
    return handler.next(options);
  },
  onResponse: (options, handler) {
    loading.value = false;
    if (options.requestOptions.baseUrl == ApiProvider.url) {
      if (options.data['status'] == 'failed') {
        final message = options.data['message'];
        if (message != null && message['data'] != null) {
          final data = message['data'];
          if (data != null && data['message'] != null) {
            showError('${data['message']}');
          } else {
            showError('error_message'.tr);
          }
        } else {
          showError('error_message'.tr);
        }
      } else {
        return handler.next(options);
      }
    } else {
      return handler.next(options);
    }
  },
  onError: (e, handler) {
    showError('error_message'.tr);
    loading.value = false;
    return handler.next(e);
  },
);

class ApiProvider {
  static String url = 'http://113.160.132.252:8888/';
  static BaseOptions baseOptions = BaseOptions(baseUrl: url);

  final Dio _dio = Dio(baseOptions)..interceptors.add(interceptor);

  Future<dynamic> _post(String path, {data}) async {
    return (await _dio.post(path, data: data)).data;
  }

  Future<dynamic> _get(String path, {queryParameters}) async {
    return (await _dio.get(path, queryParameters: queryParameters)).data;
  }
}
