import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutterumeng/flutterumeng.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    Flutterumeng.setLogEnabled(enabled: true);

    Flutterumeng.shareInitUMIos(
        appKey: '5e9ad231978eea083f0c79af', channel: 'appstore');
    Flutterumeng.shareInitUMAndroid(
        appKey: '5e9e8f0b978eea083f0c813e', channel: 'android');
    Flutterumeng.shareInitDingTalk(appKey: 'dingoaiex4ka6vshseqky9');
    Flutterumeng.shareInitQQ(
        appKey: '1110443120',
        appSecret: 'aYYjmc3FoH7Va8E7',
        redirectURL: '');
    Flutterumeng.shareInitWeChat(
        appKey: 'wxffb1c9036944dc36',
        appSecret: "0fd7719d0a12c5f795d7bb67d5db034d",
        redirectURL: 'https://www.reading-china.com/');
    Flutterumeng.shareInitSina(
        appKey: 'sina5e9e8f0b978',
        appSecret: "5e9e8f0b978",
        redirectURL: 'https://www.baidu.com');

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Flutterumeng.platformVersion;
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
      home: Scaffold(
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
                  Flutterumeng.share(
                    share: ShareBean.text(
                        platFormType: SharePlatformType.DingTalk, text: '123'),
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
                  Flutterumeng.share(
                    share: ShareBean.image(
                        platFormType: SharePlatformType.DingTalk,
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
                  Flutterumeng.share(
                    share: ShareBean.imageText(
                        platFormType: SharePlatformType.DingTalk,
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
                  Flutterumeng.share(
                    share: ShareBean.web(
                      platFormType: SharePlatformType.DingTalk,
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
                    '固定面板，测试使用',
                  ),
                ),
                onTap: () async {
                  ShareResponseType shareResponseType =
                  await Flutterumeng.share(
                    share: ShareBean.board(
                      text: '测试',
                    ),
                  );
                  String result;
                  switch (shareResponseType) {
                    case ShareResponseType.ShareResponseTypeUnknown:
                      result = '分享结果:未知';
                      break;
                    case ShareResponseType.ShareResponseTypeFail:
                      result = '分享结果:失败';
                      break;
                    case ShareResponseType.ShareResponseTypeCancel:
                      result = '分享结果:取消';

                      break;
                    case ShareResponseType.ShareResponseTypeSuccess:
                      result = '分享结果:成功';

                      break;
                  }
                  Fluttertoast.showToast(
                      msg: result,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
