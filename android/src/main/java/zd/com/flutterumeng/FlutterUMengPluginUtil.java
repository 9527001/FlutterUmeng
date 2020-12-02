package zd.com.flutterumeng;

import com.umeng.socialize.bean.SHARE_MEDIA;

class FlutterUMengPluginUtil {
    static SHARE_MEDIA onShareType(int index) {
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
