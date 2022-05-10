import 'package:flutter_base/base/ResultModel.dart';
import 'package:flutter_base/net/NetUtils.dart';
import 'package:rxdart/rxdart.dart';

class HomeModel{
  Future<ResultModel> loadJellyGardenList(String url, Map<String, dynamic> param){
    return NetUtils.getInstance().post(url, queryParameters: param);
  }

  Future<ResultModel> loadPublishNoticeList(String url, Map<String, dynamic> param) {
    return NetUtils.getInstance().post(url, queryParameters: param);
  }
}