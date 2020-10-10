import 'package:amap_location/amap_location.dart';

class LocationUtils{
  getLocation() async {
    //先启动一下
    await AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));

    //直接获取定位
    var result = await AMapLocationClient.getLocation(true);
    print("""
    经度：${result.longitude}
    纬度：${result.latitude}
    """);

    //监听定位
    AMapLocationClient.onLocationUpate.listen((AMapLocation loc) {
//      if (!mounted) return;
//      setState(() {
        print("""
    经度：${result.longitude}
    纬度：${result.latitude}
    """);
//      });
    });
    AMapLocationClient.startLocation();
  }
}