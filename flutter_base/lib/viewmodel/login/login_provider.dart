import 'dart:core';

import 'package:flutter_base/base/base_provider.dart';
import 'package:flutter_base/model/login_model.dart';
import 'package:flutter_base/util/string_utils.dart';

class LoginProvider extends BaseProvider {
  LoginModel _loginModel = LoginModel();

  Future login(String username, String password){
    var _password = generateMd5(password);
    return _loginModel.login(username, _password);
  }

}
