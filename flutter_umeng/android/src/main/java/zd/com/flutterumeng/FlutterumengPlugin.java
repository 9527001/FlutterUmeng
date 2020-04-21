package zd.com.flutterumeng;

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
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterumengPlugin
 */
public class FlutterumengPlugin implements MethodCallHandler {

    Registrar registrar;
    MethodChannel channel;

    public FlutterumengPlugin(Registrar registrar, MethodChannel channel) {
        this.registrar = registrar;
        this.channel = channel;
    }

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutterumeng");
        channel.setMethodCallHandler(new FlutterumengPlugin(registrar, channel));
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals(StringMethodUtils.ShareInitUM)) {
            String appkey = call.argument(StringUtils.AppKey);
            assert appkey != null : ("appkey 不能为空");
            String appSecret = call.argument(StringUtils.AppSecret);
            UMConfigure.init(registrar.activity(), appkey, "umeng", UMConfigure.DEVICE_TYPE_PHONE, appSecret);//58edcfeb310c93091c000be2 5965ee00734be40b580001a0
            System.out.println("UM初始化成功");


        } else if (call.method.equals(StringMethodUtils.SetLogEnabled)) {
            boolean argument = call.argument(StringUtils.enable);
            UMConfigure.setLogEnabled(argument);
        } else if (call.method.equals(StringMethodUtils.ShareInitDingTalk)) {
            String appkey = call.argument(StringUtils.AppKey);
            assert appkey != null : ("appkey 不能为空");
            PlatformConfig.setDing(appkey);
            System.out.println("钉钉初始化成功");

        } else if (call.method.equals(StringMethodUtils.ShareInitWeChat)) {
            String appkey = call.argument(StringUtils.AppKey);
            String appSecret = call.argument(StringUtils.AppSecret);
            PlatformConfig.setWeixin(appkey, appSecret);
        } else if (call.method.equals(StringMethodUtils.ShareInitQQ)) {
            String appkey = call.argument(StringUtils.AppKey);
            String appSecret = call.argument(StringUtils.AppSecret);
            PlatformConfig.setQQZone(appkey, appSecret);
        } else if (call.method.equals(StringMethodUtils.ShareInitSina)) {
            String appkey = call.argument(StringUtils.AppKey);
            String appSecret = call.argument(StringUtils.AppSecret);
            String redirectURL = call.argument(StringUtils.RedirectURL);
            PlatformConfig.setSinaWeibo(appkey, appSecret, redirectURL);
        } else if (call.method.equals(StringMethodUtils.ShareText)) {
            int index = call.argument(StringUtils.SharePlatformType);
            String content = call.argument(StringUtils.ShareContent);

            new ShareAction(registrar.activity())
                    .setPlatform(onShareType(index))//传入平台
                    .withText(content)//分享内容
                    .setCallback(new UmengshareActionListener(registrar.activity(), result))//回调监听器
                    .share();
        } else if (call.method.equals(StringMethodUtils.ShareImage)) {
            int index = call.argument(StringUtils.SharePlatformType);
            String imageUrl = call.argument(StringUtils.ShareImage);

            new ShareAction(registrar.activity())
                    .setPlatform(onShareType(index))//传入平台
                    .withText("")//分享内容
                    .withMedia(new UMImage(registrar.activity(), imageUrl))
                    .setCallback(new UmengshareActionListener(registrar.activity(), result))//回调监听器
                    .share();
        } else if (call.method.equals(StringMethodUtils.shareImageText)) {
            int index = call.argument(StringUtils.SharePlatformType);
            String imageUrl = call.argument(StringUtils.ShareImage);
            String content = call.argument(StringUtils.ShareContent);

            new ShareAction(registrar.activity())
                    .setPlatform(onShareType(index))//传入平台
                    .withText(content)//分享内容
                    .withMedia(new UMImage(registrar.activity(), imageUrl))
                    .setCallback(new UmengshareActionListener(registrar.activity(), result))//回调监听器
                    .share();
        } else if (call.method.equals(StringMethodUtils.ShareWebView)) {
            int index = call.argument(StringUtils.SharePlatformType);
            String url = call.argument(StringUtils.ShareWebUrl);
            String title = call.argument(StringUtils.ShareTitle);
            String imageUrl = call.argument(StringUtils.ShareImage);
            String content = call.argument(StringUtils.ShareContent);

            UMWeb web = new UMWeb(url);
            web.setTitle(title);//标题
            web.setThumb(new UMImage(registrar.activity(), imageUrl));  //缩略图web.set
            web.setDescription(content);//描述
            new ShareAction(registrar.activity())
                    .setPlatform(onShareType(index))//传入平台
                    .withMedia(web)
                    .setCallback(new UmengshareActionListener(registrar.activity(), result))//回调监听器
                    .share();
        } else if (call.method.equals(StringMethodUtils.ShareWithBoard)) {
            String content = call.argument(StringUtils.ShareContent);

            new ShareAction(registrar.activity())
                    .withText(content)
                    .setDisplayList(SHARE_MEDIA.SINA, SHARE_MEDIA.QQ, SHARE_MEDIA.WEIXIN,SHARE_MEDIA.DINGTALK)
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


}
