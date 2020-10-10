package com.qb.androidflutter;

import android.widget.TextView;

import com.qb.libcommon.recyclerview.adapter.BaseRecyclerAdapter;
import com.qb.libcommon.recyclerview.adapter.holder.BaseViewHolder;

import java.util.List;

public class RecyAdapter extends BaseRecyclerAdapter<String> {

    public RecyAdapter(List<String> mDataList) {
        super(mDataList);
    }

    @Override
    protected int getLayoutId(int viewType) {
        return R.layout.recy_item;
    }

    @Override
    protected void onBindData(BaseViewHolder holder, int position, String s) {
        TextView textView = holder.getView(R.id.item_name);
        textView.setText(s);
    }
}
