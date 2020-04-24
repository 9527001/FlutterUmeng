# flutterumeng

A new Flutter  umeng plugin.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## ios 工程配置
## 1.配置SSO白名单
如果你的应用使用了如SSO授权登录或跳转到第三方分享功能，在iOS9/10下就需要增加一个可跳转的白名单，即LSApplicationQueriesSchemes，否则将在SDK判断是否跳转时用到的canOpenURL时返回NO，进而只进行webview授权或授权/分享失败。在项目中的info.plist中加入应用白名单，右键info.plist选择source code打开(plist具体设置在Build Setting -> Packaging -> Info.plist File可获取plist路径)请根据选择的平台对以下配置进行裁剪：

## 2.配置URL Scheme
URL Scheme是通过系统找到并跳转对应app的一类设置，通过向项目中的info.plist文件中加入URL types可使用第三方平台所注册的appkey信息向系统注册你的app，当跳转到第三方应用授权或分享后，可直接跳转回你的app。

添加URL Types可工程设置面板设置
## android
### 1.主工程的androd 的App的 build.grade配置          manifestPlaceholders = [qqappid: "xxxxxxx"]
#### 2.在主工程配置文件，复制android代码部分的ddshare文件到主工程中
       maven { url "https://dl.bintray.com/thelasterstar/maven/" }







