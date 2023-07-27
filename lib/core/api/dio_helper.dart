import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioManager {
  Dio? _dio;

  static final DioManager _dioManager = DioManager._instance();

  factory DioManager() => _dioManager;
  DioManager._instance() {
    if (_dio == null) {
      _init();
    }
  }
  _init() {
    _dio?.close(force: true);
    _dio = null;
    _dio = Dio(BaseOptions(
        baseUrl:
            'https://translated-mymemory---translation-memory.p.rapidapi.com/get',
        receiveDataWhenStatusError: true,
        connectTimeout: 60000,
        sendTimeout: 60000,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'X-RapidAPI-Key':
              '99bb8e3eaamsh4e7a56558ea4ab2p18706ajsnb5ba18440eea',
          'X-RapidAPI-Host':
              'translated-mymemory---translation-memory.p.rapidapi.com'
        }));
    _dio!.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true));
  }

  Future getData<T>({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Function(T response)? onSuccess,
    Function(String error)? onError,
  }) async {
    try {
      final response = await _dio!.get(url, queryParameters: query);
      debugPrint("next");
      if (response.statusCode == 200) {
        onSuccess?.call(response.data);
      } else {
        onError?.call("Error");
      }
    } on DioError catch (e) {
      onError?.call("Dio Error ${e.message}");
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Response dioError(DioError e) {
    if (e.response != null) {
      return e.response!;
    } else {
      return Response(
          requestOptions: RequestOptions(path: ""),
          statusCode: 500,
          statusMessage: e.message);
    }
  }
}

class HeadersInterceptors extends InterceptorsWrapper {
  var encryptResult = '';
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      'X-RapidAPI-Key': '99bb8e3eaamsh4e7a56558ea4ab2p18706ajsnb5ba18440eea',
      'X-RapidAPI-Host': 'just-translated.p.rapidapi.com'
    });
    return super.onRequest(options, handler);
  }
}
