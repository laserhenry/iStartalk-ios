//
//  QIMKit+AppInfo.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMAppInfo.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMAppInfo)

+ (void)setQIMProjectType:(QIMProjectType)appType {
    [[STAppInfo sharedInstance] setAppType:appType];
}

+ (QIMProjectType)getQIMProjectType {
    return [[STAppInfo sharedInstance] appType];
}

+ (void)setQIMApplicationState:(QIMApplicationState)appState {
    [[STAppInfo sharedInstance] setApplicationState:appState];
}

+ (QIMApplicationState)getQIMApplicationState {
    return [[STAppInfo sharedInstance] applicationState];
}

+ (void)setQIMProjectTitleName:(NSString *)appName {
    [[STAppInfo sharedInstance] setAppName:appName];
}

+ (NSString *)getQIMProjectTitleName {
    return [[STAppInfo sharedInstance] appName];
}

- (NSString *)getPushToken {
    return [[STAppInfo sharedInstance] pushToken];
}

- (void)setPushToken:(NSString *)pushToken {
    [[STAppInfo sharedInstance] setPushToken:pushToken];
}

// 机器的唯一标识
- (NSString *)appAID {
    return [[STAppInfo sharedInstance] appAID];
}

- (NSString *)macAddress {
    return [[STAppInfo sharedInstance] macAddress];
}

- (NSString *)Platform {
    return [[STAppInfo sharedInstance] Platform];
}

- (NSString *)deviceName {
    return [[STAppInfo sharedInstance] deviceName];
}

- (void)setCustomDeviceModel:(NSString *)customDeviceModel {
    [[STAppInfo sharedInstance] setCustomDeviceModel:customDeviceModel];
}

- (BOOL)getIsIpad {
    return [[STAppInfo sharedInstance] getIsIpad];
}

- (NSString *)SystemVersion {
    return [[STAppInfo sharedInstance] SystemVersion];
}

- (NSString *)carrierName {
    return [[STAppInfo sharedInstance] carrierName];
}

- (NSString *)AppVersion {
    return [[STAppInfo sharedInstance] AppVersion];
}

- (NSString *)AppBuildVersion {
    return [[STAppInfo sharedInstance] AppBuildVersion];
}

@end
