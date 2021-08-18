import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    //TODO:Edit the base url here
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://www.breakingbadapi.com/api/',
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }

  //===============================================================
  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

//===============================================================
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}