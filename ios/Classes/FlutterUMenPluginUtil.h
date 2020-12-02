//
//  FlutterUMenPluginUtil.h
//  flutterumeng
//
//  Created by 赵东 on 2020/12/2.
//

#import <Foundation/Foundation.h>


#import <UMShare/UMShare.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlutterUMenPluginUtil : NSObject

+ (UMSocialPlatformType)socialPlatformTypeWithCustomSharePlatformType:(NSNumber *)sharePlatformType;

@end

NS_ASSUME_NONNULL_END
