import 'package:flutter_base/base/ResultModel.dart';
import 'package:flutter_base/base/api_config.dart';
import 'package:flutter_base/base/base_provider.dart';
import 'package:flutter_base/model/home/home_model.dart';

class HomeProvider extends BaseProvider{
  HomeModel _homeModel = HomeModel();
  var get_jellygarden_list = "/user/list";
  var get_publishNotice_list = "/publishNotice/list";

  //获取果冻花园首页数据
  Future<ResultModel> loadJellyGardenList(int? index, int page){
    Map<String, dynamic> param = {"page": page, "size": ApiConfig.BASE_PAGE_SIZE};
    return _homeModel.loadJellyGardenList(get_jellygarden_list, param);
  }

  //获取寂寞告白数据
  Future<ResultModel> loadPublishNoticeList(int page){
    Map<String, dynamic> param = {"page": page, "size": ApiConfig.BASE_PAGE_SIZE};
    return _homeModel.loadPublishNoticeList(get_publishNotice_list, param);
  }
}