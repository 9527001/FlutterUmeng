package zd.com.flutterumeng;

import android.app.Activity;
import android.text.TextUtils;

import com.umeng.socialize.UMShareListener;
import com.umeng.socialize.bean.SHARE_MEDIA;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel.Result;

public class UmengshareActionListener implements UMShareListener {
    private final Activity activity;
    private final Result result;

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
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("code", 2);
        resultMap.put("msg", "分享成功");
        result.success(resultMap);
    }

    @Override
    public void onError(SHARE_MEDIA share_media, Throwable throwable) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("code", 0);
        resultMap.put("msg", TextUtils.isEmpty(throwable.getMessage()) ? "未知错误，分享失败" : throwable.getMessage());
        result.success(resultMap);
    }

    @Override
    public void onCancel(SHARE_MEDIA share_media) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("code", 1);
        resultMap.put("msg", "取消分享");
        result.success(resultMap);
    }
}
