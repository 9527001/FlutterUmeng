import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutterumeng/share_bean.dart';
import 'package:flutterumeng/share_result_bean.dart';

import 'um_config.dart';
export 'um_config.dart';
export 'share_bean.dart';
export 'share_result_bean.dart';

class FlutterUmeng {
  static const MethodChannel _channel = const MethodChannel('flutterumeng');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> init({
    @required String appKey,
    @required String channel,
  }) async {
    Map<String, dynamic> shareMap = {
      UmAppString.app_key: appKey,
      UmAppString.channel: channel,
    };
    final String result =
        await _channel.invokeMethod(UmAppMethod.share_init_um, shareMap);
    return result;
  }

  static Future<String> initAndroid({
    @required String appKey,
    @required String channel,
  }) async {
    Map<String, dynamic> shareMap = {
      UmAppString.app_key: appKey,
      UmAppString.channel: channel,
    };
    if (Platform.isAndroid) {
      final String result =
          await _channel.invokeMethod(UmAppMethod.share_init_um_android, shareMap);
      return result;
    }
    return '';

  }

  static Future<String> initIos({
    @required String appKey,
    @required String channel,
  }) async {
    Map<String, dynamic> shareMap = {
      UmAppString.app_key: appKey,
      UmAppString.channel: channel,
    };
    if (Platform.isIOS) {
      final String result =
          await _channel.invokeMethod(UmAppMethod.share_init_um_ios, shareMap);
      return result;
    }
    return '';
  }

/*设置是否在console输出sdk的log信息.*/
  static Future setLogEnabled({
    @required bool enabled,
  }) async {
    Map<String, dynamic> shareMap = {
      UmAppParams.enable: enabled,
    };
    await _channel.invokeMethod(UmAppMethod.set_log_enabled, shareMap);
  }

  static Future<String> initWeChat({
    @required String appKey,
    @required String appSecret,
    String redirectURL = UmAppString.redirect_url_content,
  }) async {
    Map<String, dynamic> shareMap = {
      UmAppString.app_key: appKey,
      UmAppString.app_secret: appSecret,
      UmAppString.redirect_url: redirectURL,
    };
    final String result =
        await _channel.invokeMethod(UmAppMethod.share_init_wechat, shareMap);
    return result;
  }

  static Future<String> initQQ({
    @required String appKey,
    @required String appSecret,
    @required String fileProvider,
    String redirectURL = UmAppString.redirect_url_content,
  }) async {
    Map<String, dynamic> shareMap = {
      UmAppString.app_key: appKey,
      UmAppString.app_secret: appSecret,
      UmAppString.redirect_url: redirectURL,
      UmAppString.file_provider:fileProvider,
    };
    final String result =
        await _channel.invokeMethod(UmAppMethod.share_init_qq, shareMap);
    return result;
  }

  static Future<String> initSina({
    @required String appKey,
    @required String appSecret,
    String redirectURL = UmAppString.redirect_url_content,
  }) async {
    Map<String, dynamic> shareMap = {
      UmAppString.app_key: appKey,
      UmAppString.app_secret: appSecret,
      UmAppString.redirect_url: redirectURL,
    };
    final String result =
        await _channel.invokeMethod(UmAppMethod.share_init_sina, shareMap);
    return result;
  }

  /* 钉钉的appKey */
  static Future<String> initDingTalk({
    String appKey,
  }) async {
    Map<String, dynamic> shareMap = {
      UmAppString.app_key: appKey,
    };
    final String result =
        await _channel.invokeMethod(UmAppMethod.share_init_dingtalk, shareMap);
    return result;
  }

  static Future<ShareResultBean> share({ShareBean share}) async {
    Map<String, dynamic> shareMap = {
      UmAppParams.share_platform_type:
          share.platFormType == null ? 0 : share.platFormType.index,
      UmAppParams.share_title: share.title,
      UmAppParams.share_content: share.content,
      UmAppParams.share_image: share.image,
      UmAppParams.share_web_url: share.webUrl,
    };
    final Map result =
        await _channel.invokeMethod(share.appMethod, shareMap);
    ShareResultCode shareResponseType;
    if(result['code'] == 0){
      shareResponseType = ShareResultCode.failed;
    }else if(result['code'] == 1){
      shareResponseType = ShareResultCode.cancel;
    }else if(result['code'] == 2) {
      shareResponseType = ShareResultCode.success;
    }else {
      shareResponseType = ShareResultCode.unknown;
    }
    return ShareResultBean(code: shareResponseType,msg: result['msg']);
  }
}
