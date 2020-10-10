package com.qb.libcommon.recyclerview.adapter;


import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.qb.libcommon.R;
import com.qb.libcommon.recyclerview.adapter.holder.BaseEmptyHolder;
import com.qb.libcommon.recyclerview.adapter.holder.BaseViewHolder;

import java.util.List;

/**
 * 单一布局RecyclerViewAdapter
 */
public abstract class BaseRecyclerAdapter<T> extends RecyclerView.Adapter<BaseViewHolder> {

    private Context mContext;
    //数据集合
    protected List<T> mDataList;
    /**
     * viewType--分别为item以及空view
     */
    protected static final int VIEW_TYPE_ITEM = 1;
    protected static final int VIEW_TYPE_EMPTY = 0;
    /**空View*/
    private View mEmptyView;

    //定义接口 OnItemClickListener
    public interface OnItemClickListener {
        void onItemClick(View view, int position);
    }

    public interface OnItemLongClickListener {
        void onItemLongClick(View view, int position);
    }

    private OnItemClickListener mOnItemClickListener;
    private OnItemLongClickListener mOnItemLongClickListener;

    public void setOnItemClickListener(OnItemClickListener onItemClickListener) {
        mOnItemClickListener = onItemClickListener;
    }

    public void setOnItemLongClickListener(OnItemClickListener onItemClickListener) {
        mOnItemClickListener = onItemClickListener;
    }

    public BaseRecyclerAdapter(List<T> mDataList) {
        this.mDataList = mDataList;
        //避免ImageView数据url没变循环刷新
        setHasStableIds(true);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public int getItemViewType(int position) {
        if (null == mDataList || null!=mDataList && mDataList.size() == 0) {
            return VIEW_TYPE_EMPTY;
        }
        //如果有数据，则使用ITEM的布局
        return VIEW_TYPE_ITEM;
    }

    @Override
    public int getItemCount() {
        return null == mDataList || null != mDataList && mDataList.size() == 0 ? 1 : mDataList.size();
    }

    @NonNull
    @Override
    public BaseViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        mContext = parent.getContext();

        //在这里根据不同的viewType进行引入不同的布局
        if (viewType == VIEW_TYPE_EMPTY) {
            if (null == mEmptyView)
                mEmptyView = LayoutInflater.from(mContext).inflate(R.layout.libcommon_recycler_empty_view, parent, false);
            return new BaseEmptyHolder(mEmptyView);
        }

        final BaseViewHolder baseViewHolder = BaseViewHolder.getHolder(mContext, parent, getLayoutId(viewType));
        baseViewHolder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mOnItemClickListener != null)
                    mOnItemClickListener.onItemClick(v, baseViewHolder.getLayoutPosition());
            }
        });
        baseViewHolder.itemView.setOnLongClickListener(new View.OnLongClickListener() {
            @Override
            public boolean onLongClick(View v) {
                if (mOnItemLongClickListener != null)
                    mOnItemLongClickListener.onItemLongClick(v, baseViewHolder.getLayoutPosition());
                return true;
            }
        });
        return baseViewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull BaseViewHolder holder, int position) {
        if (null!=mDataList && mDataList.size()>0) {
            T t = mDataList.get(position);
            onBindData(holder, position, t);
        }
    }

    /**
     * 初始化item布局
     */
    protected abstract int getLayoutId(int viewType);

    /**
     * 绑定数据
     *
     * @param holder   具体的viewHolder
     * @param position 对应的索引
     * @param t
     */
    protected abstract void onBindData(BaseViewHolder holder, int position, T t);

    /**
     * 刷新数据
     *
     * @param mDataList
     */
    public void refresh(List<T> mDataList) {
        this.mDataList.clear();
        this.mDataList.addAll(mDataList);
        notifyDataSetChanged();
    }

    /**
     * 添加数据
     *
     * @param mDataList
     */
    public void addData(List<T> mDataList) {
        this.mDataList.addAll(mDataList);
        notifyDataSetChanged();
    }

    public void setEmptyView(View mEmptyView){
        this.mEmptyView = mEmptyView;
    }

}
