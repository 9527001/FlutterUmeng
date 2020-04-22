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
//        Map<String,Object> map = new HashMap<>();
//        map.put("um_status","SUCCESS");
//
        result.success("success");
        System.out.println("umeng分享--SUCCESS");

    }

    @Override
    public void onError(SHARE_MEDIA share_media, Throwable throwable) {
//        Map<String,Object> map = new HashMap<>();
//        map.put("um_status","ERROR");
//        map.put("um_msg",throwable.getMessage());
        result.success("fail");
        System.out.println("umeng分享--fail");

    }

    @Override
    public void onCancel(SHARE_MEDIA share_media) {
//        Map<String,Object> map = new HashMap<>();
//        map.put("um_status","CANCEL");
        result.success("fail");
        System.out.println("umeng分享--cancel");

    }
}
