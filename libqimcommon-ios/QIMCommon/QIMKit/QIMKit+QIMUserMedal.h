//
//  QIMKit+QIMUserMedal.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMUserMedal)

- (NSArray *)getLocalUserMedalWithXmppJid:(NSString *)xmppId;

- (void)getRemoteUserMedalWithXmppJid:(NSString *)xmppId;

/**
 修改勋章佩戴状态
 
 @param status 勋章佩戴状态
 @param medalId 勋章Id
 */
- (void)userMedalStatusModifyWithStatus:(NSInteger)status withMedalId:(NSInteger)medalId withCallBack:(QIMKitUpdateMedalStatusCallBack)callback;

#pragma mark - Local UserMedal

- (NSDictionary *)getUserMedalWithMedalId:(NSInteger)medalId withUserId:(NSString *)userId;

- (NSArray *)getUserWearMedalStatusByUserid:(NSString *)userId;

- (NSArray *)getUsersInMedal:(NSInteger)medalId withLimit:(NSInteger)limit withOffset:(NSInteger)offset;

- (NSArray *)getUserWearMedalSmallIconListByUserid:(NSString *)xmppId;

- (NSArray *)getUserHaveMedalSmallIconListByUserid:(NSString *)xmppId;

@end
