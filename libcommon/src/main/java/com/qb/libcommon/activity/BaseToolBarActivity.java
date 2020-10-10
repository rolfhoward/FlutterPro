package com.qb.libcommon.activity;

import android.os.Build;
import android.view.View;
import android.widget.FrameLayout;


import androidx.appcompat.widget.Toolbar;

import com.qb.libcommon.R;

public abstract class BaseToolBarActivity extends BaseActivity{

    protected Toolbar toolbar;

    @Override
    protected int getLayoutId() {
        return R.layout.libcommon_activity_base_toolbar;
    }

    @Override
    protected void initView() {
        toolbar = findViewById(R.id.toolbar_base_header);
        FrameLayout flContent = findViewById(R.id.fl_base_toolbar_content);
        if (initLayout() != 0){
            View view = View.inflate(this, initLayout(), null);
            flContent.addView(view);
        }
    }

    @Override
    protected void initData() {

    }

    protected abstract int initLayout();

    protected void customerToolbar(){
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
//            setActionBar(toolbar);
//        }
    }
}
