//
//  AppString.h
//  Pods
//
//  Created by 赵东 on 2020/4/19.
//

#ifndef AppString_h
#define AppString_h


//参数
static  NSString *  const SharePlatformType = @"platFormType";
static  NSString * const ShareTitle = @"title";
static const NSString *  ShareContent = @"content";
static const NSString *  ShareImage = @"image";
static const NSString *  ShareWebUrl = @"webUrl";
static const NSString *  ShareAppMethod = @"appMethod";
static const NSString * StringParamsEnable = @"enable";

//miniProgram
static const NSString * ShareMPJsonStr = @"mpJsonStr";
static const NSString * ShareWebpageUrl = @"webpageUrl";
static const NSString * ShareUserName = @"userName";
static const NSString * SharePath = @"path";
static const NSString * ShareHDImageData = @"hdImageData";//小程序消息封面图片，小于128k
static const NSString * ShareMiniProgramType = @"miniProgramType";
static const NSString * ShareWithShareTicket = @"withShareTicket";


//初始化配置
static const NSString *  AppKey = @"AppKey";
static const NSString *  AppSecret = @"AppSecret";
static const NSString *  RedirectURL = @"RedirectURL";
static const NSString *  Channel = @"channel";


#endif /* AppString_h */
