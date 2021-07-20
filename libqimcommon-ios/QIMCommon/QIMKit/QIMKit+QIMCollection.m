//
//  QIMKit+QIMCollection.m
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMCollection.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMCollection)

- (NSString *)getCollectionUserHeaderUrlWithXmppId:(NSString *)userId {
    return [[STManager sharedInstance] getCollectionUserHeaderUrlWithXmppId:userId];
}

- (NSString *)getCollectionGroupHeaderUrlWithCollectionGroupId:(NSString *)groupId {
    return [[STManager sharedInstance] getCollectionGroupHeaderUrlWithCollectionGroupId:groupId];
}

- (NSDictionary *)getCollectionUserInfoByUserId:(NSString *)myId {
    
    return [[STManager sharedInstance] getCollectionUserInfoByUserId:myId];
}

- (void)updateCollectionUserCardByUserIds:(NSArray *)userIds {
    [[STManager sharedInstance] updateCollectionUserCardByUserIds:userIds];
}

- (void)saveCollectionMessage:(NSDictionary *)collectionMsgDic {
    [[STManager sharedInstance] saveCollectionMessage:collectionMsgDic];
}

- (STMsgModel *)getCollectionMsgListForMsgId:(NSString *)msgId {
    return [[STManager sharedInstance] getCollectionMsgListForMsgId:msgId];
}

- (NSArray *)getCollectionMsgListForUserId:(NSString *)userId originUserId:(NSString *)originUserId {

    return [[STManager sharedInstance] getCollectionMsgListForUserId:userId originUserId:originUserId];
}

- (NSDictionary *)getLastCollectionMsgByMsgId:(NSString *)lastMsgId {
    return [[STManager sharedInstance] getLastCollectionMsgByMsgId:lastMsgId];
}

- (NSArray *)getCollectionSessionListWithBindId:(NSString *)bindId {
    return [[STManager sharedInstance] getCollectionSessionListWithBindId:bindId];
}

- (NSArray *)getCollectionMsgListWithBindId:(NSString *)bindId {
    return [[STManager sharedInstance] getCollectionMsgListWithBindId:bindId];
}

- (NSArray *)getMyCollectionAccountList {
    return [[STManager sharedInstance] getMyCollectionAccountList];
}

- (void)getRemoteCollectionAccountList {
    [[STManager sharedInstance] getRemoteCollectionAccountList];
}

- (void)clearNotReadCollectionMsgByJid:(NSString *)jid {
    [[STManager sharedInstance] clearNotReadCollectionMsgByJid:jid];
}

- (void)clearNotReadCollectionMsgByBindId:(NSString *)bindId WithUserId:(NSString *)userId {
    [[STManager sharedInstance] clearNotReadCollectionMsgByBindId:bindId WithUserId:userId];
}

- (NSInteger)getNotReadCollectionMsgCount {
    return [[STManager sharedInstance] getNotReadCollectionMsgCount];
}

- (NSInteger)getNotReadCollectionMsgCountByBindId:(NSString *)bindId {
    return [[STManager sharedInstance] getNotReadCollectionMsgCountByBindId:bindId];
}

- (NSInteger)getNotReadCollectionMsgCountByBindId:(NSString *)bindId WithUserId:(NSString *)userId {
    return [[STManager sharedInstance] getNotReadCollectionMsgCountByBindId:bindId WithUserId:userId];
}

#pragma mark - 代收Group

- (NSDictionary *)getCollectionGroupCardByGroupId:(NSString *)groupId {
    return [[STManager sharedInstance] getCollectionGroupCardByGroupId:groupId];
}

- (void)updateCollectionGroupCardByGroupId:(NSString *)groupId {

    [[STManager sharedInstance] updateCollectionGroupCardByGroupId:groupId];
}

@end
