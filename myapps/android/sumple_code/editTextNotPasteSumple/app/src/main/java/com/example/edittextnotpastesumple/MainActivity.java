package com.example.edittextnotpastesumple;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    private AdvancedEditText mAdvancedEditText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button button = findViewById(R.id.button);
        EditText editTextTextPersonName2 = findViewById(R.id.editTextTextPersonName2);
        EditText editText = new EditText(this);

        AdvancedEditText advancedEditText = new AdvancedEditText(this);
        mAdvancedEditText = findViewById(R.id.editTextTextPersonName);
        mAdvancedEditText.initialize(
                new AdvancedEditText.OnContextMenuListener() {
                    @Override
                    public void onPaste() {

                        Toast.makeText(MainActivity.this, "現在この機能は、使えません", Toast.LENGTH_SHORT).show();

                        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
                            @Override
                            public void run() {
                                // ここに３秒後に実行したい処理
                                mAdvancedEditText.getText().clear();
//                                Log.d("Log", " 貼り付けしました");
//                                Toast.makeText(MainActivity.this, "貼り付けしました", Toast.LENGTH_SHORT).show();
//                                advancedEditText.getEditableText().clear();
                            }
                        }, 10);

                    }

                    @Override
                    public void onCut() {
                        Log.d("Log", " 切り取り ");
                    }

                    @Override
                    public void onCopy() {
                        Log.d("Log", " コピー ");
                    }
                }
        );


        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.d("Log", " public void onClick(View v) { ");

                mAdvancedEditText.getText().clear();
            }
        });


//
//
//        AdvancedEditText editText = new AdvancedEditText(this, new AdvancedEditText.OnContextMenuListener() {
//            @Override
//            public void onPaste() {
//                Log.d("Log", " 貼り付け ");
//            }
//
//            @Override
//            public void onCut() {
//                Log.d("Log", " 切り取り ");
//            }
//
//            @Override
//            public void onCopy() {
//                Log.d("Log", " コピー ");
//            }
//        });
////
//        mCommunityListFilterView = mRootView.findViewById(R.id.communityListFilterView);
//        mCommunityListFilterView.initialize(
//                new CommunityListFilterView.CommunityListFilterListener() {
//                    @Override
//                    public void onChangeItem() {
//                        // 更新処理
//                        mListFooterView.setVisibility(View.GONE);
//                        getCommunityList(true);
//                    }
//                },
//                new CommunityListFilterView.CommunityListFilterResetListener() {
//                    @Override
//                    public void onResetItem() {
//                        mCommunityListFilterView.mIsFilterCommunityBoardPostedMyself = false;
//                        mCommunityListFilterView.mIsFilterCommunityCreatedMyself = false;
//                        mCommunityListFilterView.mSortType = null;
//                        mCommunityListFilterView.changeSortButtonView(null, R.string.age_not_specified);
//                        mCommunityListFilterView.changeFilterButtonColor();
//                        mListFooterView.setVisibility(View.GONE);
//                        getCommunityList(true);
//                    }
//                }
//        );
    }
}