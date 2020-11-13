import 'package:flutterumeng/share_bean.dart';

class UmAppString {
  static const String app_key = 'AppKey';
  static const String app_secret = 'AppSecret';
  static const String redirect_url = 'RedirectURL';
  static const String redirect_url_content = 'http://mobile.umeng.com/social';
  static const String channel = 'channel';
  static const String file_provider = 'file_provider';

  static const String wechat = '微信';
  static const String qq = '腾讯QQ';
  static const String dingtalk = '钉钉';
  static const String sina = '新浪微博';


  static const Map platformNames = {
    SharePlatformType.wechat:wechat,
    SharePlatformType.qq:qq,
    SharePlatformType.qq_zone:qq,
    SharePlatformType.wechat_circle:wechat,
    SharePlatformType.dingtalk:dingtalk,
    SharePlatformType.sina:sina,
  };
}

class UmAppParams {
  static const String share_platform_type = 'platFormType';
  static const String share_title = 'title';
  static const String share_content = 'content';
  static const String share_image = 'image';
  static const String share_web_url = 'webUrl';
  static const String share_app_method = 'appMethod';
  static const String enable = 'enable';

  static const String share_mp_json_str = "mpJsonStr";
  static const String share_web_page_url = "webpageUrl";
  static const String share_user_name = "userName";
  static const String share_path = "path";
  static const String share_hd_image_data = "hdImageData";//小程序消息封面图片，小于128k
  static const String share_mini_program_type = "miniProgramType";
  static const String share_with_share_ticket = "withShareTicket";
}

class UmAppMethod {
  static const String share_text = 'shareText';
  static const String share_image = 'shareImage';
  static const String share_image_text = 'shareImageText';
  static const String share_web_view = 'shareWebView';
  static const String share_mini_program = 'shareMiniProgram';
  static const String share_with_board = "shareWithBoard";

  static const String share_init_um = 'shareInitUM';
  static const String share_init_um_ios = 'shareInitUMIOS';
  static const String share_init_um_android = 'shareInitUMAndroid';
  static const String share_init_wechat = 'shareInitWeChat';
  static const String share_init_qq = 'shareInitQQ';
  static const String share_init_sina = 'shareInitSina';
  static const String share_init_dingtalk = 'shareInitDingTalk';

  static const String set_log_enabled = 'setLogEnabled';

  static const String is_install = 'isInstall';
  static const String is_support ='isSupport';
}
