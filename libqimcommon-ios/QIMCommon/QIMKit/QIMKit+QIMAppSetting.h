//
//  QIMKit+QIMAppSetting.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMAppSetting)

/**
 判断是否为第一次安装
 */
- (BOOL)isFirstLauched;

/**
 设置当前App环境配置
 */
+ (void)setAppConfigurationMode:(QIMAppConfigurationMode)mode;


/**
 获取当前App环境配置
 */
+ (QIMAppConfigurationMode)getCurrentAppConfigurationMode;

/**
 判断是否为Debug模式
 */
- (BOOL)debugMode;

/**
 获取当前系统语言
 */
- (NSString *)currentLanguage;

/**
 设置高德地图的Key
 */
- (void)setGAODE_APIKEY:(NSString *)key;

/**
 获取高德地图的Key
 */
- (NSString *)getGAODE_APIKEY;

@end
