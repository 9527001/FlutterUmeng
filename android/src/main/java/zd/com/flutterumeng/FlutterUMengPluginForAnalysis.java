package zd.com.flutterumeng;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import com.umeng.analytics.MobclickAgent;

import java.util.List;
import java.util.Map;

import static com.umeng.socialize.utils.ContextUtil.getContext;

public class FlutterUMengPluginForAnalysis {

    public boolean onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        boolean resultCode = true;
        List args = (List) call.arguments;
        switch (call.method) {
            case "getPlatformVersion":
                result.success("Android " + android.os.Build.VERSION.RELEASE);
                break;
            case "onEvent":
                onEvent(args);
                break;
            case "onProfileSignIn":
                onProfileSignIn(args);
                break;
            case "onProfileSignOff":
                onProfileSignOff();
                break;
            case "setPageCollectionModeAuto":
                setPageCollectionModeAuto();
                break;
            case "setPageCollectionModeManual":
                setPageCollectionModeManual();
                break;
            case "onPageStart":
                onPageStart(args);
                break;
            case "onPageEnd":
                onPageEnd(args);
                break;
            case "reportError":
                reportError(args);
                break;
            default:
                resultCode = false;
                break;
        }

        return resultCode;

    }

    private static void onEvent(List args) {
        String event = (String) args.get(0);
        Map map = null;
        if (args.size() > 1) {
            map = (Map) args.get(1);
        }
        //JSONObject properties = new JSONObject(map);
        MobclickAgent.onEventObject(getContext(), event, map);

        if (map != null) {
            android.util.Log.i("UMLog", "onEventObject:" + event + "(" + map.toString() + ")");
        } else {
            android.util.Log.i("UMLog", "onEventObject:" + event);
        }
    }

    private void onProfileSignIn(List args) {
        String userID = (String) args.get(0);
        MobclickAgent.onProfileSignIn(userID);
        android.util.Log.i("UMLog", "onProfileSignIn:" + userID);
    }

    private void onProfileSignOff() {
        MobclickAgent.onProfileSignOff();
        android.util.Log.i("UMLog", "onProfileSignOff");
    }

    private void setPageCollectionModeAuto() {
        MobclickAgent.setPageCollectionMode(MobclickAgent.PageMode.LEGACY_AUTO);
        android.util.Log.i("UMLog", "setPageCollectionModeAuto");
    }

    private void setPageCollectionModeManual() {
        MobclickAgent.setPageCollectionMode(MobclickAgent.PageMode.LEGACY_MANUAL);
        android.util.Log.i("UMLog", "setPageCollectionModeManual");
    }

    private void onPageStart(List args) {
        String event = (String) args.get(0);
        MobclickAgent.onPageStart(event);
        android.util.Log.i("UMLog", "onPageStart:" + event);
    }

    private void onPageEnd(List args) {
        String event = (String) args.get(0);
        MobclickAgent.onPageEnd(event);
        android.util.Log.i("UMLog", "onPageEnd:" + event);
    }

    private void reportError(List args) {
        String error = (String) args.get(0);
        MobclickAgent.reportError(getContext(), error);
        android.util.Log.i("UMLog", "reportError:" + error);
    }

}
