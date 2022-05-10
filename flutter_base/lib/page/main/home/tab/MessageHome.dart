import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/message/chat/pages/ChatHome.dart';
import 'package:flutter_base/message/system_notice/SystemNoticeHome.dart';
import 'package:flutter_base/resource/colors.dart';
//消息首页
class MessageHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MessageState();
  }
}

class MessageState extends State with SingleTickerProviderStateMixin{

  List tabs = ["聊天", "系统消息"];
  final bodyList = [ChatHome(), SystemNoticeHome()];

  //用于控制/监听Tab菜单切换
  //TabBar和TabBarView正是通过同一个controller来实现菜单切换和滑动状态同步的。
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController?.addListener(() => _onTabChanged());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        backgroundColor: MColors.white,
        body: new SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                  height: 50,
                  child: Stack(
                    children: <Widget>[
                      //可以通过alignment属性，设置其子widget与其对齐方式，默认center；
                      //所以下面我们分别给注册和登录设置了居左和居右
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "消息中心",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          child: Text("设置",
                              style: TextStyle(color: MColors.base_color, fontSize: 14)),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )),
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
    //构造 TabBarViewbo
    Widget tabBarBodyView = TabBarView(
      controller: tabController,
      //创建Tab页
      children: bodyList,
    );
    return tabBarBodyView;
  }
}

class _onTabChanged {
}
