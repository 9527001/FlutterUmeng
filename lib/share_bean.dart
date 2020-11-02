import 'package:flutter/cupertino.dart';

import 'um_config.dart';

class ShareBean {
  final SharePlatformType platFormType;
  final String title;
  final String content;
  final String image;
  final String webUrl;
  final String appMethod;

  ShareBean({this.platFormType, this.title, this.content, this.image, this.webUrl, this.appMethod});

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

  factory ShareBean.miniProgram({
    @required SharePlatformType platFormType,
    @required String userName,
    @required String title,
    @required String url,
  }) {
    return ShareBean(
      platFormType: platFormType,
      title: title,
      content: userName,
      webUrl: url,
      appMethod: UmAppMethod.share_mini_program,
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

/*分享结果 0 失败  1 取消 2 成功*/
enum ShareResultCode {
  unknown,
  failed,
  cancel,
  success,
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
