import 'package:flutter/widgets.dart';
import 'package:flutter_base/message/chat/provider/event.dart';
import 'package:flutter_base/message/utils/GenerateTestUserSig.dart';
import 'package:provider/provider.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimConversationListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSDKListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSimpleMsgListener.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level_enum.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
//IM初始化操作
class IMInit{

  //腾讯ImSDK AppID
  String sdkAppId = "1400180324";
  //腾讯ImSDK secret
  String secret = "1dfbcf418d3dea181705519aebc4d14e59cac60092f8406e132faecd45b91e40";

  //初始化IM
  Future<V2TimValueCallback<bool>> initIMSDK(BuildContext context) async {
    V2TimValueCallback<bool> initRes =
    await TencentImSDKPlugin.v2TIMManager.initSDK(
      sdkAppID: int.parse(sdkAppId),
      loglevel: LogLevelEnum.V2TIM_LOG_DEBUG,
      listener: new V2TimSDKListener(
        onConnectFailed:
          Provider.of<Event>(context, listen: false).onConnectFailed,
        onConnectSuccess:
          Provider.of<Event>(context, listen: false).onConnectSuccess,
        onConnecting:
          Provider.of<Event>(context, listen: false).onConnectSuccess,
        onKickedOffline:
          Provider.of<Event>(context, listen: false).onKickedOffline,
        onSelfInfoUpdated:
          Provider.of<Event>(context, listen: false).onSelfInfoUpdated,
        onUserSigExpired:
          Provider.of<Event>(context, listen: false).onUserSigExpired,
      ),
    );
    int code = initRes.code;
    String desc = initRes.desc;
    print("初始化：$code  desc:$desc");
    if(code == 0){
      //以下监听可按需设置,为防止遗漏消息，请在登录前设置监听。
      //简单监听
      TencentImSDKPlugin.v2TIMManager.addSimpleMsgListener(listener: V2TimSimpleMsgListener());
      //会话监听
      TencentImSDKPlugin.v2TIMManager.getConversationManager().setConversationListener(listener: V2TimConversationListener());
      //高级消息监听
      TencentImSDKPlugin.v2TIMManager.getMessageManager().addAdvancedMsgListener(listener: V2TimAdvancedMsgListener());
    }
    return initRes;
  }

  //登陆
  Future<V2TimCallback> login(String userId) async {
    // 正式环境请在服务端计算userSIg
    String userSig = new GenerateTestUserSig(
      sdkappid: int.parse(sdkAppId),
      key: secret,
    ).genSig(
      identifier: userId,
      expire: 7 * 24 * 60 * 1000, // userSIg有效期
    );

    V2TimCallback res = await TencentImSDKPlugin.v2TIMManager.login(
      userID: userId,
      userSig: userSig,
    );
    return res;
  }
}