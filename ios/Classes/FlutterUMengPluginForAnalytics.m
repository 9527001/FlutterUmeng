//
//  UMengFlutterPluginForAnalytics.m
//  flutterumeng
//
//  Created by 赵东 on 2020/12/2.
//

#import "FlutterUMengPluginForAnalytics.h"


#import <UMCommon/MobClick.h>

@implementation FlutterUMengPluginForAnalytics

+ (BOOL)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result{
    BOOL resultCode = YES;
    NSArray* arguments = (NSArray *)call.arguments;
    if ([@"onEvent" isEqualToString:call.method]){
        NSString* eventName = arguments[0];
        NSDictionary* properties = arguments[1];
        [MobClick event:eventName attributes:properties];
        //result(@"success");
    }
    else if ([@"onProfileSignIn" isEqualToString:call.method]){
        NSString* userID = arguments[0];
        [MobClick profileSignInWithPUID:userID];
        //result(@"success");
    }
    else if ([@"onProfileSignOff" isEqualToString:call.method]){
        [MobClick profileSignOff];
        //result(@"success");
    }
    else if ([@"setPageCollectionModeAuto" isEqualToString:call.method]){
        [MobClick setAutoPageEnabled:YES];
        //result(@"success");
    }
    else if ([@"setPageCollectionModeManual" isEqualToString:call.method]){
        [MobClick setAutoPageEnabled:NO];
        //result(@"success");
    }
    else if ([@"onPageStart" isEqualToString:call.method]){
        NSString* pageName = arguments[0];
        [MobClick beginLogPageView:pageName];
        //result(@"success");
    }
    else if ([@"onPageEnd" isEqualToString:call.method]){
        NSString* pageName = arguments[0];
        [MobClick endLogPageView:pageName];
        //result(@"success");
    }
    else if ([@"reportError" isEqualToString:call.method]){
        NSLog(@"reportError API not existed ");
        //result(@"success");
    }
    else{
        resultCode = NO;
    }
    return resultCode;
}


@end
