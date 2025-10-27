import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:b2c_platform/src/common/constants.dart' as constants;
import 'package:b2c_platform/src/common/utils/shared_preference.dart';

import '../core/error/error_response_model.dart';
import '../core/error/exception.dart';



class API {
  final String _endpoint = '';

  late BaseOptions options;

  late final Dio dio = Dio(options);

  API() {
    options = BaseOptions(
      baseUrl: _endpoint,
      contentType: Headers.jsonContentType,
      connectTimeout:
          Duration(milliseconds: constants.httpStatusCode.connectTimeout),
      receiveTimeout:
          Duration(milliseconds: constants.httpStatusCode.receiveTimeout),
    );
    dio.interceptors.add(_TokenInterceptor());
  }

  handleDioException(DioException e) {
    try{
      if (e.response?.statusCode != null && e.response!.statusCode! >= 500) {
        throw ServerException(messageError: e.response?.data['detail'] ?? e.error.toString());
      } else {
        final err = ErrorResponseModel.fromJson(e.response?.data);
        throw CacheException(messageError: err.details);
      }
    }catch (exe){
      throw CacheException(messageError: e.response?.data.toString());
    }
  }

}

class _TokenInterceptor extends Interceptor {
  _TokenInterceptor();

  int tryRefreshCount = 0;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String defaultConfig = '${options.method} ${options.path}';

    String? authToken = SharedPrefs().getAccessToken();
    if (authToken != null && authToken != '') {
      options.headers['Authorization'] = 'Bearer $authToken';
    }

    if (options.data != null) {
      if (options.data is FormData) {
        debugPrint(
          '--> $defaultConfig Request data: ${options.data.files ?? ''} ${options.data.fields ?? ''}',
        );
      } else {
        debugPrint(
          '--> $defaultConfig Request queryParameters: ${options.queryParameters.entries}',
        );
      }
    }

    if (options.headers.isNotEmpty) {
      debugPrint('--> $defaultConfig Request headers: ${options.headers}');
    }

    if (options.queryParameters.entries.isNotEmpty) {
      debugPrint(
        '--> $defaultConfig Request queryParameters: ${options.queryParameters.entries}',
      );
    }

    debugPrint('--- $defaultConfig');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if(response.requestOptions.path.contains('?page=')){
      debugPrint(
        '<-- ${response.requestOptions.method} ${response.requestOptions.path} ${response.statusCode}',
      );
    } else {
      debugPrint(
        '<-- ${response.requestOptions.method} ${response.requestOptions.path} ${response.statusCode} ${response.data}',
      );
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint('Error -->');
    debugPrint('${error.message} ${error.error}');
    debugPrint(error.response?.data.toString());
    debugPrint('Error -->');
    String? refresh = SharedPrefs().getRefreshToken();
    try{
      if(error.response?.data != null && error.response?.data['code'] == 'user_inactive'){
        SharedPrefs().deleteTokens();
      } else if (error.response?.statusCode == 401 && refresh != null && tryRefreshCount < 3) {
        tryRefreshCount++;
        if (kDebugMode) {
          log('first step of refresh');
        }
        final response = await http.post(
          Uri.parse('${constants.host}user/api/token/refresh/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'refresh': refresh,
          }),
        );

        if (kDebugMode) {
          print('${constants.host}user/api/token/refresh/');
          log(response.body);
        }
        if (response.statusCode == 200) {
          log('refreshToken', name: 'RefreshToken SUCCESS');
          SharedPrefs().setAccessToken(jsonDecode(response.body)['access']);
        }else{
          log('refreshToken', name: 'RefreshToken failed');
          SharedPrefs().deleteTokens();
        }
        return handler.resolve(await retry(requestOptions: error.requestOptions));
      } else {
        return super.onError(error, handler);
      }
    } catch (e){
      return super.onError(error, handler);
    }
  }
  Future<Response> retry({required RequestOptions requestOptions}) {
    String? authToken = SharedPrefs().getRefreshToken();
    Options options = Options(method: requestOptions.method, headers: authToken != null && authToken != '' ? {
      'Authorization': 'Bearer $authToken',
    } : {});
    return API().dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
