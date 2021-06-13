//
//  IMDataManager+QIMSession.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STDataMgr.h"
#import "IMDataManager+QIMCalendar.h"
#import "IMDataManager+WorkFeed.h"
#import "IMDataManager+QIMDBClientConfig.h"
#import "IMDataManager+QIMDBQuickReply.h"
#import "IMDataManager+QIMNote.h"
#import "IMDataManager+QIMDBGroup.h"
#import "IMDataManager+QIMDBFriend.h"
#import "IMDataManager+QIMDBMessage.h"
#import "IMDataManager+QIMDBCollectionMessage.h"
#import "IMDataManager+QIMDBPublicNumber.h"
#import "IMDataManager+QIMDBUser.h"
#import "IMDataManager+QIMUserMedal.h"
#import "IMDataManager+QIMFoundList.h"

@interface STDataMgr (QIMSession)

- (void)qimDB_updateSessionLastMsgIdWithSessionId:(NSString *)sessionId
                                    WithLastMsgId:(NSString *)lastMsgId;

- (long long)qimDB_insertSessionWithMsgList:(NSDictionary *)msgLists;

- (long long)qimDB_insertGroupSessionWithMsgList:(NSDictionary *)tempGroupDic;

- (void)qimDB_insertSessionWithSessionId:(NSString *)sessinId
                              WithUserId:(NSString *)userId
                           WithLastMsgId:(NSString *)lastMsgId
                      WithLastUpdateTime:(long long)lastUpdateTime
                                ChatType:(int)ChatType
                             WithRealJid:(id)realJid;

- (void)qimDB_deleteSession:(NSString *)xmppId RealJid:(NSString *)realJid;

- (void)qimDB_deleteSessionList:(NSArray *)xmppIds;

- (void)qimDB_deleteSession:(NSString *)xmppId;

- (NSDictionary *)qimDB_getLastedSingleChatSession;

- (NSArray *)qimDB_getFullSessionListWithSingleChatType:(int)singleChatType;

- (NSArray *)qimDB_getNotReadSessionList;

- (NSArray *)qimDB_getSessionListWithSingleChatType:(int)singleChatType;

- (NSArray *)qimDB_getSessionListXMPPIDWithSingleChatType:(int)singleChatType;

- (NSDictionary *)qimDB_getChatSessionWithUserId:(NSString *)userId chatType:(int)chatType;

- (NSDictionary *)qimDB_getChatSessionWithUserId:(NSString *)userId WithRealJid:(NSString *)realJid;

- (NSDictionary *)qimDB_getChatSessionWithUserId:(NSString *)userId;

- (NSInteger)qimDB_getAppNotReadCount;

@end
