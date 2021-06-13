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
    return [[QIMManager sharedInstance] getCollectionUserHeaderUrlWithXmppId:userId];
}

- (NSString *)getCollectionGroupHeaderUrlWithCollectionGroupId:(NSString *)groupId {
    return [[QIMManager sharedInstance] getCollectionGroupHeaderUrlWithCollectionGroupId:groupId];
}

- (NSDictionary *)getCollectionUserInfoByUserId:(NSString *)myId {
    
    return [[QIMManager sharedInstance] getCollectionUserInfoByUserId:myId];
}

- (void)updateCollectionUserCardByUserIds:(NSArray *)userIds {
    [[QIMManager sharedInstance] updateCollectionUserCardByUserIds:userIds];
}

- (void)saveCollectionMessage:(NSDictionary *)collectionMsgDic {
    [[QIMManager sharedInstance] saveCollectionMessage:collectionMsgDic];
}

- (STMsgModel *)getCollectionMsgListForMsgId:(NSString *)msgId {
    return [[QIMManager sharedInstance] getCollectionMsgListForMsgId:msgId];
}

- (NSArray *)getCollectionMsgListForUserId:(NSString *)userId originUserId:(NSString *)originUserId {

    return [[QIMManager sharedInstance] getCollectionMsgListForUserId:userId originUserId:originUserId];
}

- (NSDictionary *)getLastCollectionMsgByMsgId:(NSString *)lastMsgId {
    return [[QIMManager sharedInstance] getLastCollectionMsgByMsgId:lastMsgId];
}

- (NSArray *)getCollectionSessionListWithBindId:(NSString *)bindId {
    return [[QIMManager sharedInstance] getCollectionSessionListWithBindId:bindId];
}

- (NSArray *)getCollectionMsgListWithBindId:(NSString *)bindId {
    return [[QIMManager sharedInstance] getCollectionMsgListWithBindId:bindId];
}

- (NSArray *)getMyCollectionAccountList {
    return [[QIMManager sharedInstance] getMyCollectionAccountList];
}

- (void)getRemoteCollectionAccountList {
    [[QIMManager sharedInstance] getRemoteCollectionAccountList];
}

- (void)clearNotReadCollectionMsgByJid:(NSString *)jid {
    [[QIMManager sharedInstance] clearNotReadCollectionMsgByJid:jid];
}

- (void)clearNotReadCollectionMsgByBindId:(NSString *)bindId WithUserId:(NSString *)userId {
    [[QIMManager sharedInstance] clearNotReadCollectionMsgByBindId:bindId WithUserId:userId];
}

- (NSInteger)getNotReadCollectionMsgCount {
    return [[QIMManager sharedInstance] getNotReadCollectionMsgCount];
}

- (NSInteger)getNotReadCollectionMsgCountByBindId:(NSString *)bindId {
    return [[QIMManager sharedInstance] getNotReadCollectionMsgCountByBindId:bindId];
}

- (NSInteger)getNotReadCollectionMsgCountByBindId:(NSString *)bindId WithUserId:(NSString *)userId {
    return [[QIMManager sharedInstance] getNotReadCollectionMsgCountByBindId:bindId WithUserId:userId];
}

#pragma mark - 代收Group

- (NSDictionary *)getCollectionGroupCardByGroupId:(NSString *)groupId {
    return [[QIMManager sharedInstance] getCollectionGroupCardByGroupId:groupId];
}

- (void)updateCollectionGroupCardByGroupId:(NSString *)groupId {

    [[QIMManager sharedInstance] updateCollectionGroupCardByGroupId:groupId];
}

@end
