import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_base/base/ResultModel.dart';
import 'package:flutter_base/base/api_config.dart';
import 'package:rxdart/rxdart.dart';

enum Method {
  GET,
  POST,
  UPLOAD,
  DOWNLOAD,
}

class NetUtils{

  static final NetUtils _instance = NetUtils._();

  Dio? dio;
  BaseOptions? options;
// 私有构造器
  NetUtils._(){
    dio = new Dio()
      ..options = BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          connectTimeout: 10000,
          receiveTimeout: 10000);
  }

  static NetUtils getInstance() =>_instance;



  Future<ResultModel> post(String url,{dynamic body,Map<String, dynamic>? queryParameters}) =>
      _post(url, body: body,queryParameters: queryParameters);

  Future<ResultModel> _post(String url, {dynamic body, Map<String, dynamic>? queryParameters}) async {
    var response = await dio?.post(url, data: body, queryParameters: queryParameters);
    var res = ResultModel.fromJson(response?.data);
    return res;
  }

  static Future<ResultModel> postT(String url, {Map<String, dynamic>? params, Function? errorCallback}) async{
    Dio dio = Dio();
    Response response = await dio.post(url, queryParameters:params);
    return handleDataSource(response);
  }

  Future<ResultModel> getT(String url, {Map<String, dynamic>? params}) async {
    var response = await dio!.post(url, queryParameters: params);
    return response.data;
  }

  static  handleDataSource (Response response){
    int code = response.statusCode!;
    print("code:$code");
    if(code == 200){
      print(response.data);
      String res2Json  = json.encode(response.data);
      Map<String,dynamic> map=json.decode(res2Json);
      return map["data"];
    }
  }
}

