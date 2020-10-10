package com.qb.androidflutter.dynamic_proxy

import com.qb.androidflutter.R
import com.qb.libcommon.activity.BaseToolBarActivity
import kotlinx.android.synthetic.main.activity_dynamic_proxy.*
import java.lang.reflect.Proxy

class DynamicProxy : BaseToolBarActivity() {
    override fun initLayout(): Int {
        return R.layout.activity_dynamic_proxy
    }

    override fun initData() {
        test_dynamic_proxy.setOnClickListener{
            var helloInterface = Hello();
            var invocationHandler = ProxyHandler(helloInterface);
            var helloInterface1:HelloInterface = Proxy.newProxyInstance(helloInterface.javaClass.classLoader, helloInterface.javaClass.interfaces, invocationHandler) as HelloInterface;
            helloInterface1.hello();
        }
    }
}