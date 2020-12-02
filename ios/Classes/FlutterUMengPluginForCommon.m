//
//  UMengFlutterPluginForUMCommon.m
//  flutterumeng
//
//  Created by 赵东 on 2020/12/2.
//

#import "FlutterUMengPluginForCommon.h"

#import "AppString.h"

#import <UMCommon/UMCommon.h>
#import <UShareUI/UShareUI.h>
#import "FlutterUMenPluginUtil.h"

@implementation FlutterUMengPluginForCommon


+ (BOOL)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result{
    BOOL resultCode = YES;
    NSString * method = call.method;
    NSDictionary * params = call.arguments;
    if ([@"shareInitUMIOS" isEqualToString:method]) {
        NSString * appkey = params[@"AppKey"];
        NSString * channel = params[@"channel"];
        [UMConfigure initWithAppkey:appkey channel:channel];
        result([UMConfigure getUmengToken]);
        NSLog(@"友盟初始化成功");
    }else if ([@"shareInitUM" isEqualToString:method]){
        
        NSDictionary *uMengInitDic = params[@"UMengInit"];
        NSString * appkey = uMengInitDic[@"iosAppKey"];
        NSString * channel = uMengInitDic[@"iosChannel"];
        [UMConfigure initWithAppkey:appkey channel:channel];
        
        NSLog(@"友盟初始化成功");
        result([UMConfigure getUmengToken]);
        
    }else if ([@"initPlatforms" isEqualToString:method]){
        
        NSArray *platformArray = call.arguments;
        for (NSDictionary * params in platformArray) {
            NSString * appkey = params[@"appKey"];
            NSString * appSecret = params[@"appSecret"];
            NSString * redirectURL = params[@"redirectURL"];
            NSNumber * platformType = params[@"platformType"];
            UMSocialPlatformType socialPlatformType = [FlutterUMenPluginUtil socialPlatformTypeWithCustomSharePlatformType:platformType];
            BOOL status = [[UMSocialManager defaultManager] setPlaform:socialPlatformType appKey:appkey appSecret:appSecret redirectURL:redirectURL];
            NSLog(@"%@初始化%@",[UMSocialPlatformConfig platformNameWithPlatformType:socialPlatformType],(status ? @"成功" : @"失败"));
        }
        result(@"成功");
    }else if ([@"shareInitWeChat" isEqualToString:method]){
        /* 设置微信的appKey和appSecret */
        NSString * appkey = params[AppKey];
        NSString * appSecret = params[AppSecret];
        NSString * redirectURL = params[RedirectURL];
        
        BOOL success = [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:appkey appSecret:appSecret redirectURL:redirectURL];
        result([NSNumber numberWithBool:success]);
        
    }else if ([@"shareInitQQ" isEqualToString:method]){
        /* 设置分享到QQ互联的appID
         * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
         */
        NSString * appkey = params[AppKey];
        NSString * redirectURL = params[RedirectURL];
        BOOL success =  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:appkey appSecret:nil redirectURL:redirectURL];
        result([NSNumber numberWithBool:success]);
        
    }else if ([@"shareInitSina" isEqualToString:method]){
        /* 设置新浪的appKey和appSecret */
        NSString * appkey = params[AppKey];
        NSString * appSecret = params[AppSecret];
        NSString * redirectURL = params[RedirectURL];
        BOOL success = [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:appkey appSecret:appSecret redirectURL:redirectURL];
        result([NSNumber numberWithBool:success]);
        
    }else if ([@"shareInitDingTalk" isEqualToString:method]){
        /* 钉钉的appKey */
        NSString * appkey = params[AppKey];
        BOOL success = [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_DingDing appKey:appkey appSecret:nil redirectURL:nil];
        result([NSNumber numberWithBool:success]);
        
    }else if ([@"setLogEnabled" isEqualToString:method]){
        /** 设置是否在console输出sdk的log信息.
         *  默认NO(不输出log); 设置为YES, 输出可供调试参考的log信息. 发布产品时必须设置为NO.
         */
        NSNumber * enabled = params[@"enable"] ;
        [UMConfigure setLogEnabled:[enabled boolValue]];
        NSLog(@"日志开启");
        
    }
    else if ([@"isInstall" isEqualToString:method]){
        BOOL success = [[UMSocialManager defaultManager] isInstall:[FlutterUMenPluginUtil socialPlatformTypeWithCustomSharePlatformType:params[@"platFormType"]]];
        result([NSNumber numberWithBool:success]);
        NSLog(@"是否安装了应用");
    }
    else if ([@"isSupport" isEqualToString:method]){
        BOOL success = [[UMSocialManager defaultManager] isSupport:[FlutterUMenPluginUtil socialPlatformTypeWithCustomSharePlatformType:params[@"platFormType"]]];
        result([NSNumber numberWithBool:success]);
        NSLog(@"是否支持分享");
    }else{
        resultCode = NO;
    }
    return resultCode;
}

@end
