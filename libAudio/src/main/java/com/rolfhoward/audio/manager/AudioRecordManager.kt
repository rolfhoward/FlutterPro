package com.rolfhoward.audio.manager

import android.content.Context
import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaRecorder
import android.os.Environment
import java.io.File
import java.io.FileOutputStream

/**
 *@author wuqiubin
 *@date 2022/9/2
 *@Describe 懒汉式单例类
 */
class AudioRecordManager private constructor(){

    private var pcmFile: File? = null
    private var mAudioRecord: AudioRecord? = null
    private val bufferSize = 1024
    private var isRecording = false

    companion object{
        private var instance: AudioRecordManager? = null
        @Synchronized
        fun get():AudioRecordManager{
            if (instance == null){
                instance = AudioRecordManager()
            }
            return instance!!
        }
    }

    fun init(context: Context) {
        val sampleRateInHz = 44100 //音频采样率，采用常用采样率44.1kHZ
        val channelConfig = AudioFormat.CHANNEL_IN_MONO //音频录制声道，CHANNEL_IN_MONO 单声道 CHANNEL_IN_STEREO 双声道
        val audioFormat = AudioFormat.ENCODING_PCM_16BIT //采样精度，位宽 通常采用16bit
        val bufferSize = AudioRecord.getMinBufferSize(sampleRateInHz, channelConfig, audioFormat)
        this.mAudioRecord = AudioRecord(
            MediaRecorder.AudioSource.MIC,
            sampleRateInHz,
            channelConfig,
            audioFormat,
            bufferSize
        )
        pcmFile = File(context.getExternalFilesDir(Environment.DIRECTORY_MUSIC), "raw.pcm")

    }

    /**
     * 开始录制音频
     * */
    fun startRecording(){
        //判断录音文件是否存在，如果存在则删除原录音文件
        if (this.pcmFile?.exists() == true){
            pcmFile?.delete()
        }
        //是否录制状态 -开始录制
        isRecording = true
        //录制字节缓冲区大小
        val buffer = ByteArray(bufferSize)
        //开始录制
        mAudioRecord?.startRecording()
        //开启线程写入文件
        Thread {
            var fileOutputStream: FileOutputStream? = null
            try {
                fileOutputStream = FileOutputStream(pcmFile)
                if (null != fileOutputStream) {
                    while (isRecording) {
                        //循环写入PCM文件中
                        mAudioRecord?.read(buffer, 0, bufferSize)
                        fileOutputStream.write(buffer)
                    }
                    fileOutputStream.flush()
                }
            } catch (e: Exception) {
                e.printStackTrace()
            } finally {
                fileOutputStream?.close()
            }

        }.start()
    }

    /**结束录制音频**/
    fun stopRecording(){
        isRecording = false
        mAudioRecord?.stop()
    }

    /**释放音频资源**/
    fun release(){
        mAudioRecord?.release()
        mAudioRecord = null
    }
}