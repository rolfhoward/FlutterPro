import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/page/main/home/model/JellyGardenUserListModel.dart';
import 'package:flutter_base/page/main/location/LocationUtils.dart';
import 'package:flutter_base/page/main/location/location.dart';
import 'package:flutter_base/resource/colors.dart';
import 'package:flutter_base/viewmodel/home/home_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class JellyGardenHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new JellyGardenState();
  }
}

class JellyGardenState extends State<JellyGardenHome>
    with SingleTickerProviderStateMixin {
  LocationUtils locationUtils = new LocationUtils();
  var _locationAddress = "定位中";
  List tabs = ["热门", "新来", "认证"];

  //用于控制/监听Tab菜单切换
  //TabBar和TabBarView正是通过同一个controller来实现菜单切换和滑动状态同步的。
  TabController? tabController;
  int? _currentIndex = 0; //tab下标
  JellyGardenUserListModel? resultModel;
  HomeProvider _homeProvider = HomeProvider();
  List<JellyGardenUserModel>? userModelList = new List<JellyGardenUserModel>.empty();
  var page = 1;

  @override
  void initState() {
    super.initState();
    //定位初始化
    locationUtils.init();
    //获取当前位置
    locationUtils.startLocation();
    locationUtils.setCompleteCallbackListener((result){
      Map<String, Object>? locationResult = result;
      String address = locationResult!['city'].toString();
      setState(() {
        _locationAddress = address;
      });
    });

    tabController = TabController(length: tabs.length, vsync: this);
    tabController?.addListener(() => _onTabChanged());
    getData();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        backgroundColor: MColors.white,
        body: new SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      width: 88,
                      child: TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.only(left: 12, right: 18)),
                          overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                        ),
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LocationHome())),
                        child: Row(children: <Widget>[
                          Text(_locationAddress,
                              style: TextStyle(
                                  color: MColors.text_grey_color,
                                  fontSize: 14)),
                          Padding(padding: EdgeInsets.only(left: 7)),
                          Image.asset("assets/images/icon_arrow_down.png"),
                        ]),
                      )),
                  Expanded(
                      flex: 1,
                      child: FlatButton(
                        color: MColors.base_search_btn_color,
                        highlightColor: MColors.base_search_btn_color,
                        splashColor: MColors.base_search_btn_color,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(children: <Widget>[
                          Icon(
                            Icons.search,
                            color: MColors.text_grey_color,
                          )
                        ]),
                        onPressed: () {},
                      )),
                  Container(
                      width: 48,
                      child: FlatButton(
                          highlightColor: Colors.white,
                          splashColor: Colors.white,
                          child: Image.asset("assets/images/icon_exchange.png"),
                          onPressed: () {}))
                ],
              ),
              Container(
                  padding: EdgeInsets.only(left: 22, right: 22),
                  child: buildTabBar()),
              //设置选项卡对应的page
              Expanded(child: buildBodyView())
            ],
          ),
        ));
  }

  buildTabBar() {
    //构造 TabBar
    Widget tabBar = TabBar(
        //tabs 的长度超出屏幕宽度后，TabBar，是否可滚动
        //设置为false tab 将平分宽度，为true tab 将会自适应宽度
        isScrollable: false,
        //设置tab文字得类型
        labelStyle: TextStyle(fontSize: 15),
        //设置tab选中得颜色
        labelColor: MColors.base_color,
        //设置tab未选中得颜色
        unselectedLabelColor: MColors.text_grey_color,
        //设置自定义tab的指示器，CustomUnderlineTabIndicator
        //若不需要自定义，可直接通过
        //indicatorColor 设置指示器颜色
        //indicatorWight 设置指示器厚度
        //indicatorPadding
        //indicatorSize  设置指示器大小计算方式
        ///指示器大小计算方式，TabBarIndicatorSize.label跟文字等宽,TabBarIndicatorSize.tab跟每个tab等宽
        indicatorSize: TabBarIndicatorSize.tab,
        //生成Tab菜单
        controller: tabController,
        //构造Tab集合
        tabs: tabs.map((e) => Tab(text: e)).toList());

    return tabBar;
  }

  buildBodyView() {
    //构造 TabBarView
    Widget tabBarBodyView = TabBarView(
      controller: tabController,
      //创建Tab页
      children: tabs.map((e) {
        return Container(
//          alignment: Alignment.center,
          child: buildData(),
        );
      }).toList(),
    );
    return tabBarBodyView;
  }

  Widget buildData() {
    if (resultModel == null) {
      return Container(
        alignment: Alignment.center,
        child: Text("数据加载中..."),
      );
    }

    if (userModelList!.length <= 0) {
      return Container(
        alignment: Alignment.center,
        child: Text("暂无数据"),
      );
    }
    return new SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
            itemCount: userModelList?.length,
            itemBuilder: (context, item) {
              return buildListData(context, userModelList![item]);
            }));
  }

  Widget buildListData(BuildContext context, JellyGardenUserModel data) {
    return Container(
      margin: EdgeInsets.only(left: 12, top: 15, right: 12, bottom: 15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              width: 70,
              height: 70,
              child: Stack(
                children: <Widget>[
                  Container(
                      width: 65,
                      height: 65,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(data.photo!),
                        backgroundColor: MColors.base_color,
                        radius: 40.0,
                      )),
                  Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                          padding: EdgeInsets.only(
                              top: 3, left: 5, right: 5, bottom: 3),
                          decoration: BoxDecoration(
                            color: MColors.base_red_color,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            "已认证",
                            style: TextStyle(fontSize: 8, color: Colors.white),
                          )))
                ],
              )),
          Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(data.nickName!,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Image.asset("assets/images/icon_album.png"),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Text("2",
                            style: TextStyle(
                                fontSize: 14, color: MColors.base_red_color))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("北京市海淀区",
                            style: TextStyle(
                                fontSize: 14, color: MColors.text_grey_color)),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Text("|",
                            style: TextStyle(
                                fontSize: 14, color: MColors.text_grey_color)),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Text("26岁",
                            style: TextStyle(
                                fontSize: 14, color: MColors.text_grey_color)),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Text("|",
                            style: TextStyle(
                                fontSize: 14, color: MColors.text_grey_color)),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Text("程序猿",
                            style: TextStyle(
                                fontSize: 14, color: MColors.text_grey_color)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: <Widget>[
                              Image.asset("assets/images/icon_location.png"),
                              Padding(padding: EdgeInsets.only(left: 5)),
                              Text("100m",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: MColors.text_grey_color)),
                              Padding(padding: EdgeInsets.only(left: 14)),
                              Text("当前在线",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: MColors.text_grey_color)),
                            ],
                          ),
                        ),
                        Container(
                            child: Container(
                                child: Image.asset(
                                    "assets/images/icon_praise_empty.png")))
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  getData() {
    // _homeProvider
    //     .loadJellyGardenList(_currentIndex, page)
    //     .doOnListen(() {})
    //     .doOnCancel(() {})
    //     .listen((data) {
    //   if (mounted) {
    //     setState(() {
    //       if (page == 1) {
    //         userModelList?.clear();
    //       }
    //       // resultModel = JellyGardenUserListModel.fromJson(data.data);
    //       userModelList?.addAll(resultModel!.list!);
    //     });
    //   }
    // }, onError: (e) {});
  }

  Future<Null> _onHeaderRefresh() {
    return new Future.delayed(new Duration(milliseconds: 500), () {
      page = 1;
      getData();
    });
  }

  Future<Null> _onFooterRefresh() {
    return new Future.delayed(new Duration(milliseconds: 500), () {
      page++;
      getData();
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.loadComplete();
  }

  _onTabChanged() {
    if (tabController?.index?.toDouble() == tabController?.animation?.value) {
      //赋值 并更新数据
      this.setState(() {
        _currentIndex = tabController?.index;
      });
      getData();
    }
  }

  @override
  void dispose() {
    super.dispose();
    locationUtils.releaseLocation();
  }
}
