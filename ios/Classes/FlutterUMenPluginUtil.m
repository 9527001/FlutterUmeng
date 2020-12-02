//
//  FlutterUMenPluginUtil.m
//  flutterumeng
//
//  Created by 赵东 on 2020/12/2.
//

#import "FlutterUMenPluginUtil.h"

@implementation FlutterUMenPluginUtil

+ (UMSocialPlatformType)socialPlatformTypeWithCustomSharePlatformType:(NSNumber *)sharePlatformType {
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
