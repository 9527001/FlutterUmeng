package zd.com.flutterumeng;

import android.app.Activity;

import com.umeng.commonsdk.UMConfigure;
import com.umeng.socialize.PlatformConfig;
import com.umeng.socialize.UMShareAPI;

import java.util.List;
import java.util.Map;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

class FlutterUMengPluginForCommon {
    public boolean onMethodCall(PluginRegistry.Registrar registrar, Activity activity, @NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        boolean resultCode = true;

        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("shareInitUMAndroid")) {
            String appkey = call.argument(UmConfig.appKey);
            if (appkey == null) {
                System.out.println("appkey 不能为空");
                return resultCode;
            }
            String appSecret = call.argument(UmConfig.appSecret);
            UMConfigure.init(registrar.activity(), appkey, "umeng", UMConfigure.DEVICE_TYPE_PHONE, appSecret);//58edcfeb310c93091c000be2 5965ee00734be40b580001a0
            result.success("shareInitSuccess");
            System.out.println("UM初始化成功");

        } else if (call.method.equals("shareInitUM")) {
            Map<String, String> uMengInitMap = call.argument("UMengInit");
            String appKey = uMengInitMap.get("androidAppKey");
            assert appKey != null : ("appkey 不能为空");
            UMConfigure.init(registrar.activity(), appKey, "umeng", UMConfigure.DEVICE_TYPE_PHONE, "");
            result.success("shareInitSuccess");
            System.out.println("UM初始化成功");
        } else if (call.method.equals("initPlatforms")) {
            List args = (List) call.arguments;
            initPlatforms(args);
            result.success("initPlatformsSuccess");

        } else if (call.method.equals(UmMethodConfig.shareInitDingTalk)) {
            String appkey = call.argument(UmConfig.appKey);
            assert appkey != null : ("appkey 不能为空");
            PlatformConfig.setDing(appkey);
            System.out.println("钉钉初始化成功");

        } else if (call.method.equals(UmMethodConfig.shareInitWeChat)) {
            String appkey = call.argument(UmConfig.appKey);
            String appSecret = call.argument(UmConfig.appSecret);
            String fileProvider = call.argument(UmConfig.file_provider);
            PlatformConfig.setWeixin(appkey, appSecret);
            PlatformConfig.setSinaFileProvider(fileProvider);
            System.out.println("微信初始化成功");

        } else if (call.method.equals(UmMethodConfig.shareInitQQ)) {
            String appID = call.argument(UmConfig.appKey);
            String appKey = call.argument(UmConfig.appSecret);
            String fileProvider = call.argument(UmConfig.file_provider);
            PlatformConfig.setQQZone(appID, appKey);
            PlatformConfig.setQQFileProvider(fileProvider);
            System.out.println("Qq初始化成功");

        } else if (call.method.equals(UmMethodConfig.shareInitSina)) {
            String appkey = call.argument(UmConfig.appKey);
            String appSecret = call.argument(UmConfig.appSecret);
            String redirectURL = call.argument(UmConfig.redirectURL);
            String fileProvider = call.argument(UmConfig.file_provider);
            PlatformConfig.setSinaWeibo(appkey, appSecret, redirectURL);
            PlatformConfig.setSinaFileProvider(fileProvider);
            System.out.println("sina初始化成功");

        } else if (call.method.equals("isInstall")) {
            Integer index = call.argument(UmConfig.sharePlatformType);
            if (index == null) return resultCode;
            result.success(UMShareAPI.get(activity.getApplicationContext()).isInstall(activity, FlutterUMengPluginUtil.onShareType(index.intValue())));
        } else if (call.method.equals("isSupport")) {
            int index = call.argument(UmConfig.sharePlatformType);
            result.success(UMShareAPI.get(activity.getApplicationContext()).isSupport(activity, FlutterUMengPluginUtil.onShareType(index)));
        } else if (call.method.equals(UmMethodConfig.setLogEnabled)) {
            boolean argument = call.argument(UmConfig.enable);
            UMConfigure.setLogEnabled(argument);
        } else {
            resultCode = false;
        }
        return resultCode;
    }


    private void initPlatforms(List<Map<String, Object>> list) {
        if (list == null)
            return;
        for (Map<String, Object> map : list) {
            String appKey = (String) map.get("appKey");
            String appSecret = (String) map.get("appSecret");
            String redirectURL = (String) map.get("redirectURL");
            Integer platformType = (Integer) map.get("platformType");
            if (platformType == null) break;
            if (appKey == null) break;
            if (appSecret == null) break;
            switch (platformType) {
                case 0:
                case 1:
                    PlatformConfig.setWeixin(appKey, appSecret);
                case 2:
                case 3:
                    PlatformConfig.setQQZone(appKey, appSecret);
                case 4:
                    PlatformConfig.setSinaWeibo(appKey, appSecret, redirectURL);
                case 5:
                    PlatformConfig.setDing(appKey);
                default:
                    return;
            }
        }
    }
}




