package com.qb.libcommon.recyclerview.adapter.holder;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.IdRes;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

public class BaseViewHolder extends RecyclerView.ViewHolder {

    public BaseViewHolder(@NonNull View itemView) {
        super(itemView);
    }

    public static <T extends BaseViewHolder> T getHolder(Context context, ViewGroup parent, int layoutId) {
        return (T) new BaseViewHolder(LayoutInflater.from(context).inflate(layoutId, parent, false));
    }

    /**
     * 获取布局中的View
     * @param viewId view的Id
     * @param <T> View的类型
     * @return view
     */
    public  <T extends View>T getView(@IdRes int viewId){
        return (T)(itemView.findViewById(viewId));
    }

    public View getItemView() {
        return itemView;
    }
}
