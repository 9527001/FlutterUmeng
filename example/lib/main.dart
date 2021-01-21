import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutterumeng/flutterumeng.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterumeng/social_platform_init_entity.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  GlobalKey _posterGlobalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    FlutterUmeng.init(
      uMengInitEntity: UMengInitEntity(
        androidAppKey: '5fbf49ec1e29ca3d7be61a7e',
        iosAppKey: '5e9ad231978eea083f0c79af',
        androidChannel: 'Android',
        iosChannel: 'App Store',
      ),
    );
    FlutterUmeng.initPlatforms(platforms: [
      SocialPlatformInitEntity(platformType: SharePlatformType.qq, appKey: '1110443120', appSecret: 'aYYjmc3FoH7Va8E7'),
      SocialPlatformInitEntity(
        platformType: SharePlatformType.wechat,
        appKey: 'wxffb1c9036944dc36',
        appSecret: '0fd7719d0a12c5f795d7bb67d5db034d',
        redirectURL: 'https://www.reading-china.com/',
      ),
      SocialPlatformInitEntity(
        platformType: SharePlatformType.sina,
        appKey: 'wxffb1c9036944dc36',
        appSecret: '0fd7719d0a12c5f795d7bb67d5db034d',
        redirectURL: 'https://www.reading-china.com/',
      ),
      SocialPlatformInitEntity(
        platformType: SharePlatformType.dingtalk,
        appKey: 'dingoaiex4ka6vshseqky9',
        appSecret: '',
      ),
    ]);

    FlutterUmeng.setLogEnabled(enabled: true);

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterUmeng.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepaintBoundary(
        key: _posterGlobalKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'text',
                    ),
                  ),
                  onTap: () {
                    FlutterUmeng.share(
                      share: ShareBean.text(platFormType: SharePlatformType.dingtalk, text: '123'),
                    );
                  },
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'image',
                    ),
                  ),
                  onTap: () {
                    FlutterUmeng.share(
                      share: ShareBean.image(
                          platFormType: SharePlatformType.dingtalk,
                          image:
                              'https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1587181134&di=012a3e34f388d1c9b8fab346fac09587&src=http://c.hiphotos.baidu.com/zhidao/pic/item/d009b3de9c82d1587e249850820a19d8bd3e42a9.jpg'),
                    );
                  },
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'image text',
                    ),
                  ),
                  onTap: () {
                    FlutterUmeng.share(
                      share: ShareBean.imageText(
                          platFormType: SharePlatformType.dingtalk,
                          text: '123',
                          image:
                              'https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1587181134&di=012a3e34f388d1c9b8fab346fac09587&src=http://c.hiphotos.baidu.com/zhidao/pic/item/d009b3de9c82d1587e249850820a19d8bd3e42a9.jpg'),
                    );
                  },
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'web',
                    ),
                  ),
                  onTap: () {
                    FlutterUmeng.share(
                      share: ShareBean.web(
                        platFormType: SharePlatformType.dingtalk,
                        title: '标题',
                        content: '副标题',
                        image:
                            'https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1587181134&di=012a3e34f388d1c9b8fab346fac09587&src=http://c.hiphotos.baidu.com/zhidao/pic/item/d009b3de9c82d1587e249850820a19d8bd3e42a9.jpg',
                        url: 'https://www.baidu.com',
                      ),
                    );
                  },
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '小程序测试',
                    ),
                  ),
                  onTap: () {
                    FlutterUmeng.share(
                      share: ShareBean.miniProgram(
                        platFormType: SharePlatformType.wechat,
                        title: '你多久没开心了',
                        content: '名片内容',
                        image: 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1689053532,4230915864&fm=26&gp=0.jpg',
                        webPageUrl: 'www.baidu.com',
                        userName: 'gh_fc260d5d7391',
                        path: 'page/home',
                        hdImageDataIos: null,
                        hdImageDataAndroid: 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1689053532,4230915864&fm=26&gp=0.jpg',
                        miniProgramType: 1,
                        withShareTicket: true,
                      ),
                    );
                  },
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '固定面板，测试使用',
                    ),
                  ),
                  onTap: () async {
                    ShareResultBean shareResultBean = await FlutterUmeng.share(
                      share: ShareBean.board(
                        text: '测试',
                      ),
                    );
                    Fluttertoast.showToast(
                        msg: shareResultBean.msg ?? '',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '获取版本号',
                    ),
                  ),
                  onTap: () async {
                    FlutterUmeng.setLogEnabled(enabled: true);
                  },
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '是否安装sina',
                    ),
                  ),
                  onTap: () async {
                    bool resutl = await FlutterUmeng.isInstall(SharePlatformType.sina);
                    log(resutl.toString());
                  },
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '是否安装sina2',
                    ),
                  ),
                  onTap: () async {
                    ShareResultBean shareResultBean = await FlutterUmeng.share(share: ShareBean.text(platFormType: SharePlatformType.sina, text: '123'));
                    log(shareResultBean.msg);
                  },
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '分享imageData 到微信',
                    ),
                  ),
                  onTap: () async {
                    Uint8List data = await _getImageData();
                    ShareResultBean shareResultBean = await FlutterUmeng.share(share: ShareBean.imageByte(platFormType: SharePlatformType.wechat, imageByte: data));
                    log(shareResultBean.msg);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _getImageData() async {
    RenderRepaintBoundary boundary = _posterGlobalKey.currentContext.findRenderObject();
    var image = await boundary.toImage(pixelRatio: 3);
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
//存储
    Uint8List imageByte = Uint8List.fromList(byteData.buffer.asUint8List());
    // imageByte = await FlutterImageCompress.compressWithList(
    //   imageByte,
    //   quality: 5,
    // );
    return imageByte;
  }
}
