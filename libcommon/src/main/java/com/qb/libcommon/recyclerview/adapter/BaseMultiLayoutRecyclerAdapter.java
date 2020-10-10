package com.qb.libcommon.recyclerview.adapter;

import com.qb.libcommon.recyclerview.adapter.holder.BaseViewHolder;

import java.util.List;

public abstract class BaseMultiLayoutRecyclerAdapter<T> extends BaseRecyclerAdapter<T> {
    public BaseMultiLayoutRecyclerAdapter(List<T> mDataList) {
        super(mDataList);
    }

    @Override
    public int getItemViewType(int position) {
        if (mDataList.size() == 0){
            return VIEW_TYPE_EMPTY;
        }
        return getItemType(position);
    }

    @Override
    protected void onBindData(BaseViewHolder holder, int position, T t) {
        onBinds(holder,t,position,getItemViewType(position));
    }

    //子类实现得到具体的子类布局的方法
    public abstract int getItemType(int position);

    //子类实现对不同的item进行操作
    protected abstract void onBinds(BaseViewHolder baseHolder, T t, int position, int itemViewType);
}
