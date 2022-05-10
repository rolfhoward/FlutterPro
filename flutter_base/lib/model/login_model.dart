import 'package:flutter_base/base/ResultModel.dart';
import 'package:flutter_base/net/NetUtils.dart';
import 'package:rxdart/rxdart.dart';

class LoginModel{
  Future<ResultModel> login(String username, String password){
    Map<String, String> param = {"username": username, "password": password};
    return NetUtils.getInstance().post("/v1/login", queryParameters: param);
  }
}