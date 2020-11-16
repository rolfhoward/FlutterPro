1、wrap_content
mainAxisSize: MainAxisSize.min,//wrap_content ,不加的话默认为match_parent（MainAxisSize.max）
2、控件显示或隐藏
IgnorePointer(
    ignoring: true,
    child: new Opacity(
        opacity: 0.0,  //是否隐藏  1.0显示  0.0隐藏
        child:
    )
）

/**
 * 控制child是否显示
 *
    当offstage为true，控件隐藏； 当offstage为false，显示；
    当Offstage不可见的时候，如果child有动画等，需要手动停掉，Offstage并不会停掉动画等操作。

    const Offstage({ Key key, this.offstage = true, Widget child })
 */


 简介
Offstage的作用很简单，通过一个参数，来控制child是否显示，日常使用中也算是比较常用的控件。
 布局行为
Offstage的布局行为完全取决于其offstage参数

当offstage为true，当前控件不会被绘制在屏幕上，不会响应点击事件，也不会占用空间；
当offstage为false，当前控件则跟平常用的控件一样渲染绘制；

另外，当Offstage不可见的时候，如果child有动画，应该手动停掉，Offstage并不会停掉动画。