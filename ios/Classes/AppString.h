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

// 方法
static const NSString *  MethodShareText = @"shareText";
static const NSString *  MethodShareImage = @"shareImage";
static const NSString *  MethodshareImageText = @"shareImageText";
static const NSString *  MethodShareWebView = @"shareWebView";
static const NSString *  MethodShareMiniProgram = @"shareMiniProgram";//小程序
static const NSString *  MethodShareWithBoard = @"shareWithBoard";

static const NSString *  MethodShareInitUM = @"shareInitUMIOS";
static const NSString *  MethodShareInitWeChat = @"shareInitWeChat";
static const NSString *  MethodShareInitQQ = @"shareInitQQ";
static const NSString *  MethodShareInitSina = @"shareInitSina";
static const NSString * MethodShareInitDingTalk = @"shareInitDingTalk";

static const NSString * StringMethodSetLogEnabled = @"setLogEnabled";

static const NSString * StringMethodIsInstall = @"isInstall";

static const NSString * StringMethodIsSupport = @"isSupport";
#endif /* AppString_h */
