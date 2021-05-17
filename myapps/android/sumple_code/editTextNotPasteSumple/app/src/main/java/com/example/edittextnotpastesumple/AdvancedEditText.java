package com.example.edittextnotpastesumple;

import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.widget.EditText;

public class AdvancedEditText extends EditText {

    private OnContextMenuListener menuListener;

    public AdvancedEditText(Context context) {
        super(context);
    }

    public AdvancedEditText(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public AdvancedEditText(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    @Override
    public boolean onTextContextMenuItem(int id) {
        switch (id) {
            case android.R.id.cut:

                Log.d("Log", " コピーされたとき ");

//                /** コピーされたとき */
//                menuListener.onCut();
                break;
            case android.R.id.paste:

                Log.d("Log", " コピーされたとき ");
//                /** 貼り付けされたとき */
//                menuListener.onPaste();
                break;
            case android.R.id.copy:
                Log.d("Log" ,"  切り取りされたとき" );

//                /** 切り取りされたとき */
//                menuListener.onCopy();
                break;
        }
        return super.onTextContextMenuItem(id);
    }

    public void setOnContextMenuListener(OnContextMenuListener listener) {
        this.menuListener = listener;
    }

    /**
     * コピー・貼り付け・切り取りを感知するリスナー
     */
    public interface OnContextMenuListener {
        void onCopy();

        void onPaste();

        void onCut();
    }
}
