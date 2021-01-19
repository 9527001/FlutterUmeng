//
//  UmengFlutterPluginShare.m
//  flutterumeng
//
//  Created by 赵东 on 2020/12/2.
//

#import "FlutterUMengPluginForShare.h"

#import <UMCommon/UMCommon.h>
#import <UMCommon/MobClick.h>
#import <UMShare/UMShare.h>
#import <UMCommonLog/UMCommonLogHeaders.h>
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>
#import <UMCShare/UMSocialQQHandler.h>
#import <UMCShare/UMSocialQQHandler.h>
#import <UMCShare/UMSocialQQHandler.h>
#import "AppString.h"

#import "FlutterUMenPluginUtil.h"

@implementation FlutterUMengPluginForShare


+ (BOOL)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
    NSString * methodString = call.method;
    NSDictionary * params = call.arguments;
    
    BOOL resultCode = YES;
    if ([@"shareText" isEqualToString:methodString]){
        
        NSString * shareText = params[ShareContent];
        
        UMSocialPlatformType platformType = [FlutterUMenPluginUtil socialPlatformTypeWithCustomSharePlatformType:params[SharePlatformType]];
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //设置文本
        messageObject.text = shareText;
        //调用分享接口
        [[self class] shareWithPlaformType:platformType messageObject:messageObject result:result];
    }else if ([@"shareImage" isEqualToString:methodString]){
        
        NSString * shareImage = params[ShareImage];
        
        UMSocialPlatformType platformType = [FlutterUMenPluginUtil socialPlatformTypeWithCustomSharePlatformType:params[SharePlatformType]];
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        if(shareImage){
            //如果有缩略图，则设置缩略图
            shareObject.thumbImage = shareImage;
            
            /** 分享单个图片（支持UIImage，NSdata以及图片链接Url NSString类对象集合）
             * @note 图片大小根据各个平台限制而定
             */
            [shareObject setShareImage:shareImage];
        }else{
            FlutterStandardTypedData * shareImageByte = params[ShareImageByte];
            if([shareImageByte isKindOfClass:[FlutterStandardTypedData class]]){
                shareObject.thumbImage = shareImageByte.data;
                [shareObject setShareImage:shareImageByte.data];
            }
        }
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        //调用分享接口
        [[self class] shareWithPlaformType:platformType messageObject:messageObject result:result];
    }else if ([@"shareImageText" isEqualToString:methodString]){
        NSString * shareImage = params[ShareImage];
        UMSocialPlatformType platformType = [FlutterUMenPluginUtil socialPlatformTypeWithCustomSharePlatformType:params[SharePlatformType]];
        NSString * shareText = params[ShareContent];
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //设置文本
        messageObject.text = shareText;
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        if(shareImage){
            //如果有缩略图，则设置缩略图
            shareObject.thumbImage = shareImage;
            
            /** 分享单个图片（支持UIImage，NSdata以及图片链接Url NSString类对象集合）
             * @note 图片大小根据各个平台限制而定
             */
            [shareObject setShareImage:shareImage];
        }else{
            FlutterStandardTypedData * shareImageByte = params[ShareImageByte];
            if([shareImageByte isKindOfClass:[FlutterStandardTypedData class]]){
                shareObject.thumbImage = shareImageByte.data;
                [shareObject setShareImage:shareImageByte.data];
            }
        }
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        //调用分享接口
        [[self class] shareWithPlaformType:platformType messageObject:messageObject result:result];
    }else if ([@"shareWebView" isEqualToString:methodString]){
        
        UMSocialPlatformType platformType = [FlutterUMenPluginUtil socialPlatformTypeWithCustomSharePlatformType:params[SharePlatformType]];
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
        [[self class] shareWithPlaformType:platformType messageObject:messageObject result:result];
        
    }else if ([@"shareWithBoard" isEqualToString:methodString]){
        
        
        //显示分享面板
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            
            
            // 根据获取的platformType确定所选平台进行下一步操作
            
            NSString * shareText = params[ShareContent];
            
            
            //创建分享消息对象
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            //设置文本
            messageObject.text = shareText;
            //调用分享接口
            [[self class] shareWithPlaformType:platformType messageObject:messageObject result:result];
            
        }];
        
    }else if ([@"shareMiniProgram" isEqualToString:methodString]){
        
        
        UMSocialPlatformType platformType = [FlutterUMenPluginUtil socialPlatformTypeWithCustomSharePlatformType:params[SharePlatformType]];
        
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
        [self.class shareWithPlaformType:platformType messageObject:messageObject result:result];
        
        
    }else if ([@"getPlatformVersion" isEqualToString:methodString]){
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }  else {
        resultCode = NO;
    }
    return resultCode;
    
}

+ (void)shareWithPlaformType:(UMSocialPlatformType)platformType messageObject:(UMSocialMessageObject *)messageObject  result:(FlutterResult)result {
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

@end
