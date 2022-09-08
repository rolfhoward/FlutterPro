package com.qb.libcommon.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.FragmentActivity;

import com.bumptech.glide.Glide;

import java.util.concurrent.ConcurrentHashMap;

/**
 * 基础Activity类
 * */
public abstract class BaseActivity extends FragmentActivity implements View.OnClickListener {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(getLayoutId());
        initView();
        initData();
    }

    /**初始化布局*/
    protected abstract int getLayoutId();
    /**实例化布局*/
    protected abstract void initView();
    /**加载数据*/
    protected abstract void initData();

    /**
     * 基础显示加载进度条
     * */
    protected void showLoading(){}
    /**
     * 显示加载进度条
     * @param layoutId 进度条自定义样式
     * */
    protected void showLoading(int layoutId){}

    /**隐藏进度条*/
    protected void dismissLoading(){}

    @Override
    public void onClick(View v) {

    }
}
