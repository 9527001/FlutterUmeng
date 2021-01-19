import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import 'um_config.dart';

class ShareBean {
  final SharePlatformType platFormType;
  final String title;
  final String content;
  final String image;//分享图片的路径
  final Uint8List imageByte; //分享图片使用
  final String webUrl;
  final String appMethod;
  final Map<String, dynamic> miniJsonMap;
  final String hdImageDataAndroid; //小程序消息封面图片，小于128k
  final Uint8List hdImageDataIos; //小程序消息封面图片，小于128k
  final dynamic hdImageData; //小程序消息封面图片，小于128k

  ShareBean({
    this.platFormType,
    this.title,
    this.content,
    this.image,
    this.imageByte,
    this.webUrl,
    this.appMethod,
    this.miniJsonMap,
    this.hdImageData,
    this.hdImageDataAndroid,
    this.hdImageDataIos,
  });

  factory ShareBean.text({
    @required SharePlatformType platFormType,
    @required String text,
  }) {
    return ShareBean(platFormType: platFormType, content: text, appMethod: UmAppMethod.share_text);
  }

  factory ShareBean.web({@required SharePlatformType platFormType, @required String title, @required String content, @required String image, @required String url}) {
    return ShareBean(platFormType: platFormType, title: title, content: content, image: image, webUrl: url, appMethod: UmAppMethod.share_web_view);
  }

  factory ShareBean.image({
    @required SharePlatformType platFormType,
    @required String image,
  }) {
    return ShareBean(platFormType: platFormType, image: image, appMethod: UmAppMethod.share_image);
  }

  factory ShareBean.imageByte({
    @required SharePlatformType platFormType,
    @required Uint8List imageByte,
  }) {
    return ShareBean(platFormType: platFormType, imageByte: imageByte, appMethod: UmAppMethod.share_image);
  }

  factory ShareBean.imageText({
    @required SharePlatformType platFormType,
    @required String image,
    @required String text,
  }) {
    return ShareBean(
      platFormType: platFormType,
      image: image,
      content: text,
      appMethod: UmAppMethod.share_image_text,
    );
  }
  factory ShareBean.imageByteText({
    @required SharePlatformType platFormType,
    @required Uint8List imageByte,
    @required String text,
  }) {
    return ShareBean(
      platFormType: platFormType,
      imageByte: imageByte,
      content: text,
      appMethod: UmAppMethod.share_image_text,
    );
  }

  factory ShareBean.miniProgram({
    @required SharePlatformType platFormType,
    @required String title,
    @required String content,
    String image, //在ios上显示的封面图片
    @required String webPageUrl, //低版本微信网页链接
    @required String userName, //小程序username，如 gh_3ac2059ac66f
    @required String path, //小程序页面路径，如 pages/page10007/page10007
    @required Uint8List hdImageDataIos, // 小程序新版本的预览图 128k iOS data 目前传null
    @required String hdImageDataAndroid, // 小程序新版本的预览图 128k android 都可以 ，目前仅支持string
    /**
        分享小程序的版本（正式，开发，体验）
        正式版 尾巴正常显示 0
        开发版 尾巴显示“未发布的小程序·开发版” 1
        体验版 尾巴显示“未发布的小程序·体验版” 2
     */
    @required int miniProgramType,
    @required bool withShareTicket, //是否使用带 shareTicket 的转发
  }) {
    return ShareBean(
      platFormType: platFormType,
      title: title,
      content: content,
      image: image,
      hdImageData: Platform.isAndroid ? hdImageDataAndroid : hdImageDataIos,
      appMethod: UmAppMethod.share_mini_program,
      miniJsonMap: MiniProgramBean(
        webPageUrl: webPageUrl,
        userName: userName,
        miniProgramType: miniProgramType,
        withShareTicket: withShareTicket,
        path: path,
      ).toJson(),
    );
  }

  factory ShareBean.board({
    @required String text,
  }) {
    return ShareBean(
      content: text,
      appMethod: UmAppMethod.share_with_board,
    );
  }
}

class MiniProgramBean {
  final String webPageUrl;
  final String userName;
  final String path;
  final int miniProgramType;
  final bool withShareTicket;

  MiniProgramBean({this.webPageUrl, this.userName, this.path, this.miniProgramType, this.withShareTicket});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['webpageUrl'] = this.webPageUrl;
    data['userName'] = this.userName;
    data['path'] = this.path;
    data['miniProgramType'] = this.miniProgramType;
    data['withShareTicket'] = this.withShareTicket;
    return data;
  }
}

/*分享结果 0 失败  1 取消 2 成功,未安装,不支持*/
enum ShareResultCode {
  unknown,
  failed,
  cancel,
  success,
  uninstall,
  notSupport,
}

/*分享平台*/
enum SharePlatformType {
  wechat, //微信好友
  wechat_circle, //微信朋友圈
  qq,
  qq_zone,
  sina,
  dingtalk,
}
