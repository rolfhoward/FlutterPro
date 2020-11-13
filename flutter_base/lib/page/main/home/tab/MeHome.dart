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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //顶部操作
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Stack(  //相对布局
                        children: <Widget>[
                          Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                iconSize: 24,
                                icon: Image.asset('assets/images/icon_setting.png'),
                                onPressed: () {},
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                iconSize: 24,
                                icon: Image.asset('assets/images/icon_share.png'),
                                onPressed: () {},
                              )),]
                    ),
                  ),
                  Stack(
                      alignment: Alignment(0.0, 0.0), children: [
                    //
                    Container(
                      width: double.infinity,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            //设置 child 居中
                            alignment: Alignment.topRight,
                            height: 50,
                            width: 50,
                            //边框设置
                            decoration: new BoxDecoration(
                              //背景
                              color: Colors.white,
                              //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              //设置四周边框
                              border: new Border.all(width: 1, color: Colors.red),
                            ),
                            child: Text("在线"),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        new Container(
                          // decoration: BoxDecoration(
                          //     shape: BoxShape.rectangle,
                          //     boxShadow: [
                          //       ///阴影颜色/位置/大小等
                          //       BoxShadow(
                          //           color: Colors.grey[300],
                          //           offset: Offset(0, 0),
                          //           blurRadius: 3),
                          //     ]),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child:
                            Image.asset('assets/images/icon.png'),
                          ),
                        )
                      ],
                    )
                  ])
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
