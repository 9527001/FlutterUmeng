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
        //        shareObject.thumbImage = [UIImage imageNamed:@"icon"];
        
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
        //        shareObject.thumbImage = [UIImage imageNamed:@"icon"];
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
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
            result(error.description);
        }else{
            NSLog(@"response data is %@",data);
            result(data);
        }
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
