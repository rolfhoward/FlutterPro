package com.qb.androidflutter;

import android.view.View;
import android.widget.Toast;

import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import com.qb.libcommon.activity.BaseToolBarActivity;
import com.qb.libcommon.recyclerview.adapter.BaseRecyclerAdapter;

import java.util.ArrayList;
import java.util.List;

public class RecyclerViewActivity extends BaseToolBarActivity {
    @Override
    protected int initLayout() {
        return R.layout.activity_recyclerview;
    }

    @Override
    protected void initData() {
        SwipeRefreshLayout mSwipeRefreshLayout = findViewById(R.id.sr_layout);
        RecyclerView recyclerView = findViewById(R.id.rv_list);
        List<String> list = new ArrayList<>();
        list.add("1111");
        list.add("2222");
        list.add("3333");
        list.add("4444");
        list.add("5555");
        list.add("6666");
        list.add("7777");
        list.add("8888");
        list.add("9999");
        list.add("aaaa");
        list.add("bbbb");
        list.add("cccc");
        list.add("dddd");
        list.add("eeee");
        RecyAdapter adapter = new RecyAdapter(list);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setAdapter(adapter);
        mSwipeRefreshLayout.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
            @Override
            public void onRefresh() {
                System.out.println("=====onRefresh====");
            }
        });

        adapter.setOnItemClickListener(new BaseRecyclerAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                Toast.makeText(RecyclerViewActivity.this, list.get(position), Toast.LENGTH_SHORT).show();
            }
        });
    }
}
