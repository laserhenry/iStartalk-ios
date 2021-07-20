//
//  QIMKit+QIMClientConfig.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMClientConfig.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMClientConfig)

- (NSString *)transformClientConfigKeyWithType:(QIMClientConfigType)type {
    return [[STManager sharedInstance] transformClientConfigKeyWithType:type];
}

- (NSString *)getClientConfigInfoWithType:(QIMClientConfigType)type WithSubKey:(NSString *)subKey {
    return [[STManager sharedInstance] getClientConfigInfoWithType:type WithSubKey:subKey];
}

- (NSArray *)getClientConfigInfoArrayWithType:(QIMClientConfigType)type {
    return [[STManager sharedInstance] getClientConfigInfoArrayWithType:type];
}

- (NSArray *)getClientConfigInfoArrayWithType:(QIMClientConfigType *)type WithDeleteFlag:(BOOL)deleteFlag {
    return [[STManager sharedInstance] getClientConfigInfoArrayWithType:type WithDeleteFlag:deleteFlag];
}

- (NSArray *)getClientConfigValueArrayWithType:(QIMClientConfigType)type {
    return [[STManager sharedInstance] getClientConfigValueArrayWithType:type];
}

- (NSArray *)getClientConfigValueArrayWithType:(QIMClientConfigType)type WithDeleteFlag:(BOOL)deleteFlag {
    return [[STManager sharedInstance] getClientConfigValueArrayWithType:type WithDeleteFlag:deleteFlag];
}

- (void)insertNewClientConfigInfoWithData:(NSDictionary *)result {
    [[STManager sharedInstance] insertNewClientConfigInfoWithData:result];
}

- (void)updateRemoteClientConfigWithType:(QIMClientConfigType)type BatchProcessConfigInfo:(NSArray *)configInfoArray WithDel:(BOOL)delFlag withCallback:(QIMKitUpdateRemoteClientConfig)callback {
    [[STManager sharedInstance] updateRemoteClientConfigWithType:type BatchProcessConfigInfo:configInfoArray WithDel:delFlag withCallback:callback];
}

- (void)updateRemoteClientConfigWithType:(QIMClientConfigType)type WithSubKey:(NSString *)subKey WithConfigValue:(NSString *)configValue WithDel:(BOOL)delFlag withCallback:(QIMKitUpdateRemoteClientConfig)callback {
    [[STManager sharedInstance] updateRemoteClientConfigWithType:type WithSubKey:subKey WithConfigValue:configValue WithDel:delFlag withCallback:callback];
}

- (void)getRemoteClientConfig {
    [[STManager sharedInstance] getRemoteClientConfig];
}

//返回星标联系人或者黑名单用户
- (NSMutableArray *)selectStarOrBlackContacts:(NSString *)pkey {
    return [[STManager sharedInstance] selectStarOrBlackContacts:pkey];
}

//查询不在星标用户的好友
- (NSMutableArray *)selectFriendsNotInStarContacts {
    return [[STManager sharedInstance] selectFriendsNotInStarContacts];
}

//搜索不在星标里面的用户
- (NSMutableArray *)selectUserNotInStartContacts:(NSString *)key {
    return [[STManager sharedInstance] selectUserNotInStartContacts:key];
}

- (BOOL)isStarOrBlackContact:(NSString *)subkey ConfigKey:(NSString *)pkey{
    return [[STManager sharedInstance] isStarOrBlackContact:subkey ConfigKey:pkey];
}

- (void)setStarOrblackContact:(NSString *)subkey ConfigKey:(NSString *)pkey Flag:(BOOL)value withCallback:(QIMKitUpdateRemoteClientConfig)callback {
    [[STManager sharedInstance] setStarOrblackContact:subkey ConfigKey:pkey Flag:value withCallback:callback];
}

- (void)setStarOrblackContacts:(NSDictionary *)map ConfigKey:(NSString *)pkey Flag:(BOOL)value withCallback:(QIMKitUpdateRemoteClientConfig)callback {
    [[STManager sharedInstance] setStarOrblackContacts:map ConfigKey:pkey Flag:value withCallback:callback];
}

/**
 客户端消息提示音

 @return 提示音soundName
 */
- (NSString *)getClientNotificationSoundName {
    return [[STManager sharedInstance] getClientNotificationSoundName];
}

/**
 设置客户端消息提示音

 @param soundName 提示音文件名
 @return 是否设置成功
 */
- (void)setClientNotificationSound:(NSString *)soundName withCallback:(QIMKitUpdateRemoteClientConfig)callback {
    return [[STManager sharedInstance] setClientNotificationSound:soundName withCallback:callback];
}

@end
