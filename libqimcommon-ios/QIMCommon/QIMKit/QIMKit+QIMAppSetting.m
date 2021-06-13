//
//  QIMKit+QIMAppSetting.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMAppSetting.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMAppSetting)

- (BOOL)isFirstLauched {
    return [[STAppSetting sharedInstance] isFirstLauched];
}

+ (void)setAppConfigurationMode:(QIMAppConfigurationMode)mode {
    [[STAppSetting sharedInstance] setAppConfigurationMode:mode];
}

+ (QIMAppConfigurationMode)getCurrentAppConfigurationMode {
    return [[STAppSetting sharedInstance] getCurrentAppConfigurationMode];
}

- (BOOL)debugMode {
    return [[STAppSetting sharedInstance] debugMode];
}

- (NSString *)currentLanguage {
    return [[STAppSetting sharedInstance] currentLanguage];
}

/**
 设置高德地图的Key
 */
- (void)setGAODE_APIKEY:(NSString *)key {
    [[STAppSetting sharedInstance] setGAODE_APIKEY:key];
}

/**
 获取高德地图的Key
 */
- (NSString *)getGAODE_APIKEY {
    return [[STAppSetting sharedInstance] GAODE_APIKEY];
}

@end
