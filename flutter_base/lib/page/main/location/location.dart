import 'dart:convert';
import 'dart:math';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/resource/colors.dart';
import 'package:lpinyin/lpinyin.dart';

import 'model/CityModel.dart';

class LocationHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LocationState();
  }
}

class _LocationState extends State {
  late TextEditingController textEditingController;
  List<CityModel> cityList = [];
  double susItemHeight = 36;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    Future.delayed(Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            searchHeader(),
            Expanded(
                child: AzListView(
              data: cityList,
              itemCount: cityList.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return _buildCityHeader();
                }
                CityModel model = cityList[index];
                return getListItem(context, model);
              },
              susItemHeight: susItemHeight,
              susItemBuilder: (BuildContext context, int index) {
                CityModel model = cityList[index];
                String tag = model.getSuspensionTag();
                if ("热" == tag) {
                  return Container();
                }
                return getSusItem(context, tag, susHeight: susItemHeight);
              },
            ))
          ],
        ),
      ),
    );
  }

  Widget searchHeader() {
    return Container(
        height: 48,
        padding: EdgeInsets.only(right: 20, top: 8, bottom: 8),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset("assets/images/icon_close.png")),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: MColors.base_search_btn_color,
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                autofocus: false,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: MColors.text_grey_color,
                    ),
                    border: InputBorder.none,
                    // contentPadding: EdgeInsets.only(left: 12.0, right: 12.0),
                    hintText: '输入城市名称',
                    hintStyle:
                        TextStyle(color: MColors.color_grey_de, fontSize: 13)),
                style: TextStyle(fontSize: 13),
              ),
            ))
          ],
        ));
  }

  Widget _buildCityHeader() {
    return Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildHistoryCity(), _buildHotCity()],
        ));
  }

  static Widget getListItem(BuildContext context, CityModel model,
      {double susHeight = 40}) {
    return ListTile(
      title: Text(model.name),
      onTap: () {},
    );
  }

  static Widget getSusItem(BuildContext context, String tag,
      {double susHeight = 40}) {
    if (tag == '热') {
      tag = '★ 热门城市';
    }
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16.0),
      color: Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  Widget _buildHistoryCity() {
    List<CityModel> historyCityList = [];
    historyCityList.addAll([
      CityModel(name: "武汉市"),
      CityModel(name: "九江市"),
      CityModel(name: "成都市"),
    ]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('定位/历史城市'),
        Wrap(
          //流式布局
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 10.0,
          children: historyCityList.map((e) {
            return TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(MColors.color_grey_e),
                    foregroundColor:
                        MaterialStateProperty.all(MColors.color_grey_e),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    minimumSize: MaterialStateProperty.all(Size(1, 1)),
                    padding: MaterialStateProperty.all(EdgeInsets.only(
                        left: 16, right: 16, top: 6, bottom: 6))),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                      child: Offstage(
                        offstage: e.name != '武汉市',
                        child:
                            Image.asset("assets/images/icon_location_blue.png"),
                      ),
                      padding: EdgeInsets.only(right: e.name == '武汉市' ? 6 : 0)),
                  Text(e.name,
                      style: TextStyle(
                          color: e.name == '武汉市'
                              ? MColors.color_blue_base
                              : MColors.color_grey_a0,
                          fontSize: 14))
                ]),
                onPressed: () {
                  print("OnItemClick: $e");
                  Navigator.pop(context, e);
                });
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildHotCity() {
    List<CityModel> _hotCityList = [];
    _hotCityList.addAll([
      CityModel(name: "北京市"),
      CityModel(name: "广州市"),
      CityModel(name: "成都市"),
      CityModel(name: "深圳市"),
      CityModel(name: "杭州市"),
      CityModel(name: "武汉市"),
    ]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('热门城市'),
        Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 10.0,
          children: _hotCityList.map((e) {
            return TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(MColors.color_grey_e),
                    foregroundColor:
                        MaterialStateProperty.all(MColors.color_grey_e),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    minimumSize: MaterialStateProperty.all(Size(1, 1)),
                    padding: MaterialStateProperty.all(EdgeInsets.only(
                        left: 16, right: 16, top: 6, bottom: 6))),
                child: Text(e.name,
                    style:
                        TextStyle(color: MColors.color_grey_a0, fontSize: 14)),
                onPressed: () {
                  print("OnItemClick: $e");
                  Navigator.pop(context, e);
                });
          }).toList(),
        ),
      ],
    );
  }

  void loadData() async {
    print("city loadData");
    //加载城市列表
    rootBundle.loadString('assets/data/china.json').then((value) {
      cityList.clear();
      Map countyMap = json.decode(value);
      List list = countyMap['china'];
      list.forEach((v) {
        cityList.add(CityModel.fromJson(v));
      });
      _handleList(cityList);
    });
  }

  void _handleList(List<CityModel> list) {
    int size = list.length;
    print("city：$size");
    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp('[A-Z]').hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = '#';
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(list);
    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(cityList);

    // add hotCityList.
    cityList.insert(0, CityModel(name: 'header', tagIndex: "热"));

    setState(() {});
  }
}
