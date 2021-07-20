//
//  QIMKit+QIMUserMedal.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//

#import "QIMKit+QIMUserMedal.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMUserMedal)

- (NSArray *)getLocalUserMedalWithXmppJid:(NSString *)xmppId {
    return [[STManager sharedInstance] getLocalUserMedalWithXmppJid:xmppId];
}

- (void)getRemoteUserMedalWithXmppJid:(NSString *)xmppId {
    [[STManager sharedInstance] getRemoteUserMedalWithXmppJid:xmppId];
}

/**
 修改勋章佩戴状态
 
 @param status 勋章佩戴状态
 @param medalId 勋章Id
 */
- (void)userMedalStatusModifyWithStatus:(NSInteger)status withMedalId:(NSInteger)medalId withCallBack:(QIMKitUpdateMedalStatusCallBack)callback {
    [[STManager sharedInstance] userMedalStatusModifyWithStatus:status withMedalId:medalId withCallBack:callback];
}

#pragma mark - Local UserMedal

- (NSDictionary *)getUserMedalWithMedalId:(NSInteger)medalId withUserId:(NSString *)userId {
    return [[STManager sharedInstance] getUserMedalWithMedalId:medalId withUserId:userId];
}

- (NSArray *)getUserWearMedalStatusByUserid:(NSString *)userId {
    return [[STManager sharedInstance] getUserWearMedalStatusByUserid:userId];
}

- (NSArray *)getUsersInMedal:(NSInteger)medalId withLimit:(NSInteger)limit withOffset:(NSInteger)offset {
    return [[STManager sharedInstance] getUsersInMedal:medalId withLimit:limit withOffset:offset];
}

- (NSArray *)getUserWearMedalSmallIconListByUserid:(NSString *)xmppId {
    return [[STManager sharedInstance] getUserWearMedalSmallIconListByUserid:xmppId];
}

- (NSArray *)getUserHaveMedalSmallIconListByUserid:(NSString *)xmppId {
    return [[STManager sharedInstance] getUserHaveMedalSmallIconListByUserid:xmppId];
}

@end
