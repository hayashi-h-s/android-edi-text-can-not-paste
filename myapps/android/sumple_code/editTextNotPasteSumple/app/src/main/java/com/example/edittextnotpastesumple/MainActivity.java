package com.example.edittextnotpastesumple;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        AdvancedEditText editText = new AdvancedEditText(this);
        editText.setOnContextMenuListener(new AdvancedEditText.OnContextMenuListener() {
            @Override
            public void onPaste() {
                Log.d("Log", " 貼り付け ");
            }

            @Override
            public void onCut() {
                Log.d("Log", " 切り取り ");
            }

            @Override
            public void onCopy() {
                Log.d("Log", " コピー ");
            }
        });



    }
}