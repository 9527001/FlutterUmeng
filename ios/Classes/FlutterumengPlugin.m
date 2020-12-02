#import "FlutterumengPlugin.h"

#import "AppString.h"

#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>


#import "FlutterUMengPluginForCommon.h"
#import "FlutterUMengPluginForShare.h"
#import "FlutterUMengPluginForAnalytics.h"


@implementation FlutterumengPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutterumeng"
                                     binaryMessenger:[registrar messenger]];
    FlutterumengPlugin* instance = [[FlutterumengPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addApplicationDelegate:instance];
    
    
}


// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler
{
    if (![[UMSocialManager defaultManager] handleUniversalLink:userActivity options:nil]) {
        // 其他SDK的回调
    }
    return YES;
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
    BOOL resultCode =[FlutterUMengPluginForCommon handleMethodCall:call result:result];
    if (resultCode) return;
    
    resultCode = [FlutterUMengPluginForAnalytics handleMethodCall:call result:result];
    if (resultCode) return;
    
    
    resultCode = [FlutterUMengPluginForShare handleMethodCall:call result:result];
    if (resultCode) return;
    
    result(FlutterMethodNotImplemented);
    
}

@end

