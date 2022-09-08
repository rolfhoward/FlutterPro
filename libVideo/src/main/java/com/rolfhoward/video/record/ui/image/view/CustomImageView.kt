package com.rolfhoward.video.record.ui.image.view

import android.content.Context
import android.graphics.*
import android.util.AttributeSet
import android.util.DisplayMetrics
import android.view.Display
import android.view.View
import android.view.WindowManager
import com.rolfhoward.video.R


/**
 * @author wuqiubin
 * @date 2022/8/12
 * @Describe
 */
class CustomImageView : View{

    private var mPaint: Paint = Paint()
    private var mBitmap: Bitmap
    private val _mDest: Rect

    constructor(context: Context?, attrs: AttributeSet?) : this(context, attrs, 0)
    constructor(context: Context?, attrs: AttributeSet?, defStyleAttr: Int) : super(
        context!!,
        attrs,
        defStyleAttr
    ) {
        mBitmap = BitmapFactory.decodeResource(context?.resources, R.drawable.preview1)

        var wm:WindowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        var display:Display =  wm.defaultDisplay
        //获取屏幕宽高
        var point = Point();
        display.getSize(point)
        var width = point.x

        var dm = DisplayMetrics();
        display.getMetrics(dm)
        //获取屏幕密度
        val density: Float = dm.density
        //设置图像高度
        var height = Math.round(120f*density)

        _mDest = Rect(0, 0, width, height)
    }

    override fun onDraw(canvas: Canvas?) {
        super.onDraw(canvas)
        if (!mBitmap?.isRecycled) {
            canvas?.drawBitmap(mBitmap, null, _mDest, mPaint)
        }
    }
}