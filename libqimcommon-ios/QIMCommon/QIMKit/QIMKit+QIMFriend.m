//
//  QIMKit+QIMFriend.m
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMFriend.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMFriend)


- (NSMutableDictionary *)getFriendListDict {
    return [[STManager sharedInstance] getFriendListDict];
}


- (NSDictionary *)getVerifyFreindModeWithXmppId:(NSString *)xmppId {
    return [[STManager sharedInstance] getVerifyFreindModeWithXmppId:xmppId];
}

- (BOOL)setVerifyFreindMode:(int)mode WithQuestion:(NSString *)question WithAnswer:(NSString *)answer {
    
    return [[STManager sharedInstance] setVerifyFreindMode:mode WithQuestion:question WithAnswer:answer];
}

- (NSString *)getFriendsJson {
    return [[STManager sharedInstance] getFriendsJson];
}

- (void)updateFriendList {
    [[STManager sharedInstance] updateFriendList];
}

- (void)addFriendPresenceWithXmppId:(NSString *)xmppId WithAnswer:(NSString *)answer {
    [[STManager sharedInstance] addFriendPresenceWithXmppId:xmppId WithAnswer:answer];
}

- (void)validationFriendWithXmppId:(NSString *)xmppId WithReason:(NSString *)reason {
    [[STManager sharedInstance] validationFriendWithXmppId:xmppId WithReason:reason];
}

- (void)agreeFriendRequestWithXmppId:(NSString *)xmppId {
    [[STManager sharedInstance] agreeFriendRequestWithXmppId:xmppId];
}

- (void)refusedFriendRequestWithXmppId:(NSString *)xmppId {
    [[STManager sharedInstance] refusedFriendRequestWithXmppId:xmppId];
}

//1.删除好友,客户端请求，其中mode1为单项删除，mode为2为双项删除
- (BOOL)deleteFriendWithXmppId:(NSString *)xmppId WithMode:(int)mode {
    
    return [[STManager sharedInstance] deleteFriendWithXmppId:xmppId WithMode:mode];
}

- (int)getReceiveMsgLimitWithXmppId:(NSString *)xmppId {
    
    return [[STManager sharedInstance] getReceiveMsgLimitWithXmppId:xmppId];
}

- (BOOL)setReceiveMsgLimitWithMode:(int)mode {
    
    return [[STManager sharedInstance] setReceiveMsgLimitWithMode:mode];
}

- (void)updateFriendInviteList {
    
    [[STManager sharedInstance] updateFriendInviteList];
}

- (NSDictionary *)getLastFriendNotify {
    return [[STManager sharedInstance]  getLastFriendNotify];
}

- (NSInteger)getFriendNotifyCount {
    return [[STManager sharedInstance] getFriendNotifyCount];
}

@end
