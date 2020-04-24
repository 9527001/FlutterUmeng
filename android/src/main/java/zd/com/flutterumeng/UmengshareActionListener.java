package zd.com.flutterumeng;

import android.app.Activity;

import com.umeng.socialize.UMShareListener;
import com.umeng.socialize.bean.SHARE_MEDIA;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel.Result;

public class UmengshareActionListener implements UMShareListener {
    private  final Activity activity;
    private  final   Result result;

    public UmengshareActionListener(Activity activity, Result result) {
        this.activity = activity;
        this.result = result;
    }

    @Override
    public void onStart(SHARE_MEDIA share_media) {
        System.out.println("umeng分享--开始");

    }

    @Override
    public void onResult(SHARE_MEDIA share_media) {
        result.success(2);

    }

    @Override
    public void onError(SHARE_MEDIA share_media, Throwable throwable) {
        result.success(0);

    }

    @Override
    public void onCancel(SHARE_MEDIA share_media) {
        result.success(1);

    }
}
