//
//  QIMKit+QIMSession.m
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMSession.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMSession)

- (void)setCurrentSessionUserId:(NSString *)userId {
    [[STManager sharedInstance] setCurrentSessionUserId:userId];
}

- (NSString *)getCurrentSessionUserId {
    return [[STManager sharedInstance] getCurrentSessionUserId];
}

- (NSDictionary *)getLastedSingleChatSession {
    return nil;
}

- (NSArray *)getSessionList {
    
    return [[STManager sharedInstance] getSessionList];
}

- (NSArray *)getNotReadSessionList {
    return [[STManager sharedInstance] getNotReadSessionList];
}

- (void)deleteSessionList {
    [[STManager sharedInstance] deleteSessionList];
}

- (void)removeSessionById:(NSString *)sid {
    [[STManager sharedInstance] removeSessionById:sid];
}

- (void)removeConsultSessionById:(NSString *)sid RealId:(NSString *)realJid {
    [[STManager sharedInstance] removeConsultSessionById:sid RealId:realJid];
}

- (ChatType)getChatSessionTypeByXmppId:(NSString *)xmppId {
    return [[STManager sharedInstance] getChatSessionTypeByXmppId:xmppId];
}

- (ChatType)openChatSessionByUserId:(NSString *)userId {
    return [[STManager sharedInstance] openChatSessionByUserId:userId];
}

- (void)openGroupSessionByGroupId:(NSString *)groupId ByName:(NSString *)name {
    [[STManager sharedInstance] openGroupSessionByGroupId:groupId ByName:name];
}

- (void)openChatSessionByUserId:(NSString *)userId ByRealJid:(NSString *)realJid WithChatType:(ChatType)chatType{
    [[STManager sharedInstance] openChatSessionByUserId:userId ByRealJid:realJid WithChatType:chatType];
}

- (void)addConsultSessionById:(NSString *)sessionId ByRealJid:(NSString *)realJid WithUserId:(NSString *)userId ByMsgId:(NSString *)msgId WithOpen:(BOOL)open WithLastUpdateTime:(long long)lastUpdateTime WithChatType:(ChatType)chatType{
    [[STManager sharedInstance] addConsultSessionById:sessionId ByRealJid:realJid WithUserId:userId ByMsgId:msgId WithOpen:open WithLastUpdateTime:lastUpdateTime WithChatType:chatType];
}

- (void)addSessionByType:(ChatType)type ById:(NSString *)jid ByMsgId:(NSString *)msgId WithMsgTime:(long long)msgTime WithNeedUpdate:(BOOL)needUpdate {
    [[STManager sharedInstance] addSessionByType:type ById:jid ByMsgId:msgId WithMsgTime:msgTime WithNeedUpdate:needUpdate];
}

@end
