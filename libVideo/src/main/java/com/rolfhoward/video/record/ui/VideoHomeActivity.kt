package com.rolfhoward.video.record.ui

import android.content.Intent
import com.qb.libcommon.activity.BaseActivity
import com.rolfhoward.audio.ui.AudioRecordActivity
import com.rolfhoward.video.R
import com.rolfhoward.video.record.ui.image.ImagePreviewActivity
import kotlinx.android.synthetic.main.activity_video_home.*

class VideoHomeActivity: BaseActivity() {

    override fun getLayoutId(): Int {
        return R.layout.activity_video_home
    }

    override fun initView() {
        lib_video_image_preview.setOnClickListener { startActivity(Intent(this, ImagePreviewActivity::class.java)) }
        lib_video_audio_service.setOnClickListener { startActivity(Intent(this, AudioRecordActivity::class.java)) }
    }

    override fun initData() {

    }

}