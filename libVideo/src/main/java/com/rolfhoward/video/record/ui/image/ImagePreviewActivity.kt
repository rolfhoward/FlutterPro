package com.rolfhoward.video.record.ui.image

import android.content.Context
import android.graphics.*
import android.util.DisplayMetrics
import android.view.SurfaceHolder
import android.view.SurfaceHolder.Callback
import android.view.WindowManager
import com.qb.libcommon.activity.BaseActivity
import com.rolfhoward.video.R
import kotlinx.android.synthetic.main.activity_image_preview.*

/**
 *@author wuqiubin
 *@date 2022/8/12
 *@Describe 图片预览
 */
class ImagePreviewActivity:BaseActivity(){

    override fun getLayoutId(): Int {
        return R.layout.activity_image_preview
    }

    override fun initView() {
        var bitmap:Bitmap = BitmapFactory.decodeResource(resources, R.drawable.preview1)
        lib_image_preview1.setImageBitmap(bitmap)
    }

    override fun initData() {
        lib_image_preview2.holder.addCallback(object :Callback{
            override fun surfaceCreated(holder: SurfaceHolder) {

                var bitmap = BitmapFactory.decodeResource(resources, R.drawable.preview1)

                var wm:WindowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager
                //获取屏幕宽高
                var display = wm.defaultDisplay;
                var point = Point()
                display.getSize(point);

                var width = point.x

                var dm = DisplayMetrics();
                display.getMetrics(dm)
                var density = dm.density

                var height = Math.round(120*density)

                var paint = Paint()
                val canvas = holder?.lockCanvas()
                var rect = Rect(0,0,width, height)
                canvas.drawBitmap(bitmap, null, rect, paint)
                holder?.unlockCanvasAndPost(canvas)
            }

            override fun surfaceChanged(
                holder: SurfaceHolder,
                format: Int,
                width: Int,
                height: Int
            ) {

            }

            override fun surfaceDestroyed(holder: SurfaceHolder) {

            }

        })
    }
}