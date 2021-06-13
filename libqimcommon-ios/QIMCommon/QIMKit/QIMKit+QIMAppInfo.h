//
//  QIMKit+QIMAppInfo.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMAppInfo)
    
+ (void)setQIMProjectType:(QIMProjectType)appType;
    
+ (QIMProjectType)getQIMProjectType;

+ (void)setQIMApplicationState:(QIMApplicationState)appState;

+ (QIMApplicationState)getQIMApplicationState;

+ (void)setQIMProjectTitleName:(NSString *)appName;

+ (NSString *)getQIMProjectTitleName;

/**
 获取推送的Token

 @return PushToken
 */
- (NSString *)getPushToken;

/**
 设置推送的Token

 @param pushToken pushToken
 */
- (void)setPushToken:(NSString *)pushToken;

/**
 网卡地址
 */
- (NSString *)macAddress;

/**
 终端
 */
- (NSString *)Platform;

/**
 设备名称
 */
- (NSString *)deviceName;

/**
 机器码（唯一标识）
 */
- (NSString *)appAID;


/**
 用户自定义设备Model
 iPhone / iPad
 @param customDeviceModel 设备Model
 */
- (void)setCustomDeviceModel:(NSString *)customDeviceModel;

/**
 判断是不是iPad
 */
- (BOOL)getIsIpad;

/**
 系统版本
 */
- (NSString *)SystemVersion;

/**
 运营商
 */
- (NSString *)carrierName;

/**
 App版本号
 */
- (NSString *)AppVersion;

/**
 App Build版本号
 */
- (NSString *)AppBuildVersion;

@end
