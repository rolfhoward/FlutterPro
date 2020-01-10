#集成到现有应用
##有时候，用 Flutter 一次性重写整个已有的应用是不切实际的。对于这些情况，Flutter 可以作为一个库或模块，集成进现有的应用当中。模块引入到您的 Android 或 iOS 应用（当前支持的平台）中，以使用 Flutter 来渲染一部分的 UI，或者仅运行多平台共享的 Dart 代码逻辑。
仅需几步，你就可以将高效而富有表现力的 Flutter 引入您的应用。
在 Flutter v1.12 中，添加到现有应用的基本场景已被支持，每个应用在同一时间可以集成一个全屏幕的 Flutter 实例。目前仍有以下限制：
###运行多个 Flutter 实例，或在屏幕局部上运行 Flutter 可能会导致不可预测的行为；
###在后台模式使用 Flutter 的能力还在开发中；
###将 Flutter 库打包进另一个可共享的库或将多个 Flutter 库打包到同一个应用中，都未被支持。

##已支持的特性
###在 Gradle 脚本中添加一个自动构建并引入 Flutter 模块的 Flutter SDK Hook。
###将 Flutter 模块构建为通用的 Android Archive (AAR) 以便集成到您自己的构建系统中，并提高 Jetifier 与 AndroidX 的互操作性；
###FlutterEngine API 用于启动并持续地为挂载 FlutterActivity 或 FlutterFragment 提供独立的 Flutter 环境；
###Android Studio 的 Android 与 Flutter 同时编辑，以及 Flutter module 创建与导入向导；
###支持了 Java 和 Kotlin 为宿主的应用程序；
###Flutter 模块可以通过使用 Flutter plugins 与平台进行交互。 Android 平台的 plugin 应该迁移至 V2 plugin API 以确保最佳的兼容性。在 Flutter v1.12，大多数 Flutter 团队维护 的 plugin，以及 FlutterFire 都已完成迁移；
###支持通过从 IDE 或命令行中使用 flutter attach 来实现 Flutter 调试与有状态的热重载。

将 Flutter module 集成到 Android 项目
1、
[特别注意：当前现有应用可能支持mips及x86/x86_64架构，但是Flutter当前只支持构建armeabi-v7a 和 arm64-v8a架构的AOT模式的编译库，因此建议apk使用abiFilters Android构建的插件API来限制支持的架构，避免出现丢失libflutter.so的运行时异常

android {
  //...
  defaultConfig {
    ndk {
      // Filter for architectures supported by Flutter.
      abiFilters 'armeabi-v7a', 'arm64-v8a'
    }
  }
}
]

2、创建Flutter module
进入到已存在的项目目录下执行下列命令
flutter create -t module flutter_base
执行完成后会创建一个flutter_base的module
![image](./doc/image/flutter_module_example.png)

3、JDK要求
Flutter Android引擎使用了Java 8的特性。在你的Android项目的build.gradle文件中添加如下配置：
android {
  //...
  compileOptions {
    sourceCompatibility 1.8
    targetCompatibility 1.8
  }
}
4、module集成方式
  1、依赖于源码集成方式
     将Flutter module作为安卓项目的子工程存在并在已有安卓项目中的setting.gradle文件中增加如下配置：
     setBinding(new Binding([gradle: this]))
     evaluate(new File(
       settingsDir,
       'flutter_base/.android/include_flutter.groovy'
     ))
     并且在android项目中的build.gradle配置文件中增加implementation
     dependencies {
       implementation project(':flutter')
     }

5、向 Android 应用中添加 Flutter 页面
    # 在AndroidManifest.xml中添加一个FlutterActivity
    <activity
      android:name="io.flutter.embedding.android.FlutterActivity"
      android:theme="@style/LaunchTheme"
      android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
      android:hardwareAccelerated="true"
      android:windowSoftInputMode="adjustResize"
      />
      对@style/LaunchTheme的引用可以被任何想要应用到FlutterActivity的Android主题所代替。主题的选择决定了应用到Android系统上的颜色，比如Android的导航条，以及在Flutter UI首次呈现之前FlutterActivity的背景颜色
    #启动FlutterActivity,通过一个按钮事件启动Flutter界面
    myButton.setOnClickListener(new OnClickListener() {
      @Override
      public void onClick(View v) {
        startActivity(
          FlutterActivity.createDefaultIntent(currentActivity)
        );
      }
    });
    前面的示例假设您的Dart入口点称为main()，而您的初始颤振路径为' / '。Dart进入点不能使用Intent来改变，但是初始路线可以使用Intent来改变。下面的示例演示如何启动一个FlutterActivity，该活动最初在Flutter中呈现一个自定义路由。
    myButton.addOnClickListener(new OnClickListener() {
      @Override
      public void onClick(View v) {
        startActivity(
          FlutterActivity
            .withNewEngine()
            .initialRoute("/my_route")
            .build(currentActivity)
          );
      }
    });
    将“/my_route”替换为所需的初始路由，使用withNewEngine()工厂方法配置一个FlutterActivity，该活动在内部创建自己的FlutterEngine实例。这带来了一个重要的初始化时间。另一种方法是指示FlutterActivity使用预先预热的、缓存的FlutterEngine，这将最小化的初始化时间。
    #使用缓冲的FlutterEngine
    默认情况下，每个FlutterActivity都创建自己的FlutterEngine。每个FlutterEngine都有一个重要的预热时间。这意味着在您的Flutter界面变得可见之前，启动一个标准的FlutterActivity会有一个短暂的延迟。为了尽量减少这种延迟，你可以在到达你的FlutterActivity之前预热一个抖动引擎，然后你可以使用你的预热过的抖动引擎。
    要预热一个FlutterEngine，请在应用程序中找到一个合理的位置来实例化一个FlutterEngine。下面的例子在应用程序类中任意预热一个FlutterEngine:
    public class MyApplication extends Application {
      @Override
      public void onCreate() {
        super.onCreate();
        // Instantiate a FlutterEngine.
        flutterEngine = new FlutterEngine(this);

        // Start executing Dart code to pre-warm the FlutterEngine.
        flutterEngine.getDartExecutor().executeDartEntrypoint(
          DartEntrypoint.createDefault()
        );

        // Cache the FlutterEngine to be used by FlutterActivity.
        FlutterEngineCache
          .getInstance()
          .put("my_engine_id", flutterEngine);
      }
    }
    传给FlutterEngineCache的ID可以是任何你想要的。确保将相同的ID传递给任何应该使用缓存的FlutterEngine的FlutterActiity或FlutterFragment。接下来将讨论如何在缓存的FlutterEngine中使用FlutterActivity。
    有了预先预热的缓存的FlutterEngine，现在需要指示您的FlutterActivity使用缓存的FlutterEngine，而不是创建一个新的FlutterEngine。为此，使用FlutterActivity的withCachedEngine()构建器:
    myButton.addOnClickListener(new OnClickListener() {
      @Override
      public void onClick(View v) {
        startActivity(
          FlutterActivity
            .withCachedEngine("my_engine_id")
            .build(currentActivity)
          );
      }
    });
    在使用withCachedEngine()工厂方法时，传递与缓存所需的FlutterEngine时相同的ID。

    



