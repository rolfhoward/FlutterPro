import 'dart:core';

import 'package:flutter/services.dart';
import 'package:flutter_base/base/ResultModel.dart';
import 'package:flutter_base/base/base_provider.dart';
import 'package:flutter_base/model/login_model.dart';
import 'package:flutter_base/net/NetUtils.dart';
import 'package:flutter_base/util/dialog_utils.dart';
import 'package:flutter_base/util/preferences_utils.dart';
import 'package:flutter_base/util/string_utils.dart';
import 'package:rxdart/rxdart.dart';

class LoginProvider extends BaseProvider {
  LoginModel _loginModel = LoginModel();

  Observable login(String username, String password){
    var _password = generateMd5(password);
    return _loginModel.login(username, _password).doOnData((data){
      SharePreferencesUtils.getSharePreferencesInstance().saveDynamicMap("user", data.data);
    });
  }

}
