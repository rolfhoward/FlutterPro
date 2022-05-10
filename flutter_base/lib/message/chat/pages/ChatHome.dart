//聊天主界面
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/message/provide/ChatProvider.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_info.dart';

class ChatHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new ChatHomeState();

}

class ChatHomeState extends State<ChatHome> with AutomaticKeepAliveClientMixin {

  ChatProvider chatProvider = new ChatProvider();

  List<V2TimFriendInfo>? resData = new List<V2TimFriendInfo>.empty();


  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    //获取好友信息
    getFriendList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: ListView.builder(
          itemCount: resData?.length,
          itemBuilder: (context, item) {
            return buildListData(context, resData![item]);
          })
    );
  }

  Widget buildListData(BuildContext context, V2TimFriendInfo data){
    return Container(
      padding: EdgeInsets.only(left:12,top:10,right:12,bottom: 10),
      child: Row(
        children: [
          ClipOval(
            child: FadeInImage.assetNetwork(
              image: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fnimg.ws.126.net%2F%3Furl%3Dhttp%253A%252F%252Fdingyue.ws.126.net%252F2022%252F0201%252F17f1db94j00r6l0xg001jd200rs00rsg00rs00rs.jpg%26thumbnail%3D650x2147483647%26quality%3D80%26type%3Djpg&refer=http%3A%2F%2Fnimg.ws.126.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1650816233&t=4af7fd560c9c89866df21b8f0c2bea3b",
              width: 51,
              height: 51, placeholder: 'assets/images/icon.png',)
          ),
          SizedBox(width: 16),
          Column(
            children: [
              Row(
                children: [
                  Text(data.userProfile!.nickName!)
                ],
              ),
              Row(
                children: [
                  Text(data.userProfile!.nickName!)
                ],
              )
          ],)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  //获取好友列表信息
  getFriendList() async {
    List<V2TimFriendInfo>? friendList = await chatProvider.getFriendList();
    setState(() {
      resData = friendList;
    });
  }
}