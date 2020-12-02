import 'package:flutter/material.dart';
import 'package:flutterumeng/share_bean.dart';

class SocialPlatformInitEntity {
  String redirectURL;
  String appKey;
  String appSecret;
  SharePlatformType platformType;

  SocialPlatformInitEntity({
    this.redirectURL = '',
    @required this.appKey,
    @required this.appSecret,
    @required this.platformType,
  });

  SocialPlatformInitEntity.fromJson(Map<String, dynamic> json) {
    redirectURL = json['redirectURL'];
    appKey = json['appKey'];
    appSecret = json['appSecret'];
    platformType = json['platformType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['redirectURL'] = this.redirectURL;
    data['appKey'] = this.appKey;
    data['appSecret'] = this.appSecret;
    data['platformType'] = this.platformType;
    return data;
  }
  Map<String, dynamic> toFinalJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['redirectURL'] = this.redirectURL;
    data['appKey'] = this.appKey;
    data['appSecret'] = this.appSecret;
    data['platformType'] = this.platformType.index;
    return data;
  }
}

class UMengInitEntity {
  String androidAppKey;
  String iosAppKey;
  String androidChannel;
  String iosChannel;

  UMengInitEntity({
    @required this.androidAppKey,
    @required this.iosAppKey,
    this.androidChannel = 'Android',
    this.iosChannel = 'App Store',
  });

  UMengInitEntity.fromJson(Map<String, dynamic> json) {
    androidAppKey = json['androidAppKey'];
    iosAppKey = json['iosAppKey'];
    androidChannel = json['androidChannel'];
    iosChannel = json['iosChannel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['androidAppKey'] = this.androidAppKey;
    data['iosAppKey'] = this.iosAppKey;
    data['androidChannel'] = this.androidChannel;
    data['iosChannel'] = this.iosChannel;
    return data;
  }
}
