import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutterumeng/share_bean.dart';
export 'package:flutterumeng/share_bean.dart';

import 'app_string.dart';

class Flutterumeng {
  static const MethodChannel _channel = const MethodChannel('flutterumeng');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> shareInitUM({
    @required String appKey,
    @required String channel,
  }) async {
    Map<String, dynamic> shareMap = {
      AppString.AppKey: appKey,
      AppString.Channel: channel,
    };
    final String result =
        await _channel.invokeMethod(AppMethod.ShareInitUM, shareMap);
    return result;
  }

  static Future<String> shareInitUMAndroid({
    @required String appKey,
    @required String channel,
  }) async {
    Map<String, dynamic> shareMap = {
      AppString.AppKey: appKey,
      AppString.Channel: channel,
    };
    if (Platform.isAndroid) {
      final String result =
          await _channel.invokeMethod(AppMethod.ShareInitUMAndroid, shareMap);
      return result;
    }
    return '';

  }

  static Future<String> shareInitUMIos({
    @required String appKey,
    @required String channel,
  }) async {
    Map<String, dynamic> shareMap = {
      AppString.AppKey: appKey,
      AppString.Channel: channel,
    };
    if (Platform.isIOS) {
      final String result =
          await _channel.invokeMethod(AppMethod.ShareInitUMIOS, shareMap);
      return result;
    }
    return '';
  }

/*设置是否在console输出sdk的log信息.*/
  static Future setLogEnabled({
    @required bool enabled,
  }) async {
    Map<String, dynamic> shareMap = {
      AppParams.enable: enabled,
    };
    await _channel.invokeMethod(AppMethod.SetLogEnabled, shareMap);
  }

  static Future<String> shareInitWeChat({
    @required String appKey,
    @required String appSecret,
    String redirectURL = AppString.RedirectURLContent,
  }) async {
    Map<String, dynamic> shareMap = {
      AppString.AppKey: appKey,
      AppString.AppSecret: appSecret,
      AppString.RedirectURL: redirectURL,
    };
    final String result =
        await _channel.invokeMethod(AppMethod.ShareInitWeChat, shareMap);
    return result;
  }

  static Future<String> shareInitQQ({
    @required String appKey,
    @required String appSecret,
    String redirectURL = AppString.RedirectURLContent,
  }) async {
    Map<String, dynamic> shareMap = {
      AppString.AppKey: appKey,
      AppString.AppSecret: appSecret,
      AppString.RedirectURL: redirectURL,
    };
    final String result =
        await _channel.invokeMethod(AppMethod.ShareInitQQ, shareMap);
    return result;
  }

  static Future<String> shareInitSina({
    @required String appKey,
    @required String appSecret,
    String redirectURL = AppString.RedirectURLContent,
  }) async {
    Map<String, dynamic> shareMap = {
      AppString.AppKey: appKey,
      AppString.AppSecret: appSecret,
      AppString.RedirectURL: redirectURL,
    };
    final String result =
        await _channel.invokeMethod(AppMethod.ShareInitSina, shareMap);
    return result;
  }

  /* 钉钉的appKey */
  static Future<String> shareInitDingTalk({
    String appKey,
  }) async {
    Map<String, dynamic> shareMap = {
      AppString.AppKey: appKey,
    };
    final String result =
        await _channel.invokeMethod(AppMethod.ShareInitDingTalk, shareMap);
    return result;
  }

  static Future<String> share({ShareBean share}) async {
    Map<String, dynamic> shareMap = {
      AppParams.SharePlatformType:
          share.platFormType == null ? 0 : share.platFormType.index,
      AppParams.ShareTitle: share.title,
      AppParams.ShareContent: share.content,
      AppParams.ShareImage: share.image,
      AppParams.ShareWebUrl: share.webUrl,
    };
    final String result =
        await _channel.invokeMethod(share.appMethod, shareMap);
    return result;
  }
}
