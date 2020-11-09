#import "FlutterumengPlugin.h"

#import "AppString.h"

#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <UMCommonLog/UMCommonLogHeaders.h>
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>
#import <UMCShare/UMSocialQQHandler.h>
#import <UMCShare/UMSocialQQHandler.h>
#import <UMCShare/UMSocialQQHandler.h>




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
    
    __strong NSString * methodString = call.method;
    __strong NSDictionary * params = call.arguments;
    if ([MethodShareInitUM isEqualToString:methodString]) {
        NSString * appkey = params[AppKey];
        NSString * channel = params[Channel];
        [UMConfigure initWithAppkey:appkey channel:channel];
        result([UMConfigure umidString]);
        NSLog(@"友盟初始化成功");
        
    }
    else if ([StringMethodSetLogEnabled isEqualToString:methodString]){
        /** 设置是否在console输出sdk的log信息.
         *  默认NO(不输出log); 设置为YES, 输出可供调试参考的log信息. 发布产品时必须设置为NO.
         */
        NSNumber * enabled = params[StringParamsEnable] ;
        [UMConfigure setLogEnabled:[enabled boolValue]];
        NSLog(@"日志开启");
        
    }else if ([MethodShareInitWeChat isEqualToString:methodString]){
        /* 设置微信的appKey和appSecret */
        NSString * appkey = params[AppKey];
        NSString * appSecret = params[AppSecret];
        NSString * redirectURL = params[RedirectURL];
        
        BOOL success = [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:appkey appSecret:appSecret redirectURL:redirectURL];
        result([NSNumber numberWithBool:success]);
        
    }else if ([MethodShareInitQQ isEqualToString:methodString]){
        /* 设置分享到QQ互联的appID
         * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
         */
        NSString * appkey = params[AppKey];
        NSString * redirectURL = params[RedirectURL];
        BOOL success =  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:appkey appSecret:nil redirectURL:redirectURL];
        result([NSNumber numberWithBool:success]);
        
    }else if ([MethodShareInitSina isEqualToString:methodString]){
        /* 设置新浪的appKey和appSecret */
        NSString * appkey = params[AppKey];
        NSString * appSecret = params[AppSecret];
        NSString * redirectURL = params[RedirectURL];
        BOOL success = [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:appkey appSecret:appSecret redirectURL:redirectURL];
        result([NSNumber numberWithBool:success]);
        
    }else if ([MethodShareInitDingTalk isEqualToString:methodString]){
        /* 钉钉的appKey */
        NSString * appkey = params[AppKey];
        BOOL success = [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_DingDing appKey:appkey appSecret:nil redirectURL:nil];
        result([NSNumber numberWithBool:success]);
        
    }else if ([MethodShareText isEqualToString:methodString]){
        
        NSString * shareText = params[ShareContent];
        
        UMSocialPlatformType platformType = [self socialPlatformTypeWithCustomSharePlatformType:params[SharePlatformType]];
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //设置文本
        messageObject.text = shareText;
        //调用分享接口
        [self shareWithPlaformType:platformType messageObject:messageObject result:result];
    }else if ([MethodShareImage isEqualToString:methodString]){
        
        NSString * shareImage = params[ShareImage];
        UMSocialPlatformType platformType = [self socialPlatformTypeWithCustomSharePlatformType:params[SharePlatformType]];
        
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        shareObject.thumbImage = shareImage;
        
        /** 分享单个图片（支持UIImage，NSdata以及图片链接Url NSString类对象集合）
         * @note 图片大小根据各个平台限制而定
         */
        [shareObject setShareImage:shareImage];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        //调用分享接口
        [self shareWithPlaformType:platformType messageObject:messageObject result:result];
    }else if ([MethodshareImageText isEqualToString:methodString]){
        NSString * shareImage = params[ShareImage];
        UMSocialPlatformType platformType = [self socialPlatformTypeWithCustomSharePlatformType:params[SharePlatformType]];
        NSString * shareText = params[ShareContent];
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //设置文本
        messageObject.text = shareText;
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        shareObject.thumbImage = shareImage;
        [shareObject setShareImage:shareImage];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        //调用分享接口
        [self shareWithPlaformType:platformType messageObject:messageObject result:result];
    }else if ([MethodShareWebView isEqualToString:methodString]){
        
        UMSocialPlatformType platformType = [self socialPlatformTypeWithCustomSharePlatformType:params[SharePlatformType]];
        NSString * shareTitle = params[ShareTitle];
        NSString * shareContent = params[ShareContent];
        id shareImage = params[ShareImage];
        NSString * shareWebUrl = params[ShareWebUrl];
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareTitle descr:shareContent thumImage:shareImage];
        //设置网页地址
        shareObject.webpageUrl = shareWebUrl;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        [self shareWithPlaformType:platformType messageObject:messageObject result:result];
        
    }else if ([MethodShareWithBoard isEqualToString:methodString]){
        
        
        //显示分享面板
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            
            
            // 根据获取的platformType确定所选平台进行下一步操作
            
            NSString * shareText = params[ShareContent];
            
            
            //创建分享消息对象
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            //设置文本
            messageObject.text = shareText;
            //调用分享接口
            [self shareWithPlaformType:platformType messageObject:messageObject result:result];
            
        }];
        
    }else if ([MethodShareMiniProgram isEqualToString:methodString]){
        
        
        UMSocialPlatformType platformType = [self socialPlatformTypeWithCustomSharePlatformType:params[SharePlatformType]];
        
        NSString * shareTitle = params[ShareTitle];
        NSString * shareContent = params[ShareContent];//存储小程序ID
        NSString * shareImage = params[ShareImage];//暂时只支持url
        FlutterStandardTypedData * hdImageData = params[ShareHDImageData];
        
        NSDictionary *dic = params[ShareMPJsonStr];
        NSString * webpageUrl = dic[ShareWebpageUrl];
        NSString * userName = dic[ShareUserName];
        NSString * path = dic[SharePath];
        NSNumber * miniProgramType = dic[ShareMiniProgramType];
        NSNumber * withShareTicket = dic[ShareWithShareTicket];
        
        //支持分享小程序类型消息至会话，暂不支持分享至朋友圈。
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:shareTitle descr:shareContent thumImage:shareImage];
        shareObject.webpageUrl = webpageUrl;//兼容微信低版本网页地址
        shareObject.userName = userName;//"小程序username，如 gh_3ac2059ac66f
        shareObject.path = path;//小程序页面路径，如 pages/page10007/page10007
        if([hdImageData isKindOfClass:[FlutterStandardTypedData class]]){
            shareObject.hdImageData = hdImageData.data;
        }
        shareObject.miniProgramType = miniProgramType.intValue; // 可选体验版和开发板
        shareObject.withShareTicket = withShareTicket.boolValue;
        
        messageObject.shareObject = shareObject;
        [self shareWithPlaformType:platformType messageObject:messageObject result:result];
        
        
    }else if ([@"getPlatformVersion" isEqualToString:methodString]){
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }
    
    else {
        result(FlutterMethodNotImplemented);
    }
    
    
}

- (void)shareWithPlaformType:(UMSocialPlatformType)platformType messageObject:(UMSocialMessageObject *)messageObject  result:(FlutterResult)result {
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
        int code = 2;
        NSString *msg = @"分享成功";
        if (error) {
            if (error.code == UMSocialPlatformErrorType_Cancel) {//取消
                code = 1;
                msg = @"取消分享";
            }else{
                code = 0;
                msg = error.userInfo[@"message"];
            }
        }
        resultDic[@"code"] = [NSNumber numberWithInt:code];
        resultDic[@"msg"] = msg;
        result(resultDic);
    }];
}

- (UMSocialPlatformType)socialPlatformTypeWithCustomSharePlatformType:(NSNumber *)sharePlatformType {
    switch ([sharePlatformType integerValue]) {
        case 0:
        {
            return UMSocialPlatformType_WechatSession;
        }
            break;
        case 1:
        {
            return UMSocialPlatformType_WechatTimeLine;
        }
            break;
        case 2:
        {
            return UMSocialPlatformType_QQ;
        }
            break;
        case 3:
        {
            return UMSocialPlatformType_Qzone;
        }
            break;
        case 4:
        {
            return UMSocialPlatformType_Sina;
        }
            break;
        case 5:
        {
            return UMSocialPlatformType_DingDing;
        }
            break;
        default:
        {
            return UMSocialPlatformType_UnKnown;
        }
            break;
    }
}

@end
