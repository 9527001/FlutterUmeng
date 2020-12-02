package zd.com.flutterumeng;

import android.app.Activity;

import com.umeng.socialize.PlatformConfig;
import com.umeng.socialize.ShareAction;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.media.UMImage;
import com.umeng.socialize.media.UMMin;
import com.umeng.socialize.media.UMWeb;

import java.util.HashMap;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

class FlutterUMengPluginForShare {
    public boolean onMethodCall(PluginRegistry.Registrar registrar, Activity activity, @NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        boolean resultCode = true;
        if (call.method.equals(UmMethodConfig.shareText)) {
            int index = call.argument(UmConfig.sharePlatformType);
            String content = call.argument(UmConfig.shareContent);
            new ShareAction(registrar.activity())
                    .setPlatform(FlutterUMengPluginUtil.onShareType(index))//传入平台
                    .withText(content)//分享内容
                    .setCallback(new UmengshareActionListener(registrar.activity(), result))//回调监听器
                    .share();
        } else if (call.method.equals(UmMethodConfig.shareImage)) {
            int index = call.argument(UmConfig.sharePlatformType);
            String imageUrl = call.argument(UmConfig.shareImage);
            UMImage image = new UMImage(registrar.activity(), imageUrl);
            image.setThumb(new UMImage(registrar.activity(), imageUrl));
            new ShareAction(registrar.activity())
                    .setPlatform(FlutterUMengPluginUtil.onShareType(index))//传入平台
                    .withText("")//分享内容
                    .withMedia(image)
                    .setCallback(new UmengshareActionListener(registrar.activity(), result))//回调监听器
                    .share();
        } else if (call.method.equals(UmMethodConfig.shareImageText)) {
            int index = call.argument(UmConfig.sharePlatformType);
            String imageUrl = call.argument(UmConfig.shareImage);
            String content = call.argument(UmConfig.shareContent);
            UMImage image = new UMImage(registrar.activity(), imageUrl);
            image.setThumb(new UMImage(registrar.activity(), imageUrl));
            new ShareAction(registrar.activity())
                    .setPlatform(FlutterUMengPluginUtil.onShareType(index))//传入平台
                    .withText(content)//分享内容
                    .withMedia(image)
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
                    .setPlatform(FlutterUMengPluginUtil.onShareType(index))//传入平台
                    .withMedia(web)
                    .setCallback(new UmengshareActionListener(registrar.activity(), result))//回调监听器
                    .share();
        } else if (call.method.equals(UmMethodConfig.shareMiniProgram)) {
            int index = call.argument(UmConfig.sharePlatformType);
            String title = call.argument(UmConfig.shareTitle);
            String content = call.argument(UmConfig.shareContent);
            String hdImageData = call.argument(UmConfig.shareHDImageData);
            HashMap<String, String> mpJson = call.argument(UmConfig.shareMPJsonStr);
            String userName = mpJson.get(UmConfig.shareUserName);
            String path = mpJson.get(UmConfig.sharePath);
            String url = mpJson.get(UmConfig.shareWebpageUrl);

            UMMin umMin = new UMMin(url); //兼容低版本的网页链接
            umMin.setTitle(title); // 小程序消息title
            umMin.setDescription(content); // 小程序消息描述
            if (hdImageData != null) {
                umMin.setThumb(new UMImage(registrar.activity(), hdImageData)); // 小程序消息封面图片
            }
            umMin.setPath(path); //小程序页面路径
            umMin.setUserName(userName); // 小程序原始id,在微信平台查询

            new ShareAction(registrar.activity())
                    .setPlatform(FlutterUMengPluginUtil.onShareType(index))//传入平台
                    .withMedia(umMin)
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
            resultCode = false;
        }
        return resultCode;
    }
}
