package zd.com.flutterumeng;

import android.content.Context;
import android.content.Intent;

import com.umeng.commonsdk.UMConfigure;
import com.umeng.socialize.PlatformConfig;
import com.umeng.socialize.ShareAction;
import com.umeng.socialize.UMShareAPI;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.media.UMImage;
import com.umeng.socialize.media.UMWeb;
import com.umeng.socialize.uploadlog.UMLog;

import androidx.annotation.NonNull;
import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterumengPlugin
 */
public class FlutterumengPlugin implements MethodCallHandler, PluginRegistry.ActivityResultListener, PluginRegistry.RequestPermissionsResultListener {

    private Registrar registrar;
    private MethodChannel channel;
    private Context mContext;

    public FlutterumengPlugin(Registrar registrar, MethodChannel channel) {
        this.registrar = registrar;
        this.channel = channel;
    }


    public FlutterumengPlugin(Context mContext) {
        this.mContext = mContext;
    }

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutterumeng");
        channel.setMethodCallHandler(new FlutterumengPlugin(registrar, channel));
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals(UmMethodConfig.shareInitUM)) {
            String appkey = call.argument(UmConfig.appKey);
            assert appkey != null : ("appkey 不能为空");
            String appSecret = call.argument(UmConfig.appSecret);
            UMConfigure.init(registrar.activity(), appkey, "umeng", UMConfigure.DEVICE_TYPE_PHONE, appSecret);//58edcfeb310c93091c000be2 5965ee00734be40b580001a0
            result.success("shareInitSuccess");
            System.out.println("UM初始化成功");


        } else if (call.method.equals(UmMethodConfig.setLogEnabled)) {
            boolean argument = call.argument(UmConfig.enable);
            UMConfigure.setLogEnabled(argument);
        } else if (call.method.equals(UmMethodConfig.shareInitDingTalk)) {
            String appkey = call.argument(UmConfig.appKey);
            assert appkey != null : ("appkey 不能为空");
            PlatformConfig.setDing(appkey);
            System.out.println("钉钉初始化成功");

        } else if (call.method.equals(UmMethodConfig.shareInitWeChat)) {
            String appkey = call.argument(UmConfig.appKey);
            String appSecret = call.argument(UmConfig.appSecret);
            PlatformConfig.setWeixin(appkey, appSecret);
            System.out.println("微信初始化成功");

        } else if (call.method.equals(UmMethodConfig.shareInitQQ)) {
            String appID = call.argument(UmConfig.appKey);
            String appKey = call.argument(UmConfig.appSecret);
            PlatformConfig.setQQZone(appID, appKey);
            System.out.println("Qq初始化成功");

        } else if (call.method.equals(UmMethodConfig.shareInitSina)) {
            String appkey = call.argument(UmConfig.appKey);
            String appSecret = call.argument(UmConfig.appSecret);
            String redirectURL = call.argument(UmConfig.redirectURL);
            PlatformConfig.setSinaWeibo(appkey, appSecret, redirectURL);
            System.out.println("sina初始化成功");

        } else if (call.method.equals(UmMethodConfig.shareText)) {
            int index = call.argument(UmConfig.sharePlatformType);
            String content = call.argument(UmConfig.shareContent);

            new ShareAction(registrar.activity())
                    .setPlatform(onShareType(index))//传入平台
                    .withText(content)//分享内容
                    .setCallback(new UmengshareActionListener(registrar.activity(), result))//回调监听器
                    .share();
        } else if (call.method.equals(UmMethodConfig.shareImage)) {
            int index = call.argument(UmConfig.sharePlatformType);
            String imageUrl = call.argument(UmConfig.shareImage);

            new ShareAction(registrar.activity())
                    .setPlatform(onShareType(index))//传入平台
                    .withText("")//分享内容
                    .withMedia(new UMImage(registrar.activity(), imageUrl))
                    .setCallback(new UmengshareActionListener(registrar.activity(), result))//回调监听器
                    .share();
        } else if (call.method.equals(UmMethodConfig.shareImageText)) {
            int index = call.argument(UmConfig.sharePlatformType);
            String imageUrl = call.argument(UmConfig.shareImage);
            String content = call.argument(UmConfig.shareContent);

            new ShareAction(registrar.activity())
                    .setPlatform(onShareType(index))//传入平台
                    .withText(content)//分享内容
                    .withMedia(new UMImage(registrar.activity(), imageUrl))
                    .setCallback(new UmengshareActionListener(registrar.activity(), result))//回调监听器
                    .share();
        } else if (call.method.equals(UmMethodConfig.shareWebView)) {
            int index = call.argument(UmConfig.sharePlatformType);
            String url = call.argument(UmConfig.shareWebUrl);
            String title = call.argument(UmConfig.shareTitle);
            String imageUrl = call.argument(UmConfig.shareImage);
            String content = call.argument(UmConfig.shareContent);

            UMWeb web = new UMWeb(url);
            web.setTitle(title);//标题
            web.setThumb(new UMImage(registrar.activity(), imageUrl));  //缩略图web.set
            web.setDescription(content);//描述
            new ShareAction(registrar.activity())
                    .setPlatform(onShareType(index))//传入平台
                    .withMedia(web)
                    .setCallback(new UmengshareActionListener(registrar.activity(), result))//回调监听器
                    .share();
        } else if (call.method.equals(UmMethodConfig.shareWithBoard)) {
            String content = call.argument(UmConfig.shareContent);

            UMWeb web = new UMWeb("https://www.baidu.com");
            web.setTitle(content);//标题
            web.setThumb(new UMImage(registrar.activity(), "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1587473602&di=9163c62bbbc8a91e6a35874c8326da4d&src=http://a3.att.hudong.com/14/75/01300000164186121366756803686.jpg"));  //缩略图web.set
            web.setDescription(content);//描述

            new ShareAction(registrar.activity())
                    .withMedia(web)
                    .setDisplayList(SHARE_MEDIA.SINA, SHARE_MEDIA.QQ, SHARE_MEDIA.WEIXIN, SHARE_MEDIA.DINGTALK)
                    .setCallback(new UmengshareActionListener(registrar.activity(), result))
                    .open();
        } else {
            result.notImplemented();
        }
    }

    private SHARE_MEDIA onShareType(int index) {
        switch (index) {
            case 0:
                return SHARE_MEDIA.WEIXIN;
            case 1:
                return SHARE_MEDIA.WEIXIN_CIRCLE;
            case 2:
                return SHARE_MEDIA.QQ;
            case 3:
                return SHARE_MEDIA.QZONE;
            case 4:
                return SHARE_MEDIA.SINA;
            case 5:
                return SHARE_MEDIA.DINGTALK;
        }
        return SHARE_MEDIA.MORE;
    }

    @Override
    public boolean onActivityResult(int i, int i1, Intent intent) {
        UMShareAPI.get(mContext).onActivityResult(i, i1, intent);
        return true;
    }

    @Override
    public boolean onRequestPermissionsResult(int i, String[] strings, int[] ints) {
        return false;
    }
}

