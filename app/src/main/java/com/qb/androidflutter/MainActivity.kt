package com.qb.androidflutter

import android.content.Intent
import com.qb.androidflutter.dynamic_proxy.DynamicProxy
import com.qb.libcommon.activity.BaseToolBarActivity
import io.flutter.embedding.android.FlutterActivity
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : BaseToolBarActivity() {
    override fun initLayout(): Int {
        return R.layout.activity_main;
    }

    override fun initView() {
        super.initView();
//        toolbar.setLogo(R.mipmap.ic_launcher)
//        toolbar.title = "首页"
//        toolbar.subtitle = "12344"
//        toolbar.setSubtitleTextAppearance(this, R.style.ToolbarSubStyle)
        recyclerView.setOnClickListener {
            var intent = Intent(this, RecyclerViewActivity::class.java)
            startActivity(intent)
        }
        go_flutter.setOnClickListener {
            startActivity(
                FlutterActivity
                    .withCachedEngine(BaseApplication.engineId)
                    .build(this)
            );
        }
        go_invocationHandler.setOnClickListener {
            startActivity(Intent(this, DynamicProxy::class.java));
        }

    }
}
