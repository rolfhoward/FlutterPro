package com.rolfhoward.audio.ui

import android.app.Activity
import android.os.Bundle
import com.rolfhoward.audio.R
import com.rolfhoward.audio.manager.AudioRecordManager
import kotlinx.android.synthetic.main.activity_audio_record.*

/**
 *@author wuqiubin
 *@date 2022/9/2
 *@Describe
 */
class AudioRecordActivity:Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_audio_record)

        AudioRecordManager.get().init(this)
        //开始录制音频
        btn_audio_start_record.setOnClickListener { AudioRecordManager.get().startRecording() }
        //结束录制音频
        btn_audio_end_record.setOnClickListener { AudioRecordManager.get().stopRecording() }
    }
}