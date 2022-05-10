import 'package:flutter/material.dart';
import 'package:flutter_base/common/Global.dart';
import 'package:flutter_base/message/chat/provider/event.dart';
import 'package:flutter_base/page/login/login.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  Global.init().then((e) => runApp(App()));
}

class App extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(providers: [
        Provider(create: (BuildContext context) => Event())
    ],
    child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage()));
  }
}