import 'package:flutter/material.dart';

class SystemNoticeHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SystemNoticeHomeState();
}

class SystemNoticeHomeState extends State<SystemNoticeHome> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text("系统消息"),);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}