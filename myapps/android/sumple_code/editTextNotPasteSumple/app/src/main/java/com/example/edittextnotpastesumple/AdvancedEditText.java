package com.example.edittextnotpastesumple;

import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.widget.EditText;

import androidx.annotation.NonNull;

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

    public void initialize(
            @NonNull OnContextMenuListener onContextMenuListener
    ) {
        Log.d("Log" ,"  onContextMenuListener =" +onContextMenuListener  );

            menuListener = onContextMenuListener;
    }

    @Override
    public boolean onTextContextMenuItem(int id) {
        switch (id) {
            case android.R.id.cut:

                Log.d("Log", " コピーされたとき ");
                Log.d("Log" ," menuListener = " +menuListener );

//                /** コピーされたとき */
//                menuListener.onCut();
                break;
            case android.R.id.paste:

                Log.d("Log", " 貼り付けされたとき ");
                Log.d("Log" ," menuListener = " +menuListener );
//                /** 貼り付けされたとき */
                menuListener.onPaste();
                break;
            case android.R.id.copy:
                Log.d("Log" ,"  切り取りされたとき" );
                Log.d("Log" ," menuListener = " +menuListener );

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
