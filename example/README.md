# flutterumeng_example

Demonstrates how to use the flutterumeng plugin.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## QQ
### appID 1110443120
### appkey aYYjmc3FoH7Va8E7

## sina
### App Key 655199122
### App Secret 17dfef507567f6f038e20ef2a2b1f1ca

## dingtalk
### appkey dingoaiex4ka6vshseqky9

## 信息
### iOS
#### bundleID zd.com.flutterumengExample

### android
#### 包名 zd.com.flutterumeng_example
#### 签名 zd.com.flutterumeng_example



## android 配置记录
## 1.配置清单
## 2.build.grade文件配置
### dingtalk
#### 在主工程配置文件，复制android代码部分的ddshare文件到主工程中
### QQ
#### 主工程的androd 的App的 build.grade配置          manifestPlaceholders = [qqappid: "xxxxxxx"]
### wechat
#### 常规配置
### sina
#### 1.因为友盟为导入新浪核心库，需要额外导入         api 'com.sina.weibo.sdk:core:4.4.3:openDefaultRelease@aar' 且 配置