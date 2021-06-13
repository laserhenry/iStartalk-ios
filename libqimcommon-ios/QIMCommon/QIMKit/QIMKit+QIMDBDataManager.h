//
//  QIMKit+QIMDBDataManager.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"
@class STDataMgr;

@interface STKit (QIMDBDataManager)

+ (void) sharedInstanceWithDBPath:(NSString *)dbPath;

- (id) dbInstance;
- (void)setDomain:(NSString*)domain;
- (void)clearUserDescInfo;

- (NSString *)getTimeSmtapMsgIdForDate:(NSDate *)date WithUserId:(NSString *)userId;

//update IM_Group Set Name=(CASE WHEN NULL ISNULL then Name else 'aaaaa' end) WHERE GroupId = 'app-旅游包车@conference.ejabhost1';
// 群
- (NSInteger)getRNSearchEjabHost2GroupChatListByKeyStr:(NSString *)keyStr;
- (NSArray *)rnSearchEjabHost2GroupChatListByKeyStr:(NSString *)keyStr limit:(NSInteger)limit offset:(NSInteger)offset;
- (BOOL)checkGroup:(NSString *)groupId;
- (void)insertGroup:(NSString *)groupId;
- (void)bulkinsertGroups:(NSArray *) groups;

- (void) removeAllMessages;

- (void)clearGroupCardVersion;
- (NSInteger)getLocalGroupTotalCountByUserIds:(NSArray *)userIds;
- (NSArray *)searchGroupByUserIds:(NSArray *)userIds WithLimit:(NSInteger)limit WithOffset:(NSInteger)offset;
- (NSArray *)getGroupListMaxLastUpdateTime;
- (NSArray *)getGroupListMsgMaxTime;
- (void)bulkUpdateGroupCards:(NSArray *)array;
- (void)updateGroup:(NSString *)groupId
       WithNickName:(NSString *)nickName
          WithTopic:(NSString *)topic
           WithDesc:(NSString *)desc
      WithHeaderSrc:(NSString *)headerSrc
        WithVersion:(NSString *)version;
- (void)updateGroup:(NSString *)groupId WithNickName:(NSString *)nickName;
- (void)updateGroup:(NSString *)groupId WithTopic:(NSString *)topic;
- (void)updateGroup:(NSString *)groupId WithDesc:(NSString *)desc;
- (void)updateGroup:(NSString *)groupId WithHeaderSrc:(NSString *)headerSrc;
- (BOOL)needUpdateGroupImage:(NSString *)groupId;
- (NSString *)getGroupHeaderSrc:(NSString *)groupId;
- (void)deleteGroup:(NSString *)groupId;

- (NSDictionary *)getGroupMemberInfoByNickName:(NSString *)nickName;
- (NSDictionary *)getGroupMemberInfoByJid:(NSString *)jid WithGroupId:(NSString *)groupId;
//- (NSDictionary *)getGroupMemberInfo:(NSString *)nickName WithGroupId:(NSString *)groupId;
- (BOOL)checkGroupMember:(NSString *)nickName WithGroupId:(NSString *)groupId;
- (void)insertGroupMember:(NSDictionary *)memberDic WithGroupId:(NSString *)groupId;
- (void)bulkInsertGroupMember:(NSArray *)members WithGroupId:(NSString *)groupId;
- (NSArray *)getQChatGroupMember:(NSString *)groupId;
- (NSArray *)getQChatGroupMember:(NSString *)groupId BySearchStr:(NSString *)searchStr;
- (NSArray *)qimDB_getGroupMember:(NSString *)groupId;
- (NSArray *)qimDB_getGroupMember:(NSString *)groupId BySearchStr:(NSString *)searchStr;
- (NSArray *)qimDB_getGroupMember:(NSString *)groupId WithGroupIdentity:(NSInteger)identity;
- (NSDictionary *)getGroupOwnerInfoForGroupId:(NSString *)groupId;
- (void)deleteGroupMemberWithGroupId:(NSString *)groupId;
- (void)deleteGroupMemberJid:(NSString *)memberJid WithGroupId:(NSString *)groupId;
- (void)deleteGroupMember:(NSString *)nickname WithGroupId:(NSString *)groupId;
//- (void)updateGroupMember:(NSString *)memberId WithAffiliation:(NSString *)affiliation;
//- (NSArray *)getGroupListByMemberName:(NSString *)nickName;
//- (void) removeGroups;
- (NSDictionary *)getChatSessionWithUserId:(NSString *)userId chatType : (int)chatType;

// 用户信息
- (long long)getMinMsgTimeStampByXmppId:(NSString *)xmppId;
- (long long)getMaxMsgTimeStampByXmppId:(NSString *)xmppId;

- (long long) lastestGroupMessageTime;

- (void)bulkInsertUserInfosNotSaveDescInfo:(NSArray *)userInfos;
- (void)clearUserListForList:(NSArray *)userInfos;
- (void)bulkInsertUserInfos:(NSArray *)userInfos;
- (void)InsertOrUpdateUserInfos:(NSArray *)userInfos;

//- (void)insertUserInfoWithUserId:(NSString *)userId
//                        WithName:(NSString *)name
//                    WithDescInfo:(NSString *)descInfo
//                     WithHeadSrc:(NSString *)headerSrc
//                    WithUserInfo:(NSData *)userInfo;
/**
 获取用户BackInfo信息
 */
- (NSDictionary *)selectUserBackInfoByXmppId:(NSString *)xmppId;
- (NSDictionary *)selectUserByID:(NSString *)userId;
- (NSDictionary *)selectUserByJID:(NSString *)jid;
//- (NSDictionary *)selectUserByName:(NSString *)name;
- (NSDictionary *)selectUserByIndex:(NSString *)index;
- (NSArray *)selectXmppIdList;
- (NSArray *)selectUserIdList;
- (NSArray *)selectUserListBySearchStr:(NSString *)searchStr;

- (NSArray *)getOrganUserList;
- (NSInteger)selectUserListTotalCountBySearchStr:(NSString *)searchStr;

- (NSArray *)selectUserListExMySelfBySearchStr:(NSString *)searchStr WithLimit:(NSInteger)limit WithOffset:(NSInteger)offset;
- (NSArray *)selectUserListBySearchStr:(NSString *)searchStr WithLimit:(NSInteger)limit WithOffset:(NSInteger)offset;
- (NSArray *)selectUserListBySearchStr:(NSString *)searchStr inGroup:(NSString *) groupId;
- (NSArray *)selectUserListByUserIds:(NSArray *)userIds;
//- (NSArray *)selectUserListByXmppIds:(NSArray *)xmppIds;
- (NSDictionary *)selectUsersDicByXmppIds:(NSArray *)xmppIds;
- (void)bulkUpdateUserSearchIndexs:(NSArray *)searchIndexs;
- (void)updateUser:(NSString *)userId WithHeaderSrc:(NSString *)headerSrc WithVersion:(NSString *)version;
- (void)bulkUpdateUserCardsV2:(NSArray *)cards;


/**
 插入用户员工号&直属领导信息
 */
- (void)bulkUpdateUserBackInfo:(NSDictionary *)userBackInfo WithXmppId:(NSString *)xmppId;
- (NSString *)getUserHeaderSrcByUserId:(NSString *)userId;
//- (void)updateUser:(NSString *)userId WithVersion:(int)version;
- (BOOL)checkExitsUser;

- (void)updateMessageWithExtendInfo:(NSString *)extendInfo ForMsgId:(NSString *)msgId;
- (void)deleteMessageWithXmppId:(NSString *)xmppId;
- (void)deleteMessageByMessageId:(NSString *)messageId ByJid:(NSString *)sid;

- (void)updateMessageWithMsgId:(NSString *)msgId
                    WithMsgRaw:(NSString *)msgRaw;
/**
 *  通过msgId获取Msg
 *
 *  @param msgId msgId
 */
- (NSDictionary *)getMsgsByMsgId:(NSString *)msgId;

//更新消息
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
                  ExtendedFlag:(int)ExtendedFlag;

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
                    WithMsgRaw:(NSString *)msgRaw;

- (void)revokeMessageByMsgId:(NSString *)msgId
                 WithContent:(NSString *)content
                 WithMsgType:(int)msgType;

- (BOOL)qimDB_checkMsgId:(NSString *)msgId;

/**
 插入群聊JSON消息
 */
- (NSArray *)bulkInsertIphoneHistoryGroupJSONMsg:(NSArray *)list
                                  WithMyNickName:(NSString *)myNickName
                                   WithReadMarkT:(long long)readMarkT
                                WithDidReadState:(int)didReadState
                                     WithMyRtxId:(NSString *)rtxId;

/**
 插入群聊JSON翻页消息
 */
- (NSArray *)bulkInsertIphoneMucJSONMsg:(NSArray *)list WithMyNickName:(NSString *)myNickName WithReadMarkT:(long long)readMarkT WithDidReadState:(int)didReadState WithMyRtxId:(NSString *)rtxId;

/**
 插入群聊离线XML消息
 */
- (NSArray *)bulkInsertIphoneHistoryGroupMsg:(NSArray *)list WithXmppId:(NSString *)xmppId WithMyNickName:(NSString *)myNickName WithReadMarkT:(long long)readMarkT WithDidReadState:(int)didReadState WithMyRtxId:(NSString *)rtxId;

- (NSArray *)bulkInsertHistoryGroupMsg:(NSArray *)list WithXmppId:(NSString *)xmppId WithMyNickName:(NSString *)myNickName WithReadMarkT:(long long)readMarkT WithDidReadState:(int)didReadState;

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 插入离线单人消息
 
 @param list 消息数组
 @param meJid 自身Id
 @param supportMsgTypeList 支持的MsgTypeList，是否需要要切换Body & Extentioninfo
 @param didReadState 是否已读
 */
#pragma mark - 插入离线单人消息
- (NSMutableDictionary *)bulkInsertHistoryChatJSONMsg:(NSArray *)list
                                                   to:(NSString *)meJid
                                    supportedMsgTypes:(NSArray *)supportMsgTypeList
                                     WithDidReadState:(int)didReadState;

- (NSString *)getC2BMessageFeedBackWithMsgId:(NSString *)msgId;

/**
 插入下拉翻页JSON消息
 
 @param list 消息list
 @param xmppId xmppId
 @param supportMsgTypeList 支持的MsgType
 @param didReadState 阅读状态
 */
#pragma mark - 插入下拉翻页消息
- (NSArray *)bulkInsertHistoryChatJSONMsg:(NSArray *)list
                               WithXmppId:(NSString *)xmppId
                         WithDidReadState:(int)didReadState;

// msg Key
- (void)bulkInsertMessage:(NSArray *)msgList WithSessionId:(NSString *)sessionId;

// update message state
- (void)updateMsgState:(int)msgState WithMsgId:(NSString *)msgId;

// 0 未读 1是读过了
- (void)updateMessageReadStateWithMsgId:(NSString *)msgId;

//批量更新消息阅读状态
- (void)bulkUpdateMessageReadStateWithMsg:(NSArray *)msgs;

// 0 未读 1是读过了
- (void)updateMessageReadStateWithSessionId:(NSString *)sessionId;

// 更新会话列表最后一条消息ID
- (void)updateSessionLastMsgIdWithSessionId:(NSString *)sessionId
                              WithLastMsgId:(NSString *)lastMsgId;

// 创建会话列表记录
- (void)insertSessionWithSessionId:(NSString *)sessinId
                        WithUserId:(NSString *)userId
                     WithLastMsgId:(NSString *)lastMsgId
                WithLastUpdateTime:(long long)lastUpdateTime
                          ChatType:(int)ChatType
                       WithRealJid:(id)realJid;

- (void)deleteSession:(NSString *)xmppId RealJid:(NSString *)realJid;
- (void)deleteSession:(NSString *)xmppId;

//获取最近一条会话
- (NSDictionary *)getLastedSingleChatSession;


/**
 获取公众号会话
 */
- (NSDictionary *)qimDb_getPublicNumberSession;
// 获取会话列表
- (NSArray *)qimDB_getSessionListWithSingleChatType:(int)chatType;
- (NSArray *)getSessionListXMPPIDWithSingleChatType:(int)singleChatType;
- (NSArray *)qimDB_getNotReadMsgListForUserId:(NSString *)userId;
- (NSArray *)qimDB_getNotReadMsgListForUserId:(NSString *)userId ForRealJid:(NSString *)realJid;
- (long long)getReadedTimeStampForUserId:(NSString *)userId WithRealJid:(NSString *)realJid WithMsgDirection:(int)msgDirection withUnReadCount:(NSInteger)unReadCount;
// 获取会话消息记录
- (NSArray *)qimDB_getMgsListBySessionId:(NSString *)sesId;

// 获取会话消息记录 Limit 获取消息条数 倒序的
- (NSArray *)qimDB_getMgsListBySessionId:(NSString *)sesId WithRealJid:(NSString *)realJid WithLimit:(int)limit WithOffset:(int)offset;
- (NSArray *)getMsgListByXmppId:(NSString *)xmppId WithRealJid:(NSString *)realJid FromTimeStamp:(long long)timeStamp;
- (NSArray *)getMsgListByXmppId:(NSString *)xmppId FromTimeStamp:(long long)timeStamp;

// 更新消息内容 比如下载文件后的本地文件名
- (void)updateMsgsContent:(NSString *)content ByMsgId:(NSString *)msgId;

// 通过UserId 获取会话信息
- (NSDictionary *)getChatSessionWithUserId:(NSString *)userId;

// 总的未读消息数
- (void)updateMessageFromState:(int)fState ToState:(int)tState;
- (NSInteger)getMessageStateWithMsgId:(NSString *)msgId;

- (NSInteger)getReadStateWithMsgId:(NSString *)msgId;

- (NSArray *)getMsgIdsForDirection:(int)msgDirection WithMsgState:(int)msgState;
// 搜索
- (NSArray *)searchMsgHistoryWithKey:(NSString *)key;

#pragma mark - 消息数据方法
- (long long) lastestMessageTime;
- (long long) lastestSystemMessageTime;
- (NSString *) getLastMsgIdByJid:(NSString *)jid;

/****************** FriendSter Msg *******************/
- (void)insertFSMsgWithMsgId:(NSString *)msgId
                  WithXmppId:(NSString *)xmppId
                WithFromUser:(NSString *)fromUser
              WithReplyMsgId:(NSString *)replyMsgId
               WithReplyUser:(NSString *)replyUser
                 WithContent:(NSString *)content
                 WithMsgDate:(long long)msgDate
            WithExtendedFlag:(NSData *)etxtenedFlag;

- (void)bulkInsertFSMsgWithMsgList:(NSArray *)msgList;

- (NSArray *)getFSMsgListByXmppId:(NSString *)xmppId;

- (NSDictionary *)getFSMsgListByReplyMsgId:(NSString *)replyMsgId;


/****************** readmark *********************/
- (long long)qimDB_updateGroupMsgWithMsgState:(int)msgState ByGroupMsgList:(NSArray *)groupMsgList;

- (void)updateUserMsgWithMsgState:(int)msgState ByMsgList:(NSArray *)userMsgList;

- (void)clearHistoryMsg;

// 系统消息专用 。。。。。
- (void)updateSystemMsgState:(int)msgState WithXmppId:(NSString *)xmppId;

- (void)closeDataBase;

+ (void)clearDataBaseCache;

- (void)qimDB_dbCheckpoint;

/*************** Friend List *************/
- (void)bulkInsertFriendList:(NSArray *)friendList;
- (void)insertFriendWithUserId:(NSString *)userId
                    WithXmppId:(NSString *)xmppId
                      WithName:(NSString *)name
               WithSearchIndex:(NSString *)searchIndex
                  WithDescInfo:(NSString *)descInfo
                   WithHeadSrc:(NSString *)headerSrc
                  WithUserInfo:(NSData *)userInfo
            WithLastUpdateTime:(long long)lastUpdateTime
          WithIncrementVersion:(int)incrementVersion;
- (void)deleteFriendListWithXmppId:(NSString *)xmppId;
- (void)deleteFriendListWithUserId:(NSString *)userId;
- (void)deleteFriendList;
- (void)deleteSessionList;
- (NSMutableArray *)selectFriendList;

- (NSMutableArray *)qimDB_selectFriendListInGroupId:(NSString *)groupId;

- (NSDictionary *)selectFriendInfoWithUserId:(NSString *)userId;
- (NSDictionary *)selectFriendInfoWithXmppId:(NSString *)xmppId;
- (void)bulkInsertFriendNotifyList:(NSArray *)notifyList;
- (void)insertFriendNotifyWithUserId:(NSString *)userId
                          WithXmppId:(NSString *)xmppId
                            WithName:(NSString *)name
                        WithDescInfo:(NSString *)descInfo
                         WithHeadSrc:(NSString *)headerSrc
                     WithSearchIndex:(NSString *)searchIndex
                        WithUserInfo:(NSString *)userInfo
                         WithVersion:(int)version
                           WithState:(int)state
                  WithLastUpdateTime:(long long)lastUpdateTime;
- (void)deleteFriendNotifyWithUserId:(NSString *)userId;
- (NSMutableArray *)selectFriendNotifys;
- (void)updateFriendNotifyWithXmppId:(NSString *)xmppId WithState:(int)state;
- (void)updateFriendNotifyWithUserId:(NSString *)userId WithState:(int)state;
- (long long)getMaxTimeFriendNotify;

// ******************** 公众账号 ***************************** //
- (BOOL)checkPublicNumberMsgById:(NSString *)msgId;
- (void)checkPublicNumbers:(NSArray *)publicNumberIds;
- (void)bulkInsertPublicNumbers:(NSArray *)publicNumberList;
- (void)insertPublicNumberXmppId:(NSString *)xmppId
              WithPublicNumberId:(NSString *)publicNumberId
            WithPublicNumberType:(int)publicNumberType
                        WithName:(NSString *)name
                   WithHeaderSrc:(NSString *)headerSrc
                    WithDescInfo:(NSString *)descInfo
                 WithSearchIndex:(NSString *)searchIndex
                  WithPublicInfo:(NSString *)publicInfo
                     WithVersion:(int)version;
- (void)deletePublicNumberId:(NSString *)publicNumberId;
- (NSArray *)getPublicNumberVersionList;
- (NSArray *)getPublicNumberList;
- (NSArray *)searchPublicNumberListByKeyStr:(NSString *)keyStr;
- (NSInteger)getRnSearchPublicNumberListByKeyStr:(NSString *)keyStr;
- (NSArray *)rnSearchPublicNumberListByKeyStr:(NSString *)keyStr limit:(NSInteger)limit offset:(NSInteger)offset;
- (NSDictionary *)getPublicNumberCardByJId:(NSString *)jid;
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
                        WithReadedTag:(int)readedTag;

- (NSArray *)getMsgListByPublicNumberId:(NSString *)publicNumberId
                              WithLimit:(int)limit
                             WithOffset:(int)offset
                         WithFilterType:(NSArray *)actionTypes;

/****************** Collection Msg *******************/

/**
 获取已代收账号
 */
- (NSArray *)getCollectionAccountList;

/**
 插入已代收账号
 */
- (void)bulkinsertCollectionAccountList:(NSArray *)accounts;


/**
 查询代收账号
 */
- (NSDictionary *)selectCollectionUserByJID:(NSString *)jid;

/**
 插入用户代收名片
 */
- (void)bulkInsertCollectionUserCards:(NSArray *)userCards;


/**
 插入群代收名片
 */
- (void)bulkInsertCollectionGroupCards:(NSArray *)groupCards;

/**
 获取代收群名片
 */
- (NSDictionary *)getCollectionGroupCardByGroupId:(NSString *)groupId;

/**
 获取最后一条代收消息
 */
- (NSDictionary *)getLastCollectionMsgWithLastMsgId:(NSString *)lastMsgId;

- (NSArray *)getCollectionSessionListWithBindId:(NSString *)bindId;
- (NSArray *)getCollectionMsgListWithBindId:(NSString *)bindId;


/**
 检查代收消息是否存在
 
 @param msgId msgId
 */
- (BOOL)checkCollectionMsgById:(NSString *)msgId;

/**
 插入代收消息原始值
 */
- (void)bulkInsertCollectionMsgWithMsgDics:(NSArray *)msgs;

- (NSInteger)getCollectionMsgNotReadCountByDidReadState:(NSInteger)readState;

- (NSInteger)getCollectionMsgNotReadCountByDidReadState:(NSInteger)readState ForBindId:(NSString *)bindId;

- (NSInteger)getCollectionMsgNotReadCountgetCollectionMsgNotReadCountByDidReadState:(NSInteger)readState ForBindId:(NSString *)bindId originUserId:(NSString *)originUserId;

- (void)updateCollectionMsgNotReadStateByJid:(NSString *)jid WithReadtate:(NSInteger)readState;
- (void)updateCollectionMsgNotReadStateForBindId:(NSString *)bindId originUserId:(NSString *)originUserId WithReadState:(NSInteger)readState;
- (NSDictionary *)getCollectionMsgListForMsgId:(NSString *)msgId;
- (NSArray *)getCollectionMsgListWithUserId:(NSString *)userId originUserId:(NSString *)originUserId;

/*********************** Group Message State **************************/
- (long long)qimDB_bulkUpdateGroupMessageReadFlag:(NSArray *)mucArray;

/*********************** QTNotes **********************/

//Main

- (BOOL)checkExitsMainItemWithQid:(NSInteger)qid WithCId:(NSInteger)cid;

- (void)insertQTNotesMainItemWithQId:(NSInteger)qid
                             WithCid:(NSInteger)cid
                           WithQType:(NSInteger)qtype
                          WithQTitle:(NSString *)qtitle
                      WithQIntroduce:(NSString *)qIntroduce
                        WithQContent:(NSString *)qContent
                           WithQTime:(NSInteger)qTime
                          WithQState:(NSInteger)qstate
                   WithQExtendedFlag:(NSInteger)qExtendedFlag;

- (void)updateToMainWithQId:(NSInteger)qid
                    WithCid:(NSInteger)cid
                  WithQType:(NSInteger)qtype
                 WithQTitle:(NSString *)qtitle
              WithQDescInfo:(NSString *)qdescInfo
               WithQContent:(NSString *)qcontent
                  WithQTime:(NSInteger)qtime
                 WithQState:(NSInteger)qstate
          WithQExtendedFlag:(NSInteger)qExtendedFlag;

- (void)updateToMainItemWithDicts:(NSArray *)mainItemList;

- (void)deleteToMainWithQid:(NSInteger)qid;

- (void)deleteToMainWithCid:(NSInteger)cid;

- (void)updateToMainItemTimeWithQId:(NSInteger)qid
                          WithQTime:(NSInteger)qTime
                  WithQExtendedFlag:(NSInteger)qExtendedFlag;

- (void)updateMainStateWithQid:(NSInteger)qid
                       WithCid:(NSInteger)cid
                    WithQState:(NSInteger)qstate
             WithQExtendedFlag:(NSInteger)qExtendedFlag;

- (NSArray *)getQTNotesMainItemWithQType:(NSInteger)qType;

- (NSArray *)getQTNotesMainItemWithQType:(NSInteger)qType QString:(NSString *)qString;

- (NSArray *)getQTNotesMainItemWithQType:(NSInteger)qType WithExceptQState:(NSInteger)qState;

- (NSArray *)getQTNotesMainItemWithQType:(NSInteger)qType WithQState:(NSInteger)qState;

- (NSArray *)getQTNoteMainItemWithQType:(NSInteger)qType WithQDescInfo:(NSString *)descInfo;
- (NSArray *)getQTNotesMainItemWithQExtendFlag:(NSInteger)qExtendFlag;
- (NSArray *)getQTNotesSubItemWithQSExtendedFlag:(NSInteger)qsExtendedFlag;

- (NSArray *)getQTNotesMainItemWithQExtendedFlag:(NSInteger)qExtendedFlag needConvertToString:(BOOL)flag;

- (NSDictionary *)getQTNotesMainItemWithCid:(NSInteger)cid;

- (NSInteger)getQTNoteMainItemMaxTimeWithQType:(NSInteger)qType;

- (NSInteger)getMaxQTNoteMainItemCid;

//Sub

- (BOOL)checkExitsSubItemWithQsid:(NSInteger)qsid WithCsid:(NSInteger)csid;

- (void)insertQTNotesSubItemWithCId:(NSInteger)cid
                           WithQSId:(NSInteger)qsid
                           WithCSId:(NSInteger)csid
                         WithQSType:(NSInteger)qstype
                        WithQSTitle:(NSString *)qstitle
                    WithQSIntroduce:(NSString *)qsIntroduce
                      WithQSContent:(NSString *)qsContent
                         WithQSTime:(NSInteger)qsTime
                         WithQState:(NSInteger)qSstate
                WithQS_ExtendedFlag:(NSInteger)qs_ExtendedFlag;

- (void)updateToSubWithCid:(NSInteger)cid
                  WithQSid:(NSInteger)qsid
                  WithCSid:(NSInteger)csid
               WithQSTitle:(NSString *)qSTitle
            WithQSDescInfo:(NSString *)qsDescInfo
             WithQSContent:(NSString *)qsContent
                WithQSTime:(NSInteger)qsTime
               WithQSState:(NSInteger)qsState
       WithQS_ExtendedFlag:(NSInteger)qs_ExtendedFlag;

- (void)updateToSubItemWithDicts:(NSArray *)subItemList;

- (void)deleteToSubWithCId:(NSInteger)cid;

- (void)deleteToSubWithCSId:(NSInteger)Csid;

- (void)updateSubStateWithCSId:(NSInteger)Csid
                   WithQSState:(NSInteger)qsState
            WithQsExtendedFlag:(NSInteger)qsExtendedFlag;

- (void)updateToSubItemTimeWithCSId:(NSInteger)csid
                         WithQSTime:(NSInteger)qsTime
                 WithQsExtendedFlag:(NSInteger)qsExtendedFlag;

- (NSArray *)getQTNotesSubItemWithMainQid:(NSString *)qid WithQSExtendedFlag:(NSInteger)qsExtendedFlag;

- (NSArray *)getQTNotesSubItemWithMainQid:(NSString *)qid WithQSExtendedFlag:(NSInteger)qsExtendedFlag needConvertToString:(BOOL)flag;

- (NSArray *)getQTNotesSubItemWithCid:(NSInteger)cid QSExtendedFlag:(NSInteger)qsExtendedFlag;

- (NSArray *)getQTNotesSubItemWithQSState:(NSInteger)qsState;

- (NSArray *)getQTNotesSubItemWithExpectQSState:(NSInteger)qsState;

- (NSArray *)getQTNotesSubItemWithCid:(NSInteger)cid WithQSState:(NSInteger)qsState;

- (NSDictionary *)getQTNotesSubItemWithCid:(NSInteger)cid WithUserId:(NSString *)userId;

- (NSArray *)getQTNotesSubItemWithCid:(NSInteger)cid WithExpectQSState:(NSInteger)qsState;

- (NSArray *)getQTNotesSubItemWithCid:(NSInteger)cid WithQSType:(NSInteger)qsType WithQSState:(NSInteger)qsState;

- (NSArray *)getQTNotesSubItemWithCid:(NSInteger)cid WithQSType:(NSInteger)qsType WithExpectQSState:(NSInteger)qsState;

- (NSInteger)getQTNoteSubItemMaxTimeWithCid:(NSInteger)cid
                                 WithQSType:(NSInteger)qsType;
- (NSDictionary *)getQTNoteSubItemWithParmDict:(NSDictionary *)paramDict;

- (NSInteger)getMaxQTNoteSubItemCSid;

@end
