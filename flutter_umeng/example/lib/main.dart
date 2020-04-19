import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutterumeng/flutterumeng.dart';

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
//    Flutterumeng.setLogEnabled(enabled: true);
//    Flutterumeng.shareInitUM(appKey: '5e9ad231978eea083f0c79af', channel: 'appstore');
//    Flutterumeng.shareInitDingTalk(appKey: 'dingoaiex4ka6vshseqky9');
    
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
                child: Text(
                  'text',
                ),
                onTap: () {
                  Flutterumeng.share(
                    share: ShareBean.text(
                        platFormType: SharePlatformType.DingTalk,
                        text: '123'),
                  );
                },
              ),
              GestureDetector(
                child: Text(
                  'image',
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
                child: Text(
                  'image text',
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
                child: Text(
                  'web',
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
            ],
          ),
        ),
      ),
    );
  }
}
