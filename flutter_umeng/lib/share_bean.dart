import 'package:flutter/cupertino.dart';

import 'app_string.dart';

class ShareBean {
  final SharePlatformType platFormType;
  final String title;
  final String content;
  final String image;
  final String webUrl;
  final String appMethod;

  ShareBean(
      {this.platFormType,
      this.title,
      this.content,
      this.image,
      this.webUrl,
      this.appMethod});

  factory ShareBean.text({
    @required SharePlatformType platFormType,
    @required String text,
  }) {
    return ShareBean(
        platFormType: platFormType,
        content: text,
        appMethod: AppMethod.ShareText);
  }

  factory ShareBean.web(
      {@required SharePlatformType platFormType,
      @required String title,
      @required String content,
      @required String image,
      @required String url}) {
    return ShareBean(
        platFormType: platFormType,
        title: title,
        content: content,
        image: image,
        webUrl: url,
        appMethod: AppMethod.ShareWebView);
  }

  factory ShareBean.image({
    @required SharePlatformType platFormType,
    @required String image,
  }) {
    return ShareBean(
        platFormType: platFormType,
        image: image,
        appMethod: AppMethod.ShareImage);
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
        appMethod: AppMethod.shareImageText);
  }
}

/*分享平台*/
enum SharePlatformType {
  WeChatSession , //微信好友
  WeChatTimeLine, //微信朋友圈
  QQ,
  QQZone,
  Sina,
  DingTalk,
}
