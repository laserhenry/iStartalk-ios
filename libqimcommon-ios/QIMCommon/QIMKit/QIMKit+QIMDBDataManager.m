//
//  QIMKit+QIMDBDataManager.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMDBDataManager.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMDBDataManager)

+ (void) sharedInstanceWithDBPath:(NSString *)dbPath {
//    [IMDataManager qimDB_sharedInstanceWithDBPath:dbPath];
}

- (void)setDomain:(NSString*)domain {
//    [[IMDataManager qimDB_SharedInstance] setDomain:domain];
}

- (void)clearUserDescInfo {
//    [[IMDataManager qimDB_SharedInstance] clearUserDescInfo];
}

- (NSString *)getTimeSmtapMsgIdForDate:(NSDate *)date WithUserId:(NSString *)userId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getTimeSmtapMsgIdForDate:date WithUserId:userId];
}

// 群
- (NSInteger)getRNSearchEjabHost2GroupChatListByKeyStr:(NSString *)keyStr {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getRNSearchEjabHost2GroupChatListByKeyStr:keyStr];
}

- (NSArray *)rnSearchEjabHost2GroupChatListByKeyStr:(NSString *)keyStr limit:(NSInteger)limit offset:(NSInteger)offset {
    return [[STDataMgr qimDB_SharedInstance] qimDB_rnSearchEjabHost2GroupChatListByKeyStr:keyStr limit:limit offset:offset];
}

- (BOOL)checkGroup:(NSString *)groupId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_checkGroup:groupId];
}

- (void)insertGroup:(NSString *)groupId {
    [[STDataMgr qimDB_SharedInstance] qimDB_insertGroup:groupId];
}

- (void)bulkinsertGroups:(NSArray *) groups {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkinsertGroups:groups];
}

- (void) removeAllMessages {
//    [[IMDataManager qimDB_SharedInstance] qimDB_removeAllMessages];
}

- (void)clearGroupCardVersion {
//    [[IMDataManager qimDB_SharedInstance] qimDB_clearGroupCardVersion];
}

- (NSArray *)getGroupIdList {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getGroupIdList];
}

- (NSArray *)qimDB_getGroupList {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getGroupList];
}

- (NSInteger)getLocalGroupTotalCountByUserIds:(NSArray *)userIds {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getLocalGroupTotalCountByUserIds:userIds];
}

- (NSArray *)searchGroupByUserIds:(NSArray *)userIds WithLimit:(NSInteger)limit WithOffset:(NSInteger)offset {
    return [[STDataMgr qimDB_SharedInstance] qimDB_searchGroupByUserIds:userIds WithLimit:limit WithOffset:offset];
}

- (NSArray *)getGroupListMaxLastUpdateTime {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getGroupListMaxLastUpdateTime];
}

- (NSArray *)getGroupListMsgMaxTime {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getGroupListMsgMaxTime];
}

- (void)bulkUpdateGroupCards:(NSArray *)array {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkUpdateGroupCards:array];
}

- (void)updateGroup:(NSString *)groupId
       WithNickName:(NSString *)nickName
          WithTopic:(NSString *)topic
           WithDesc:(NSString *)desc
      WithHeaderSrc:(NSString *)headerSrc
        WithVersion:(NSString *)version {
    [[STDataMgr qimDB_SharedInstance] qimDB_updateGroup:groupId
                                  WithNickName:nickName
                                     WithTopic:topic
                                      WithDesc:desc
                                 WithHeaderSrc:headerSrc
                                   WithVersion:version];
}

- (void)updateGroup:(NSString *)groupId WithNickName:(NSString *)nickName {
    [[STDataMgr qimDB_SharedInstance] qimDB_updateGroup:groupId WithNickName:nickName];
}

- (void)updateGroup:(NSString *)groupId WithTopic:(NSString *)topic {
    [[STDataMgr qimDB_SharedInstance] qimDB_updateGroup:groupId WithTopic:topic];
}

- (void)updateGroup:(NSString *)groupId WithDesc:(NSString *)desc {
    [[STDataMgr qimDB_SharedInstance] qimDB_updateGroup:groupId WithDesc:desc];
}

- (void)updateGroup:(NSString *)groupId WithHeaderSrc:(NSString *)headerSrc {
    [[STDataMgr qimDB_SharedInstance] qimDB_updateGroup:groupId WithHeaderSrc:headerSrc];
}

- (BOOL)needUpdateGroupImage:(NSString *)groupId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_needUpdateGroupImage:groupId];
}

- (NSString *)getGroupHeaderSrc:(NSString *)groupId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getGroupHeaderSrc:groupId];
}

- (void)deleteGroup:(NSString *)groupId {
    [[STDataMgr qimDB_SharedInstance] qimDB_deleteGroup:groupId];
}

- (NSDictionary *)getGroupMemberInfoByNickName:(NSString *)nickName {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getGroupMemberInfoByNickName:nickName];
}

- (NSDictionary *)getGroupMemberInfoByJid:(NSString *)jid WithGroupId:(NSString *)groupId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getGroupMemberInfoByJid:jid WithGroupId:groupId];
}

- (BOOL)checkGroupMember:(NSString *)nickName WithGroupId:(NSString *)groupId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_checkGroupMember:nickName WithGroupId:groupId];
}

- (void)insertGroupMember:(NSDictionary *)memberDic WithGroupId:(NSString *)groupId {
    [[STDataMgr qimDB_SharedInstance] qimDB_insertGroupMember:memberDic WithGroupId:groupId];
}

- (void)bulkInsertGroupMember:(NSArray *)members WithGroupId:(NSString *)groupId {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkInsertGroupMember:members WithGroupId:groupId];
}

- (NSArray *)getQChatGroupMember:(NSString *)groupId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getQChatGroupMember:groupId];
}

- (NSArray *)getQChatGroupMember:(NSString *)groupId BySearchStr:(NSString *)searchStr {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getQChatGroupMember:groupId BySearchStr:searchStr];
}

- (NSArray *)qimDB_getGroupMember:(NSString *)groupId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getGroupMember:groupId];
}

- (NSArray *)qimDB_getGroupMember:(NSString *)groupId BySearchStr:(NSString *)searchStr {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getGroupMember:groupId BySearchStr:searchStr];
}

- (NSArray *)qimDB_getGroupMember:(NSString *)groupId WithGroupIdentity:(NSInteger)identity {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getGroupMember:groupId WithGroupIdentity:identity];
}

- (NSDictionary *)getGroupOwnerInfoForGroupId:(NSString *)groupId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getGroupOwnerInfoForGroupId:groupId];
}

- (void)deleteGroupMemberWithGroupId:(NSString *)groupId {
    [[STDataMgr qimDB_SharedInstance] qimDB_deleteGroupMemberWithGroupId:groupId];
}

- (void)deleteGroupMemberJid:(NSString *)memberJid WithGroupId:(NSString *)groupId {
    [[STDataMgr qimDB_SharedInstance] qimDB_deleteGroupMemberJid:memberJid WithGroupId:groupId];
}

- (void)deleteGroupMember:(NSString *)nickname WithGroupId:(NSString *)groupId {
    [[STDataMgr qimDB_SharedInstance] qimDB_deleteGroupMember:nickname WithGroupId:groupId];
}

- (NSDictionary *)getChatSessionWithUserId:(NSString *)userId chatType:(int)chatType {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getChatSessionWithUserId:userId chatType:chatType];
}

- (long long)getMinMsgTimeStampByXmppId:(NSString *)xmppId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getMinMsgTimeStampByXmppId:xmppId];
}

- (long long)getMaxMsgTimeStampByXmppId:(NSString *)xmppId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getMaxMsgTimeStampByXmppId:xmppId];
}

- (long long) lastestGroupMessageTime {
    return [[STDataMgr qimDB_SharedInstance] qimDB_lastestGroupMessageTime];
}

- (void)bulkInsertUserInfosNotSaveDescInfo:(NSArray *)userInfos {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkInsertUserInfosNotSaveDescInfo:userInfos];
}

- (void)clearUserListForList:(NSArray *)userInfos {
    [[STDataMgr qimDB_SharedInstance] qimDB_clearUserListForList:userInfos];
}

- (void)bulkInsertUserInfos:(NSArray *)userInfos {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkInsertUserInfos:userInfos];
}

- (void)InsertOrUpdateUserInfos:(NSArray *)userInfos {
    [[STDataMgr qimDB_SharedInstance] qimDB_InsertOrUpdateUserInfos:userInfos];
}

- (NSDictionary *)selectUserBackInfoByXmppId:(NSString *)xmppId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectUserBackInfoByXmppId:xmppId];
}

- (NSDictionary *)selectUserByID:(NSString *)userId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectUserByID:userId];
}

- (NSDictionary *)selectUserByJID:(NSString *)jid {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectUserByJID:jid];
}

- (NSDictionary *)selectUserByIndex:(NSString *)index {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectUserByIndex:index];
}

- (NSArray *)selectXmppIdList {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectXmppIdList];
}

- (NSArray *)selectUserIdList {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectUserIdList];
}

- (NSArray *)getOrganUserList {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getOrganUserList];
}

- (NSArray *)selectUserListBySearchStr:(NSString *)searchStr {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectUserListBySearchStr:searchStr];
}

- (NSInteger)selectUserListTotalCountBySearchStr:(NSString *)searchStr {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectUserListTotalCountBySearchStr:searchStr];
}

- (NSArray *)selectUserListExMySelfBySearchStr:(NSString *)searchStr WithLimit:(NSInteger)limit WithOffset:(NSInteger)offset {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectUserListExMySelfBySearchStr:searchStr WithLimit:limit WithOffset:offset];
}

- (NSArray *)selectUserListBySearchStr:(NSString *)searchStr WithLimit:(NSInteger)limit WithOffset:(NSInteger)offset {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectUserListBySearchStr:searchStr WithLimit:limit WithOffset:offset];
}

- (NSArray *)selectUserListBySearchStr:(NSString *)searchStr inGroup:(NSString *) groupId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectUserListBySearchStr:searchStr inGroup:groupId];
}

- (NSArray *)selectUserListByUserIds:(NSArray *)userIds {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectUserListByUserIds:userIds];
}

- (NSDictionary *)selectUsersDicByXmppIds:(NSArray *)xmppIds {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectUsersDicByXmppIds:xmppIds];
}

- (void)bulkUpdateUserSearchIndexs:(NSArray *)searchIndexs {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkUpdateUserSearchIndexs:searchIndexs];
}

- (void)updateUser:(NSString *)userId WithMood:(NSString *)mood WithHeaderSrc:(NSString *)headerSrc WithVersion:(NSString *)version{
    [[STDataMgr qimDB_SharedInstance] qimDB_updateUser:userId WithMood:mood WithHeaderSrc:headerSrc WithVersion:version];
}

- (void)bulkUpdateUserCardsV2:(NSArray *)cards {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkUpdateUserCards:cards];
}

- (void)bulkUpdateUserBackInfo:(NSDictionary *)userBackInfo WithXmppId:(NSString *)xmppId {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkUpdateUserBackInfo:userBackInfo WithXmppId:xmppId];
}

- (NSString *)getUserHeaderSrcByUserId:(NSString *)userId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getUserHeaderSrcByUserId:userId];
}

- (BOOL)checkExitsUser {
    return [[STDataMgr qimDB_SharedInstance] qimDB_checkExitsUser];
}

- (void)updateMessageWithExtendInfo:(NSString *)extendInfo ForMsgId:(NSString *)msgId {
    [[STDataMgr qimDB_SharedInstance] qimDB_updateMessageWithExtendInfo:extendInfo ForMsgId:msgId];
}

- (void)deleteMessageWithXmppId:(NSString *)xmppId {
    [[STDataMgr qimDB_SharedInstance] qimDB_deleteMessageWithXmppId:xmppId];
}

- (void)deleteMessageByMessageId:(NSString *)messageId ByJid:(NSString *)sid {
    [[STDataMgr qimDB_SharedInstance] qimDB_deleteMessageByMessageId:messageId ByJid:sid];
}

- (void)updateMessageWithMsgId:(NSString *)msgId
                    WithMsgRaw:(NSString *)msgRaw {
    [[STDataMgr qimDB_SharedInstance] qimDB_updateMessageWithMsgId:msgId
                                               WithMsgRaw:msgRaw];
}

- (void)updateMessageWithMsgId:(NSString *)msgId
                 WithSessionId:(NSString *)sessionId
                      WithFrom:(NSString *)from
                        WithTo:(NSString *)to
                   WithContent:(NSString *)content
                  WithPlatform:(int)platform
                   WithMsgType:(int)msgType
                  WithMsgState:(int)msgState
              WithMsgDirection:(int)msgDirection
                   WithMsgDate:(long long)msgDate
                 WithReadedTag:(int)readedTag
                  ExtendedFlag:(int)ExtendedFlag {
    [[STDataMgr qimDB_SharedInstance] qimDB_updateMessageWithMsgId:msgId
                                            WithSessionId:sessionId
                                                 WithFrom:from
                                                   WithTo:to
                                              WithContent:content
                                             WithPlatform:platform
                                              WithMsgType:msgType
                                             WithMsgState:msgState
                                         WithMsgDirection:msgDirection
                                              WithMsgDate:msgDate
                                            WithReadedTag:readedTag
                                             ExtendedFlag:ExtendedFlag];
}

- (void)updateMessageWithMsgId:(NSString *)msgId
                 WithSessionId:(NSString *)sessionId
                      WithFrom:(NSString *)from
                        WithTo:(NSString *)to
                   WithContent:(NSString *)content
                WithExtendInfo:(NSString *)extendInfo
                  WithPlatform:(int)platform
                   WithMsgType:(int)msgType
                  WithMsgState:(int)msgState
              WithMsgDirection:(int)msgDirection
                   WithMsgDate:(long long)msgDate
                 WithReadedTag:(int)readedTag
                  ExtendedFlag:(int)ExtendedFlag
                    WithMsgRaw:(NSString *)msgRaw {
    [[STDataMgr qimDB_SharedInstance] qimDB_updateMessageWithMsgId:msgId
                                            WithSessionId:sessionId
                                                 WithFrom:from
                                                   WithTo:to
                                              WithContent:content
                                            WithExtendInfo:extendInfo
                                             WithPlatform:platform
                                              WithMsgType:msgType
                                             WithMsgState:msgState
                                         WithMsgDirection:msgDirection
                                              WithMsgDate:msgDate
                                            WithReadedTag:readedTag
                                             ExtendedFlag:ExtendedFlag
                                               WithMsgRaw:msgRaw];
}

- (void)revokeMessageByMsgId:(NSString *)msgId
                 WithContent:(NSString *)content
                 WithMsgType:(int)msgType {
    [[STDataMgr qimDB_SharedInstance] qimDB_revokeMessageByMsgId:msgId
                                            WithContent:content
                                            WithMsgType:msgType];
}

- (BOOL)qimDB_checkMsgId:(NSString *)msgId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_checkMsgId:msgId];
}
//
//- (NSArray *)bulkInsertIphoneMucJSONMsg:(NSArray *)list WithMyNickName:(NSString *)myNickName WithReadMarkT:(long long)readMarkT WithDidReadState:(int)didReadState WithMyRtxId:(NSString *)rtxId {
//    return [[IMDataManager qimDB_SharedInstance] qimDB_bulkInsertIphoneMucJSONMsg:list
//                                                       WithMyNickName:myNickName
//                                                        WithReadMarkT:readMarkT
//                                                     WithDidReadState:didReadState
//                                                          WithMyRtxId:rtxId];
//
//}

- (NSArray *)bulkInsertIphoneHistoryGroupMsg:(NSArray *)list WithXmppId:(NSString *)xmppId WithMyNickName:(NSString *)myNickName WithReadMarkT:(long long)readMarkT WithDidReadState:(int)didReadState WithMyRtxId:(NSString *)rtxId {
    return nil;
//    return [[IMDataManager qimDB_SharedInstance] qimDB_bulkInsertIphoneHistoryGroupMsg:list WithXmppId:xmppId WithMyNickName:myNickName WithReadMarkT:readMarkT WithDidReadState:didReadState WithMyRtxId:rtxId];
}

- (NSArray *)bulkInsertHistoryGroupMsg:(NSArray *)list WithXmppId:(NSString *)xmppId WithMyNickName:(NSString *)myNickName WithReadMarkT:(long long)readMarkT WithDidReadState:(int)didReadState {
    return nil;
//    return [[IMDataManager qimDB_SharedInstance] qimDB_bulkInsertHistoryGroupMsg:list WithXmppId:xmppId WithMyNickName:myNickName WithReadMarkT:readMarkT WithDidReadState:didReadState];
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    return [[STDataMgr qimDB_SharedInstance] dictionaryWithJsonString:jsonString];
}

//- (NSMutableDictionary *)bulkInsertHistoryChatJSONMsg:(NSArray *)list {
//    return [[IMDataManager qimDB_SharedInstance] qimDB_bulkInsertHistoryChatJSONMsg:list];
//}

- (NSString *)getC2BMessageFeedBackWithMsgId:(NSString *)msgId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getC2BMessageFeedBackWithMsgId:msgId];
}

- (NSArray *)qimDB_bulkInsertPageHistoryChatJSONMsg:(NSArray *)list
                                         WithXmppId:(NSString *)xmppId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_bulkInsertPageHistoryChatJSONMsg:list
                                                                             WithXmppId:xmppId];
}

- (void)bulkInsertMessage:(NSArray *)msgList WithSessionId:(NSString *)sessionId {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkInsertMessage:msgList WithSessionId:sessionId];
}

- (void)updateMsgState:(int)msgState WithMsgId:(NSString *)msgId {
    [[STDataMgr qimDB_SharedInstance] qimDB_updateMsgState:msgState WithMsgId:msgId];
}

- (void)updateMessageReadStateWithMsgId:(NSString *)msgId {
    [[STDataMgr qimDB_SharedInstance] qimDB_updateMessageReadStateWithMsgId:msgId];
}

- (void)bulkUpdateMessageReadStateWithMsg:(NSArray *)msgs {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkUpdateMessageReadStateWithMsg:msgs];
}

- (void)updateMessageReadStateWithSessionId:(NSString *)sessionId {
//    [[IMDataManager qimDB_SharedInstance] qimDB_updateMessageReadStateWithSessionId:sessionId];
}

- (void)updateSessionLastMsgIdWithSessionId:(NSString *)sessionId
                              WithLastMsgId:(NSString *)lastMsgId {
    [[STDataMgr qimDB_SharedInstance] qimDB_updateSessionLastMsgIdWithSessionId:sessionId
                                                         WithLastMsgId:lastMsgId];
}

- (void)insertSessionWithSessionId:(NSString *)sessinId
                        WithUserId:(NSString *)userId
                     WithLastMsgId:(NSString *)lastMsgId
                WithLastUpdateTime:(long long)lastUpdateTime
                          ChatType:(int)ChatType
                       WithRealJid:(id)realJid {
    [[STDataMgr qimDB_SharedInstance] qimDB_insertSessionWithSessionId:sessinId
                                                   WithUserId:userId
                                                WithLastMsgId:lastMsgId
                                           WithLastUpdateTime:lastUpdateTime
                                                     ChatType:ChatType
                                                  WithRealJid:realJid];
}

- (void)deleteSession:(NSString *)xmppId RealJid:(NSString *)realJid {
    [[STDataMgr qimDB_SharedInstance] qimDB_deleteSession:xmppId RealJid:realJid];
}

- (void)deleteSession:(NSString *)xmppId {
    [[STDataMgr qimDB_SharedInstance] qimDB_deleteSession:xmppId];
}

- (NSDictionary *)getLastedSingleChatSession {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getLastedSingleChatSession];
}

- (NSDictionary *)qimDb_getPublicNumberSession {
    return nil;
//    return [[IMDataManager qimDB_SharedInstance] qimDb_getPublicNumberSession];
}

- (NSArray *)qimDB_getSessionListWithSingleChatType:(int)chatType {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getSessionListWithSingleChatType:chatType];
}

- (NSArray *)getSessionListXMPPIDWithSingleChatType:(int)singleChatType {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getSessionListXMPPIDWithSingleChatType:singleChatType];
}

- (NSArray *)qimDB_getNotReadMsgListForUserId:(NSString *)userId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getNotReadMsgListForUserId:userId];
}

- (NSArray *)qimDB_getNotReadMsgListForUserId:(NSString *)userId ForRealJid:(NSString *)realJid {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getNotReadMsgListForUserId:userId ForRealJid:realJid];
}

- (long long)getReadedTimeStampForUserId:(NSString *)userId WithRealJid:(NSString *)realJid WithMsgDirection:(int)msgDirection withUnReadCount:(NSInteger)unReadCount {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getReadedTimeStampForUserId:userId WithRealJid:realJid WithMsgDirection:msgDirection withUnReadCount:unReadCount];
}

- (NSArray *)qimDB_getMgsListBySessionId:(NSString *)sesId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getMgsListBySessionId:sesId];
}

- (NSArray *)qimDB_getMgsListBySessionId:(NSString *)sesId WithRealJid:(NSString *)realJid WithLimit:(int)limit WithOffset:(int)offset {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getMgsListBySessionId:sesId WithRealJid:realJid WithLimit:limit WithOffset:offset];
}

- (NSArray *)getMsgListByXmppId:(NSString *)xmppId WithRealJid:(NSString *)realJid FromTimeStamp:(long long)timeStamp {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getMsgListByXmppId:xmppId WithRealJid:realJid FromTimeStamp:timeStamp];
}

- (NSArray *)getMsgListByXmppId:(NSString *)xmppId FromTimeStamp:(long long)timeStamp {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getMsgListByXmppId:xmppId FromTimeStamp:timeStamp];
}

- (NSDictionary *)getMsgsByMsgId:(NSString *)msgId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getMsgsByMsgId:msgId];
}

- (NSDictionary *)getChatSessionWithUserId:(NSString *)userId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getChatSessionWithUserId:userId];
}

- (void)updateMessageFromState:(int)fState ToState:(int)tState {
    return [[STDataMgr qimDB_SharedInstance] qimDB_updateMessageFromState:fState ToState:tState];
}

- (NSInteger)getMessageStateWithMsgId:(NSString *)msgId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getMessageStateWithMsgId:msgId];
}

- (NSInteger)getReadStateWithMsgId:(NSString *)msgId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getReadStateWithMsgId:msgId];
}

- (NSArray *)getMsgIdsForDirection:(int)msgDirection WithMsgState:(int)msgState {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getMsgIdsForDirection:msgDirection WithMsgState:msgState];
}

- (NSArray *)searchMsgHistoryWithKey:(NSString *)key {
    return [[STDataMgr qimDB_SharedInstance] qimDB_searchMsgHistoryWithKey:key];
}

- (NSArray *)searchMsgIdWithKey:(NSString *)key ByXmppId:(NSString *)xmppId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_searchMsgIdWithKey:key ByXmppId:xmppId];
}

#pragma mark - 消息数据方法

- (long long) lastestMessageTime {
    return [[STDataMgr qimDB_SharedInstance] qimDB_lastestMessageTime];
}

- (long long) lastestSystemMessageTime {
    return [[STDataMgr qimDB_SharedInstance] qimDB_lastestSystemMessageTime];
}

- (NSString *) getLastMsgIdByJid:(NSString *)jid {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getLastMsgIdByJid:jid];
}

/****************** FriendSter Msg *******************/
- (void)insertFSMsgWithMsgId:(NSString *)msgId
                  WithXmppId:(NSString *)xmppId
                WithFromUser:(NSString *)fromUser
              WithReplyMsgId:(NSString *)replyMsgId
               WithReplyUser:(NSString *)replyUser
                 WithContent:(NSString *)content
                 WithMsgDate:(long long)msgDate
            WithExtendedFlag:(NSData *)etxtenedFlag {
//    [[IMDataManager qimDB_SharedInstance] qimDB_insertFSMsgWithMsgId:msgId
//                                             WithXmppId:xmppId
//                                           WithFromUser:fromUser
//                                         WithReplyMsgId:replyMsgId
//                                          WithReplyUser:replyUser
//                                            WithContent:content
//                                            WithMsgDate:msgDate
//                                       WithExtendedFlag:etxtenedFlag];
}

- (void)bulkInsertFSMsgWithMsgList:(NSArray *)msgList {
//    [[IMDataManager qimDB_SharedInstance] qimDB_bulkInsertFSMsgWithMsgList:msgList];
}

- (NSArray *)getFSMsgListByXmppId:(NSString *)xmppId {
    return nil;
//    return [[IMDataManager qimDB_SharedInstance] qimDB_getFSMsgListByXmppId:xmppId];
}

- (NSDictionary *)getFSMsgListByReplyMsgId:(NSString *)replyMsgId {
    return nil;
//    return [[IMDataManager qimDB_SharedInstance] qimDB_getFSMsgListByReplyMsgId:replyMsgId];
}

/****************** readmark *********************/
- (long long)qimDB_updateGroupMsgWithMsgState:(int)msgState ByGroupMsgList:(NSArray *)groupMsgList {
    return 0;
//    return [[IMDataManager qimDB_SharedInstance] qimDB_updateGroupMsgWithMsgState:msgState ByGroupMsgList:groupMsgList];
}

- (void)updateUserMsgWithMsgState:(int)msgState ByMsgList:(NSArray *)userMsgList {
//    [[IMDataManager qimDB_SharedInstance] qimDB_updateUserMsgWithMsgState:msgState ByMsgList:userMsgList];
}

- (void)clearHistoryMsg {
    [[STDataMgr qimDB_SharedInstance] qimDB_clearHistoryMsg];
}

- (void)closeDataBase {
    [[STDataMgr qimDB_SharedInstance] qimDB_closeDataBase];
}

+ (void)clearDataBaseCache {
//    [IMDataManager clearDataBaseCache];
}

- (void)qimDB_dbCheckpoint {
    [[STDataMgr qimDB_SharedInstance] qimDB_dbCheckpoint];
}

/*************** Friend List *************/
- (void)bulkInsertFriendList:(NSArray *)friendList {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkInsertFriendList:friendList];
}
- (void)insertFriendWithUserId:(NSString *)userId
                    WithXmppId:(NSString *)xmppId
                      WithName:(NSString *)name
               WithSearchIndex:(NSString *)searchIndex
                  WithDescInfo:(NSString *)descInfo
                   WithHeadSrc:(NSString *)headerSrc
                  WithUserInfo:(NSData *)userInfo
            WithLastUpdateTime:(long long)lastUpdateTime
          WithIncrementVersion:(int)incrementVersion {
    [[STDataMgr qimDB_SharedInstance] qimDB_insertFriendWithUserId:userId
                                               WithXmppId:xmppId
                                                 WithName:name
                                          WithSearchIndex:searchIndex
                                             WithDescInfo:descInfo
                                              WithHeadSrc:headerSrc
                                             WithUserInfo:userInfo
                                       WithLastUpdateTime:lastUpdateTime
                                     WithIncrementVersion:incrementVersion];
}

- (void)deleteFriendListWithXmppId:(NSString *)xmppId {
    [[STDataMgr qimDB_SharedInstance] qimDB_deleteFriendListWithXmppId:xmppId];
}

- (void)deleteFriendListWithUserId:(NSString *)userId {
    [[STDataMgr qimDB_SharedInstance] qimDB_deleteFriendListWithUserId:userId];
}

- (void)deleteFriendList {
    [[STDataMgr qimDB_SharedInstance] qimDB_deleteFriendList];
}
- (void)deleteSessionList {
    [[STDataMgr qimDB_SharedInstance] qimDB_deleteSessionList];
}

- (NSMutableArray *)selectFriendList {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectFriendList];
}

- (NSMutableArray *)qimDB_selectFriendListInGroupId:(NSString *)groupId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectFriendListInGroupId:groupId];
}

- (NSDictionary *)selectFriendInfoWithUserId:(NSString *)userId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectFriendInfoWithUserId:userId];
}
- (NSDictionary *)selectFriendInfoWithXmppId:(NSString *)xmppId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectFriendInfoWithXmppId:xmppId];
}

- (void)bulkInsertFriendNotifyList:(NSArray *)notifyList {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkInsertFriendNotifyList:notifyList];
}

- (void)insertFriendNotifyWithUserId:(NSString *)userId
                          WithXmppId:(NSString *)xmppId
                            WithName:(NSString *)name
                        WithDescInfo:(NSString *)descInfo
                         WithHeadSrc:(NSString *)headerSrc
                     WithSearchIndex:(NSString *)searchIndex
                        WithUserInfo:(NSString *)userInfo
                         WithVersion:(int)version
                           WithState:(int)state
                  WithLastUpdateTime:(long long)lastUpdateTime {
    [[STDataMgr qimDB_SharedInstance] qimDB_insertFriendNotifyWithUserId:userId
                                                     WithXmppId:xmppId
                                                       WithName:name
                                                   WithDescInfo:descInfo
                                                    WithHeadSrc:headerSrc
                                                WithSearchIndex:searchIndex
                                                   WithUserInfo:userInfo
                                                    WithVersion:version
                                                      WithState:state
                                             WithLastUpdateTime:lastUpdateTime];
    
}
- (void)deleteFriendNotifyWithUserId:(NSString *)userId {
    [[STDataMgr qimDB_SharedInstance] qimDB_deleteFriendNotifyWithUserId:userId];
}

- (NSMutableArray *)selectFriendNotifys {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectFriendNotifys];
}

- (void)updateFriendNotifyWithXmppId:(NSString *)xmppId WithState:(int)state {
    [[STDataMgr qimDB_SharedInstance] qimDB_updateFriendNotifyWithXmppId:xmppId WithState:state];
}

- (void)updateFriendNotifyWithUserId:(NSString *)userId WithState:(int)state {
//    [[IMDataManager qimDB_SharedInstance] qimDB_updateFriendNotifyWithUserId:userId WithState:state];
}

- (long long)getMaxTimeFriendNotify {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getMaxTimeFriendNotify];
}

// ******************** 公众账号 ***************************** //
- (BOOL)checkPublicNumberMsgById:(NSString *)msgId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_checkPublicNumberMsgById:msgId];
}

- (void)checkPublicNumbers:(NSArray *)publicNumberIds {
    [[STDataMgr qimDB_SharedInstance] qimDB_checkPublicNumbers:publicNumberIds];
}

- (void)bulkInsertPublicNumbers:(NSArray *)publicNumberList {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkInsertPublicNumbers:publicNumberList];
}

- (void)insertPublicNumberXmppId:(NSString *)xmppId
              WithPublicNumberId:(NSString *)publicNumberId
            WithPublicNumberType:(int)publicNumberType
                        WithName:(NSString *)name
                   WithHeaderSrc:(NSString *)headerSrc
                    WithDescInfo:(NSString *)descInfo
                 WithSearchIndex:(NSString *)searchIndex
                  WithPublicInfo:(NSString *)publicInfo
                     WithVersion:(int)version {
    [[STDataMgr qimDB_SharedInstance] qimDB_insertPublicNumberXmppId:xmppId
                                         WithPublicNumberId:publicNumberId
                                       WithPublicNumberType:publicNumberType
                                                   WithName:name
                                              WithHeaderSrc:headerSrc
                                               WithDescInfo:descInfo
                                            WithSearchIndex:searchIndex
                                             WithPublicInfo:publicInfo
                                                WithVersion:version];
}

- (void)deletePublicNumberId:(NSString *)publicNumberId {
    [[STDataMgr qimDB_SharedInstance] qimDB_deletePublicNumberId:publicNumberId];
}

- (NSArray *)getPublicNumberVersionList {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getPublicNumberVersionList];
}

- (NSArray *)getPublicNumberList {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getPublicNumberList];
}

- (NSArray *)searchPublicNumberListByKeyStr:(NSString *)keyStr {
    return [[STDataMgr qimDB_SharedInstance] qimDB_searchPublicNumberListByKeyStr:keyStr];
}

- (NSInteger)getRnSearchPublicNumberListByKeyStr:(NSString *)keyStr {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getRnSearchPublicNumberListByKeyStr:keyStr];
}

- (NSArray *)rnSearchPublicNumberListByKeyStr:(NSString *)keyStr limit:(NSInteger)limit offset:(NSInteger)offset {
    return [[STDataMgr qimDB_SharedInstance] qimDB_rnSearchPublicNumberListByKeyStr:keyStr limit:limit offset:offset];
}

- (NSDictionary *)getPublicNumberCardByJId:(NSString *)jid {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getPublicNumberCardByJId:jid];
}

- (void)insetPublicNumberMsgWithMsgId:(NSString *)msgId
                        WithSessionId:(NSString *)sessionId
                             WithFrom:(NSString *)from
                               WithTo:(NSString *)to
                          WithContent:(NSString *)content
                         WithPlatform:(int)platform
                          WithMsgType:(int)msgType
                         WithMsgState:(int)msgState
                     WithMsgDirection:(int)msgDirection
                          WithMsgDate:(long long)msgDate
                        WithReadedTag:(int)readedTag {
    [[STDataMgr qimDB_SharedInstance] qimDB_insetPublicNumberMsgWithMsgId:msgId
                                                   WithSessionId:sessionId
                                                        WithFrom:from
                                                          WithTo:to
                                                     WithContent:content
                                                    WithPlatform:platform
                                                     WithMsgType:msgType
                                                    WithMsgState:msgState
                                                WithMsgDirection:msgDirection
                                                     WithMsgDate:msgDate
                                                   WithReadedTag:readedTag];
}

- (NSArray *)getMsgListByPublicNumberId:(NSString *)publicNumberId
                              WithLimit:(int)limit
                             WithOffset:(int)offset
                         WithFilterType:(NSArray *)actionTypes {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getMsgListByPublicNumberId:publicNumberId WithLimit:limit WithOffset:offset WithFilterType:actionTypes];
}

/****************** Collection Msg *******************/

- (NSArray *)getCollectionAccountList {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getCollectionAccountList];
}

- (void)bulkinsertCollectionAccountList:(NSArray *)accounts {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkinsertCollectionAccountList:accounts];
}


- (NSDictionary *)selectCollectionUserByJID:(NSString *)jid {
    return [[STDataMgr qimDB_SharedInstance] qimDB_selectCollectionUserByJID:jid];
}

- (void)bulkInsertCollectionUserCards:(NSArray *)userCards {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkInsertCollectionUserCards:userCards];
}

- (void)bulkInsertCollectionGroupCards:(NSArray *)groupCards {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkInsertCollectionGroupCards:groupCards];
}

- (NSDictionary *)getLastCollectionMsgWithLastMsgId:(NSString *)lastMsgId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getLastCollectionMsgWithLastMsgId:lastMsgId];;
}

- (NSArray *)getCollectionSessionListWithBindId:(NSString *)bindId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getCollectionSessionListWithBindId:bindId];
}

- (NSArray *)getCollectionMsgListWithBindId:(NSString *)bindId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getCollectionMsgListWithBindId:bindId];
}

- (BOOL)checkCollectionMsgById:(NSString *)msgId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_checkCollectionMsgById:msgId];
}

- (void)bulkInsertCollectionMsgWithMsgDics:(NSArray *)msgs {
    [[STDataMgr qimDB_SharedInstance] qimDB_bulkInsertCollectionMsgWithMsgDics:msgs];
}

- (NSInteger)getCollectionMsgNotReadCountByDidReadState:(NSInteger)readState {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getCollectionMsgNotReadCountByDidReadState:readState];
}

- (NSInteger)getCollectionMsgNotReadCountByDidReadState:(NSInteger)readState ForBindId:(NSString *)bindId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getCollectionMsgNotReadCountByDidReadState:readState ForBindId:bindId];
}

- (NSInteger)getCollectionMsgNotReadCountgetCollectionMsgNotReadCountByDidReadState:(NSInteger)readState ForBindId:(NSString *)bindId originUserId:(NSString *)originUserId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getCollectionMsgNotReadCountgetCollectionMsgNotReadCountByDidReadState:readState ForBindId:bindId originUserId:originUserId];
}

- (void)updateCollectionMsgNotReadStateByJid:(NSString *)jid WithReadtate:(NSInteger)readState {
    [[STDataMgr qimDB_SharedInstance] qimDB_updateCollectionMsgNotReadStateByJid:jid WithReadtate:(NSInteger)readState];
//    [[IMDataManager qimDB_SharedInstance] qimDB_updateCollectionMsgNotReadStateByJid:jid WithMsgState:msgState];
}

- (void)updateCollectionMsgNotReadStateForBindId:(NSString *)bindId originUserId:(NSString *)originUserId WithReadState:(NSInteger)readState{
    [[STDataMgr qimDB_SharedInstance] qimDB_updateCollectionMsgNotReadStateForBindId:bindId originUserId:originUserId WithReadState:readState];

//    [[IMDataManager qimDB_SharedInstance] qimDB_updateCollectionMsgNotReadStateForBindId:bindId originUserId:originUserId WithMsgState:msgState];
}

- (NSDictionary *)getCollectionMsgListForMsgId:(NSString *)msgId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getCollectionMsgListForMsgId:msgId];
}

- (NSArray *)getCollectionMsgListWithUserId:(NSString *)userId originUserId:(NSString *)originUserId {
    return [[STDataMgr qimDB_SharedInstance] qimDB_getCollectionMsgListWithUserId:userId originUserId:originUserId];
}

/*********************** Group Message State **************************/
- (long long)qimDB_bulkUpdateGroupMessageReadFlag:(NSArray *)mucArray {
    return [[STDataMgr qimDB_SharedInstance] qimDB_bulkUpdateGroupMessageReadFlag:mucArray];
}

/*********************** QTNotes **********************/

//Main

- (BOOL)checkExitsMainItemWithQid:(NSInteger)qid WithCId:(NSInteger)cid {
    return [[STDataMgr qimDB_SharedInstance] checkExitsMainItemWithQid:qid WithCId:cid];
}

- (void)insertQTNotesMainItemWithQId:(NSInteger)qid
                             WithCid:(NSInteger)cid
                           WithQType:(NSInteger)qtype
                          WithQTitle:(NSString *)qtitle
                      WithQIntroduce:(NSString *)qIntroduce
                        WithQContent:(NSString *)qContent
                           WithQTime:(NSInteger)qTime
                          WithQState:(NSInteger)qstate
                   WithQExtendedFlag:(NSInteger)qExtendedFlag {
    [[STDataMgr qimDB_SharedInstance] insertQTNotesMainItemWithQId:qid
                                                        WithCid:cid
                                                      WithQType:qtype
                                                     WithQTitle:qtitle
                                                 WithQIntroduce:qIntroduce
                                                   WithQContent:qContent
                                                      WithQTime:qTime
                                                     WithQState:qstate
                                              WithQExtendedFlag:qExtendedFlag];
}

- (void)updateToMainWithQId:(NSInteger)qid
                    WithCid:(NSInteger)cid
                  WithQType:(NSInteger)qtype
                 WithQTitle:(NSString *)qtitle
              WithQDescInfo:(NSString *)qdescInfo
               WithQContent:(NSString *)qcontent
                  WithQTime:(NSInteger)qtime
                 WithQState:(NSInteger)qstate
          WithQExtendedFlag:(NSInteger)qExtendedFlag {
    [[STDataMgr qimDB_SharedInstance] updateToMainWithQId:qid WithCid:cid WithQType:qtype WithQTitle:qtitle WithQDescInfo:qdescInfo WithQContent:qcontent WithQTime:qtime WithQState:qstate WithQExtendedFlag:qExtendedFlag];
}

- (void)updateToMainItemWithDicts:(NSArray *)mainItemList {
    [[STDataMgr qimDB_SharedInstance] updateToMainItemWithDicts:mainItemList];
}

- (void)deleteToMainWithQid:(NSInteger)qid {
    [[STDataMgr qimDB_SharedInstance] deleteToMainWithQid:qid];
}

- (void)deleteToMainWithCid:(NSInteger)cid {
    [[STDataMgr qimDB_SharedInstance] deleteToMainWithCid:cid];
}

- (void)updateToMainItemTimeWithQId:(NSInteger)qid
                          WithQTime:(NSInteger)qTime
                  WithQExtendedFlag:(NSInteger)qExtendedFlag {
    [[STDataMgr qimDB_SharedInstance] updateToMainItemTimeWithQId:qid WithQTime:qTime WithQExtendedFlag:qExtendedFlag];
}

- (void)updateMainStateWithQid:(NSInteger)qid
                       WithCid:(NSInteger)cid
                    WithQState:(NSInteger)qstate
             WithQExtendedFlag:(NSInteger)qExtendedFlag {
    [[STDataMgr qimDB_SharedInstance] updateMainStateWithQid:qid WithCid:cid WithQState:qstate WithQExtendedFlag:qExtendedFlag];
}

- (NSArray *)getQTNotesMainItemWithQType:(NSInteger)qType {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesMainItemWithQType:qType];
}

- (NSArray *)getQTNotesMainItemWithQType:(NSInteger)qType QString:(NSString *)qString {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesMainItemWithQType:qType QString:qString];
}

- (NSArray *)getQTNotesMainItemWithQType:(NSInteger)qType WithExceptQState:(NSInteger)qState {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesMainItemWithQType:qType WithExceptQState:qState];
}

- (NSArray *)getQTNotesMainItemWithQType:(NSInteger)qType WithQState:(NSInteger)qState {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesMainItemWithQType:qType WithQState:qState];
}

- (NSArray *)getQTNoteMainItemWithQType:(NSInteger)qType WithQDescInfo:(NSString *)descInfo {
    return [[STDataMgr qimDB_SharedInstance] getQTNoteMainItemWithQType:qType WithQDescInfo:descInfo];
}

- (NSArray *)getQTNotesMainItemWithQExtendFlag:(NSInteger)qExtendFlag {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesMainItemWithQExtendFlag:qExtendFlag];
}

- (NSArray *)getQTNotesSubItemWithQSExtendedFlag:(NSInteger)qsExtendedFlag {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesSubItemWithQSExtendedFlag:qsExtendedFlag];
}

- (NSArray *)getQTNotesMainItemWithQExtendedFlag:(NSInteger)qExtendedFlag needConvertToString:(BOOL)flag {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesMainItemWithQExtendedFlag:qExtendedFlag needConvertToString:flag];
}

- (NSDictionary *)getQTNotesMainItemWithCid:(NSInteger)cid {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesMainItemWithCid:cid];
}

- (NSInteger)getQTNoteMainItemMaxTimeWithQType:(NSInteger)qType {
    return [[STDataMgr qimDB_SharedInstance] getQTNoteMainItemMaxTimeWithQType:qType];
}

- (NSInteger)getMaxQTNoteMainItemCid {
    return [[STDataMgr qimDB_SharedInstance] getMaxQTNoteMainItemCid];
}

//Sub

- (BOOL)checkExitsSubItemWithQsid:(NSInteger)qsid WithCsid:(NSInteger)csid {
    return [[STDataMgr qimDB_SharedInstance] checkExitsSubItemWithQsid:qsid WithCsid:csid];
}

- (void)insertQTNotesSubItemWithCId:(NSInteger)cid
                           WithQSId:(NSInteger)qsid
                           WithCSId:(NSInteger)csid
                         WithQSType:(NSInteger)qstype
                        WithQSTitle:(NSString *)qstitle
                    WithQSIntroduce:(NSString *)qsIntroduce
                      WithQSContent:(NSString *)qsContent
                         WithQSTime:(NSInteger)qsTime
                         WithQState:(NSInteger)qSstate
                WithQS_ExtendedFlag:(NSInteger)qs_ExtendedFlag {
    [[STDataMgr qimDB_SharedInstance] insertQTNotesSubItemWithCId:cid WithQSId:qsid WithCSId:csid WithQSType:qstype WithQSTitle:qstitle WithQSIntroduce:qsIntroduce WithQSContent:qsContent WithQSTime:qsTime WithQState:qSstate WithQS_ExtendedFlag:qs_ExtendedFlag];
}

- (void)updateToSubWithCid:(NSInteger)cid
                  WithQSid:(NSInteger)qsid
                  WithCSid:(NSInteger)csid
               WithQSTitle:(NSString *)qSTitle
            WithQSDescInfo:(NSString *)qsDescInfo
             WithQSContent:(NSString *)qsContent
                WithQSTime:(NSInteger)qsTime
               WithQSState:(NSInteger)qsState
       WithQS_ExtendedFlag:(NSInteger)qs_ExtendedFlag {
    [[STDataMgr qimDB_SharedInstance] updateToSubWithCid:cid WithQSid:qsid WithCSid:csid WithQSTitle:qSTitle WithQSDescInfo:qsDescInfo WithQSContent:qsContent WithQSTime:qsTime WithQSState:qsState WithQS_ExtendedFlag:qs_ExtendedFlag];
}

- (void)updateToSubItemWithDicts:(NSArray *)subItemList {
    [[STDataMgr qimDB_SharedInstance] updateToSubItemWithDicts:subItemList];
}

- (void)deleteToSubWithCId:(NSInteger)cid {
    [[STDataMgr qimDB_SharedInstance] deleteToSubWithCId:cid];
}

- (void)deleteToSubWithCSId:(NSInteger)Csid {
    [[STDataMgr qimDB_SharedInstance] deleteToSubWithCSId:Csid];
}

- (void)updateSubStateWithCSId:(NSInteger)Csid
                   WithQSState:(NSInteger)qsState
            WithQsExtendedFlag:(NSInteger)qsExtendedFlag {
    [[STDataMgr qimDB_SharedInstance] updateSubStateWithCSId:Csid WithQSState:qsState WithQsExtendedFlag:qsExtendedFlag];
}

- (void)updateToSubItemTimeWithCSId:(NSInteger)csid
                         WithQSTime:(NSInteger)qsTime
                 WithQsExtendedFlag:(NSInteger)qsExtendedFlag {
    [[STDataMgr qimDB_SharedInstance] updateToSubItemTimeWithCSId:csid WithQSTime:qsTime WithQsExtendedFlag:qsExtendedFlag];
}

- (NSArray *)getQTNotesSubItemWithMainQid:(NSString *)qid WithQSExtendedFlag:(NSInteger)qsExtendedFlag {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesSubItemWithMainQid:qid WithQSExtendedFlag:qsExtendedFlag];
}

- (NSArray *)getQTNotesSubItemWithMainQid:(NSString *)qid WithQSExtendedFlag:(NSInteger)qsExtendedFlag needConvertToString:(BOOL)flag {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesSubItemWithMainQid:qid WithQSExtendedFlag:qsExtendedFlag needConvertToString:flag];
}

- (NSArray *)getQTNotesSubItemWithCid:(NSInteger)cid QSExtendedFlag:(NSInteger)qsExtendedFlag {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesSubItemWithCid:cid QSExtendedFlag:qsExtendedFlag];
}

- (NSArray *)getQTNotesSubItemWithQSState:(NSInteger)qsState {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesSubItemWithQSState:qsState];
}

- (NSArray *)getQTNotesSubItemWithExpectQSState:(NSInteger)qsState {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesSubItemWithExpectQSState:qsState];
}

- (NSArray *)getQTNotesSubItemWithCid:(NSInteger)cid WithQSState:(NSInteger)qsState {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesSubItemWithCid:cid WithQSState:qsState];
}

- (NSDictionary *)getQTNotesSubItemWithCid:(NSInteger)cid WithUserId:(NSString *)userId {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesSubItemWithCid:cid WithUserId:userId];
}

- (NSArray *)getQTNotesSubItemWithCid:(NSInteger)cid WithExpectQSState:(NSInteger)qsState {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesSubItemWithCid:cid WithExpectQSState:qsState];
}

- (NSArray *)getQTNotesSubItemWithCid:(NSInteger)cid WithQSType:(NSInteger)qsType WithQSState:(NSInteger)qsState {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesSubItemWithCid:cid WithQSType:qsType WithQSState:qsState];
}

- (NSArray *)getQTNotesSubItemWithCid:(NSInteger)cid WithQSType:(NSInteger)qsType WithExpectQSState:(NSInteger)qsState {
    return [[STDataMgr qimDB_SharedInstance] getQTNotesSubItemWithCid:cid WithQSType:qsType WithExpectQSState:qsType];
}

- (NSInteger)getQTNoteSubItemMaxTimeWithCid:(NSInteger)cid
                                 WithQSType:(NSInteger)qsType {
    return [[STDataMgr qimDB_SharedInstance] getQTNoteSubItemMaxTimeWithCid:cid WithQSType:qsType];
}

- (NSDictionary *)getQTNoteSubItemWithParmDict:(NSDictionary *)paramDict {
    return [[STDataMgr qimDB_SharedInstance] getQTNoteSubItemWithParmDict:paramDict];
}

- (NSInteger)getMaxQTNoteSubItemCSid {
    return [[STDataMgr qimDB_SharedInstance] getMaxQTNoteSubItemCSid];
}

@end
