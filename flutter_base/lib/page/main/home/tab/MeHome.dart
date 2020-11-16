import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/resource/colors.dart';
import 'package:flutter_base/util/device_utils.dart';
import 'package:relative_layout/relative_layout.dart';

class MeHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MeState();
  }
}

class MeState extends State {
  @override
  Widget build(BuildContext context) {
    // DeviceUtil.setBarStatus(false, color:MColors.base_color);
    // return new Scaffold(
    //       backgroundColor: MColors.base_color,
    //       body : SafeArea(
    //         top: true,
    //         child: Column(
    //           children: <Widget>[
    //             Container(
    //               color: MColors.base_grey_background,
    //               height: double.maxFinite,
    //               width: double.infinity,
    //               margin: EdgeInsets.only(top: 132),
    //             ),
    //             // Stack(
    //             //   children: <Widget>[
    //             //     Container(
    //             //       color: MColors.base_grey_background,
    //             //       height: double.infinity,
    //             //       width: double.infinity,
    //             //       margin: EdgeInsets.only(top: 132),
    //             //     )
    //             //   ],
    //             // ),
    //             // Container(
    //             //   color: MColors.base_grey_background,
    //             // )
    //           ],
    //         ),
    //       )
    //         // overflow: Overflow.visible,
    //         // children: <Widget>[
    //         //   Align(
    //         //       alignment: Alignment.centerLeft,
    //         //       child: IconButton(
    //         //         iconSize: 26,
    //         //         icon: Image.asset('assets/images/icon_setting.png'),
    //         //         onPressed: () {},
    //         //       )),
    //         //   Align(
    //         //       alignment: Alignment.centerRight,
    //         //       child: IconButton(
    //         //         iconSize: 25,
    //         //         icon: Image.asset('assets/images/icon_share.png'),
    //         //         onPressed: () {},
    //         //       )),
    //           /*Positioned(
    //             top: 120,
    //             bottom: 0,
    //             right: 0,
    //             left: 0,
    //             child: Container(
    //               color: MColors.base_grey_background,
    //               *//*child: Container(
    //                   margin: EdgeInsets.only(left: 12, right: 12),
    //                   color: Colors.white,
    //                   child: Column(
    //                     children: <Widget>[
    //                       Align(alignment: Alignment.center,
    //                         child: Image.asset('assets/images/icon_user_default_add.png')),
    //                       Text("张三")
    //                     ],
    //                   ),
    //                 )*//*
    //             ),
    //           ),*/
    //
    //       // ),
    //     );
    return Scaffold(
      body: Container(
        color: MColors.base_grey_background,
        child: Container(
          child: Stack(
            children: <Widget>[
              //背景色
              Container(
                color: MColors.base_color,
                height: 150,
              ),
              SafeArea(
                  child: Column(children: [
                //顶部操作
                Stack(//相对布局
                    children: <Widget>[
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        padding: EdgeInsets.only(
                            left: 10.0, top: 10.0, right: 10.0, bottom: 1.0),
                        constraints: BoxConstraints(),
                        icon: Image.asset('assets/images/icon_setting.png'),
                        onPressed: () {},
                      )),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0, bottom: 1.0),
                        constraints: BoxConstraints(),
                        icon: Image.asset('assets/images/icon_share.png'),
                        onPressed: () {},
                      )),
                ]),
                Stack(children: [
                  //
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 37.0, left: 10.0, right: 10.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      //设置四周圆角 角度
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //是否在线图标
                            IgnorePointer(
                                ignoring: true,
                                child: new Opacity(
                                  opacity: 0.0,  //是否隐藏  1.0显示  0.0隐藏
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    margin: EdgeInsets.only(top: 6.0, right: 6.0),
                                    child: Container(
                                      //边框设置
                                      padding: EdgeInsets.only(left: 7.0, top: 2.0, right: 7.0, bottom: 2.0),
                                      decoration: new BoxDecoration(
                                        //背景
                                        color: Colors.white,
                                        //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16.0)),
                                        //设置四周边框
                                        border: new Border.all(
                                            width: 1, color: MColors.base_red_color),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipOval(
                                            child: Container(
                                              width: 8.0,
                                              height: 8.0,
                                              color: MColors.base_red_color,
                                            ),
                                          ),
                                          SizedBox(width: 4.0),
                                          Text("在线", style: TextStyle(
                                              fontSize: 12,
                                              color: MColors.base_red_color))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(height: 12.0),
                            //用户名
                            Text("小栗子",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: MColors.base_text_black_color)),
                            //地址信息
                            Container(
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("黑龙江省",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MColors.text_grey_color)),
                                  SizedBox(width: 6.0),
                                  Text("哈尔滨市",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MColors.text_grey_color)),
                                  SizedBox(width: 6.0),
                                  Text("26岁",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MColors.text_grey_color)),
                                  SizedBox(width: 6.0),
                                  Text("模特",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MColors.text_grey_color)),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(top: 6.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/images/icon_location.png'),
                                  SizedBox(width: 3.0),
                                  Text("456km",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MColors.text_grey_color)),
                                  SizedBox(width: 6.0),
                                  Text("约会范围：",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MColors.text_grey_color)),
                                  SizedBox(width: 6.0),
                                  Text("北京市",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MColors.text_grey_color)),
                                ],
                              ),
                            ),

                          ],
                        )),
                  ),
                  Center(
                      child: Container(
                    width: 74.0,
                    height: 74.0,
                    alignment: Alignment.center,
                    child:
                        Image.asset('assets/images/icon_user_default_add.png'),
                  ))
                ])
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
