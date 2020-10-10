import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/resource/colors.dart';
import 'package:flutter_base/util/device_utils.dart';
import 'package:relative_layout/relative_layout.dart';

class MeHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MeState();
  }
}

class MeState extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DeviceUtil.setBarStatus(false);
    return new Scaffold(
        backgroundColor: MColors.base_color,
        body: new SafeArea(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    iconSize: 26,
                    icon: Image.asset('assets/images/icon_setting.png'),
                    onPressed: () {},
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    iconSize: 25,
                    icon: Image.asset('assets/images/icon_share.png'),
                    onPressed: () {},
                  )),
              /*Positioned(
                top: 120,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  color: MColors.base_grey_background,
                  *//*child: Container(
                      margin: EdgeInsets.only(left: 12, right: 12),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Align(alignment: Alignment.center,
                            child: Image.asset('assets/images/icon_user_default_add.png')),
                          Text("张三")
                        ],
                      ),
                    )*//*
                ),
              ),*/

            ],
          ),
        ));
  }
}
