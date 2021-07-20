//
//  QIMKit+QIMMessage.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//

#import "QIMKit+QIMMessage.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMMessage)

- (NSArray *)getMsgsForMsgType:(QIMMessageType)msgType {
    return [[STManager sharedInstance] getMsgsForMsgType:msgType];
}

- (NSDictionary *)getMsgDictByMsgId:(NSString *)msgId {
    return [[STManager sharedInstance] getMsgDictByMsgId:msgId];
}

- (STMsgModel *)getMsgByMsgId:(NSString *)msgId {
    return [[STManager sharedInstance] getMsgByMsgId:msgId];
}

- (void)checkMsgTimeWithJid:(NSString *)jid WithRealJid:(NSString *)realJid WithMsgDate:(long long)msgDate WithGroup:(BOOL)flag {
    [[STManager sharedInstance] checkMsgTimeWithJid:jid WithRealJid:realJid WithMsgDate:msgDate WithGroup:flag];
}

- (void)checkMsgTimeWithJid:(NSString *)jid WithMsgDate:(long long)msgDate WithGroup:(BOOL)flag {
    [[STManager sharedInstance] checkMsgTimeWithJid:jid WithMsgDate:msgDate WithGroup:flag];
}

- (void)checkMsgTimeWithJid:(NSString *)jid WithRealJid:(NSString *)realJid WithMsgDate:(long long)msgDate WithGroup:(BOOL)flag withFrontInsert:(BOOL)frontInsert {
    [[STManager sharedInstance] checkMsgTimeWithJid:jid WithRealJid:realJid WithMsgDate:msgDate WithGroup:(BOOL)flag withFrontInsert:frontInsert];
}

- (void)checkMsgTimeWithJid:(NSString *)jid WithMsgDate:(long long)msgDate WithGroup:(BOOL)flag withFrontInsert:(BOOL)frontInsert {
    [[STManager sharedInstance] checkMsgTimeWithJid:jid WithMsgDate:msgDate WithGroup:flag withFrontInsert:frontInsert];
}

- (void)setAppendInfo:(NSDictionary *)appendInfoDict ForUserId:(NSString *)userId {
    [[STManager sharedInstance] setAppendInfo:appendInfoDict ForUserId:userId];
}

- (NSDictionary *)getAppendInfoForUserId:(NSString *)userId {
   return [[STManager sharedInstance] getAppendInfoForUserId:userId];
}

- (void)setChannelInfo:(NSString *)channelId ForUserId:(NSString *)userId {
    [[STManager sharedInstance] setChannelInfo:channelId ForUserId:userId];
}

- (NSString *)getChancelInfoForUserId:(NSString *)userId {
   return [[STManager sharedInstance] getChancelInfoForUserId:userId];
}

- (void)setConversationParam:(NSDictionary *)param WithJid:(NSString *)jid {
    [[STManager sharedInstance] setConversationParam:param WithJid:jid];
}

- (NSDictionary *)conversationParamWithJid:(NSString *)jid {
    return [[STManager sharedInstance] conversationParamWithJid:jid];
}

- (void)sendTypingToUserId:(NSString *)userId {
    [[STManager sharedInstance] sendTypingToUserId:userId];
}

- (void)saveMsg:(STMsgModel *)msg ByJid:(NSString *)sid {
    [[STManager sharedInstance] saveMsg:msg ByJid:sid];
}

- (void)updateMsg:(STMsgModel *)msg ByJid:(NSString *)sid {
    [[STManager sharedInstance] updateMsg:msg ByJid:sid];
}

- (void)deleteMsg:(STMsgModel *)msg ByJid:(NSString *)sid {
    [[STManager sharedInstance] deleteMsg:msg ByJid:sid];
}

- (BOOL)sendControlStateWithMessagesIdArray:(NSArray *)messages WithXmppId:(NSString *)xmppId {
    return [[STManager sharedInstance] sendControlStateWithMessagesIdArray:messages WithXmppId:xmppId];
}

- (BOOL)sendReadStateWithMessagesIdArray:(NSArray *)messages WithMessageReadFlag:(QIMMessageReadFlag)msgReadFlag WithXmppId:(NSString *)xmppId {
    return [[STManager sharedInstance] sendReadStateWithMessagesIdArray:messages WithMessageReadFlag:msgReadFlag WithXmppId:xmppId];
}

- (BOOL)sendReadStateWithMessagesIdArray:(NSArray *)messages WithMessageReadFlag:(QIMMessageReadFlag)msgReadFlag WithXmppId:(NSString *)xmppId WithRealJid:(NSString *)realJid {
    return [[STManager sharedInstance] sendReadStateWithMessagesIdArray:messages WithMessageReadFlag:msgReadFlag WithXmppId:xmppId WithRealJid:realJid];
}

- (BOOL)sendReadstateWithGroupLastMessageTime:(long long) lastTime withGroupId:(NSString *) groupId {
    return [[STManager sharedInstance] sendReadstateWithGroupLastMessageTime:lastTime withGroupId:groupId];
}

- (STMsgModel *)sendShockToUserId:(NSString *)userId {
    return [[STManager sharedInstance] sendShockToUserId:userId];
}

- (void)revokeMessageWithMessageId:(NSString *)messageId message:(NSString *)message ToJid:(NSString *)jid {
    [[STManager sharedInstance] revokeMessageWithMessageId:messageId message:message ToJid:jid];
}

- (void)revokeConsultMessageWithMessageId:(NSString *)messageId message:(NSString *)message ToJid:(NSString *)jid realToJid:(NSString *)realToJid chatType:(int)chatType{
    [[STManager sharedInstance] revokeConsultMessageWithMessageId:messageId message:message ToJid:jid realToJid:realToJid chatType:chatType];
}

- (STMsgModel *)sendVoiceUrl:(NSString *)voiceUrl withVoiceName:(NSString *)voiceName withSeconds:(int)seconds ToUserId:(NSString *)userId {
    return [[STManager sharedInstance] sendVoiceUrl:voiceUrl withVoiceName:voiceName withSeconds:seconds ToUserId:userId];
}

- (STMsgModel *)sendMessage:(STMsgModel *)msg ToUserId:(NSString *)userId {
    return [[STManager sharedInstance] sendMessage:msg ToUserId:userId];
}

- (STMsgModel *)sendMessage:(NSString *)msg WithInfo:(NSString *)info ToUserId:(NSString *)userId WithMsgType:(int)msgType {
    return [[STManager sharedInstance] sendMessage:msg WithInfo:info ToUserId:userId WithMsgType:msgType];
}

- (STMsgModel *)sendMessage:(NSString *)msg ToGroupId:(NSString *)groupId {
    return [[STManager sharedInstance] sendMessage:msg ToGroupId:groupId];
}

- (STMsgModel *)sendMessage:(NSString *)msg WithInfo:(NSString *)info ToGroupId:(NSString *)groupId WithMsgType:(int)msgType {
    return [[STManager sharedInstance] sendMessage:msg WithInfo:info ToGroupId:groupId WithMsgType:msgType];
}

- (STMsgModel *)sendMessage:(NSString *)msg WithInfo:(NSString *)info ToGroupId:(NSString *)groupId WithMsgType:(int)msgType WithMsgId:(NSString *)msgId {
    return [[STManager sharedInstance] sendMessage:msg WithInfo:info ToGroupId:groupId WithMsgType:msgType WithMsgId:msgId];
}

- (void)revokeGroupMessageWithMessageId:(NSString *)messageId message:(NSString *)message ToJid:(NSString *)jid {
    [[STManager sharedInstance] revokeGroupMessageWithMessageId:messageId message:message ToJid:jid];
}

// 发送音视频消息
- (void)sendAudioVideoWithType:(int)msgType WithBody:(NSString *)body WithExtentInfo:(NSString *)extentInfo WithMsgId:(NSString *)msgId ToJid:(NSString *)jid {
    [[STManager sharedInstance] sendAudioVideoWithType:msgType WithBody:body WithExtentInfo:extentInfo WithMsgId:msgId ToJid:jid];
}

- (void)sendWlanMessage:(NSString *)content to:(NSString *)targetID extendInfo:(NSString *)extendInfo msgType:(int)msgType completionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))completionHandler {
    [[STManager sharedInstance] sendWlanMessage:content to:targetID extendInfo:extendInfo msgType:msgType completionHandler:completionHandler];
}

- (STMsgModel *)createMessageWithMsg:(NSString *)msg extenddInfo:(NSString *)extendInfo userId:(NSString *)userId userType:(ChatType)userType msgType:(QIMMessageType)msgType forMsgId:(NSString *)mId willSave:(BOOL)willSave {
    return [[STManager sharedInstance] createMessageWithMsg:msg extenddInfo:extendInfo userId:userId userType:userType msgType:msgType forMsgId:mId willSave:willSave];
}
- (STMsgModel *)createMessageWithMsg:(NSString *)msg extenddInfo:(NSString *)extendInfo userId:(NSString *)userId realJid:(NSString *)realJid userType:(ChatType)userType msgType:(QIMMessageType)msgType forMsgId:(NSString *)mId msgState:(QIMMessageSendState)msgState willSave:(BOOL)willSave {
    return [[STManager sharedInstance] createMessageWithMsg:msg extenddInfo:extendInfo userId:userId realJid:realJid userType:userType msgType:msgType forMsgId:mId msgState:msgState willSave:willSave];
}

- (STMsgModel *)createMessageWithMsg:(NSString *)msg extenddInfo:(NSString *)extendInfo userId:(NSString *)userId realJid:(NSString *)realJid userType:(ChatType)userType msgType:(QIMMessageType)msgType forMsgId:(NSString *)mId willSave:(BOOL)willSave {
    return [[STManager sharedInstance] createMessageWithMsg:msg extenddInfo:extendInfo userId:userId realJid:realJid userType:userType msgType:msgType forMsgId:mId willSave:willSave];
}

- (STMsgModel *)sendMessage:(STMsgModel *)msg withChatType:(ChatType)chatType channelInfo:(NSString *)channelInfo realFrom:(NSString *)realFrom realTo:(NSString *)realTo ochatJson:(NSString *)ochatJson {
    return [[STManager sharedInstance] sendMessage:msg withChatType:chatType channelInfo:channelInfo realFrom:realFrom realTo:realTo ochatJson:ochatJson];
}

- (STMsgModel *)createMessageWithMsg:(NSString *)msg extenddInfo:(NSString *)extendInfo userId:(NSString *)userId userType:(ChatType)userType msgType:(QIMMessageType)msgType {
    return [[STManager sharedInstance] createMessageWithMsg:msg extenddInfo:extendInfo userId:userId userType:userType msgType:msgType];
}

- (STMsgModel *)createMessageWithMsg:(NSString *)msg extenddInfo:(NSString *)extendInfo userId:(NSString *)userId userType:(ChatType)userType msgType:(QIMMessageType)msgType backinfo:(NSString *)backInfo {
    return [[STManager sharedInstance] createMessageWithMsg:msg extenddInfo:extendInfo userId:userId userType:userType msgType:msgType backinfo:backInfo];
}

- (STMsgModel *)createMessageWithMsg:(NSString *)msg extenddInfo:(NSString *)extendInfo userId:(NSString *)userId userType:(ChatType)userType msgType:(QIMMessageType)msgType forMsgId:(NSString *)mId {
    return [[STManager sharedInstance] createMessageWithMsg:msg extenddInfo:extendInfo userId:userId userType:userType msgType:msgType forMsgId:mId];
}

- (void)synchronizeChatSessionWithUserId:(NSString *)userId WithChatType:(ChatType)chatType WithRealJid:(NSString *)realJid {
    [[STManager sharedInstance] synchronizeChatSessionWithUserId:userId WithChatType:chatType WithRealJid:realJid];
}

#pragma mark - 位置共享

- (STMsgModel *)sendShareLocationMessage:(NSString *)msg WithInfo:(NSString *)info ToJid:(NSString *)jid WithMsgType:(int)msgType {
    return [[STManager sharedInstance] sendShareLocationMessage:msg WithInfo:info ToJid:jid WithMsgType:msgType];
}

- (STMsgModel *)beginShareLocationToUserId:(NSString *)userId WithShareLocationId:(NSString *)shareLocationId {
    return [[STManager sharedInstance] beginShareLocationToUserId:userId WithShareLocationId:shareLocationId];
}

- (STMsgModel *)beginShareLocationToGroupId:(NSString *)GroupId WithShareLocationId:(NSString *)shareLocationId {
    return [[STManager sharedInstance] beginShareLocationToGroupId:GroupId WithShareLocationId:shareLocationId];
}

- (BOOL)joinShareLocationToUsers:(NSArray *)users WithShareLocationId:(NSString *)shareLocationId {
    return [[STManager sharedInstance] joinShareLocationToUsers:users WithShareLocationId:shareLocationId];
}

- (BOOL)sendMyLocationToUsers:(NSArray *)users WithLocationInfo:(NSString *)locationInfo ByShareLocationId:(NSString *)shareLocationId {
    return [[STManager sharedInstance] sendMyLocationToUsers:users WithLocationInfo:locationInfo ByShareLocationId:shareLocationId];
}

- (BOOL)quitShareLocationToUsers:(NSArray *)users WithShareLocationId:(NSString *)shareLocationId {
    return [[STManager sharedInstance] quitShareLocationToUsers:users WithShareLocationId:shareLocationId];
}

- (NSString *)getShareLocationIdByJid:(NSString *)jid {
    return [[STManager sharedInstance] getShareLocationIdByJid:jid];
}

- (NSString *)getShareLocationFromIdByShareLocationId:(NSString *)shareLocationId {
    return [[STManager sharedInstance] getShareLocationFromIdByShareLocationId:shareLocationId];
}

- (NSArray *)getShareLocationUsersByShareLocationId:(NSString *)shareLocationId {
    return [[STManager sharedInstance] getShareLocationUsersByShareLocationId:shareLocationId];
}


#pragma mark - 未读数

- (void)updateMsgReadCompensateSetWithMsgId:(NSString *)msgId WithAddFlag:(BOOL)flag WithState:(QIMMessageSendState)state{
    [[STManager sharedInstance] updateMsgReadCompensateSetWithMsgId:msgId WithAddFlag:flag WithState:state];
}

- (NSMutableSet *)getLastMsgCompensateReadSet {
    return [[STManager sharedInstance] getLastMsgCompensateReadSet];
}

- (void)clearAllNoRead {
    [[STManager sharedInstance] clearAllNoRead];
}

- (void)clearSystemMsgNotReadWithJid:(NSString *)jid {
    [[STManager sharedInstance] clearSystemMsgNotReadWithJid:jid];
}

- (void)clearNotReadMsgByJid:(NSString *)jid {
    [[STManager sharedInstance] clearNotReadMsgByJid:jid];
}

- (void)clearNotReadMsgByJid:(NSString *)jid ByRealJid:(NSString *)realJid {
    [[STManager sharedInstance] clearNotReadMsgByJid:jid ByRealJid:realJid];
}

- (void)clearNotReadMsgByGroupId:(NSString *)groupId {
    [[STManager sharedInstance] clearNotReadMsgByGroupId:groupId];
}

- (NSInteger)getNotReadMsgCountByJid:(NSString *)jid WithRealJid:(NSString *)realJid {
    return [[STManager sharedInstance] getNotReadMsgCountByJid:jid WithRealJid:realJid];
}

- (NSInteger)getNotReadMsgCountByJid:(NSString *)jid WithRealJid:(NSString *)realJid withChatType:(ChatType)chatType {
    return [[STManager sharedInstance] getNotReadMsgCountByJid:jid WithRealJid:realJid withChatType:chatType];
}

- (void)updateAppNotReadCount {
    [[STManager sharedInstance] updateAppNotReadCount];
}

- (NSInteger)getAppNotReaderCount {
    return [[STManager sharedInstance] getAppNotReaderCount];
}

- (NSInteger)getNotRemindNotReaderCount {
    return [[STManager sharedInstance] getNotRemindNotReaderCount];
}

- (void)getExploreNotReaderCount {
    [[STManager sharedInstance] getExploreNotReaderCount];
}

- (void)getLeaveMsgNotReaderCountWithCallBack:(QIMKitGetLeaveMsgNotReaderCountBlock)callback {
    [[STManager sharedInstance] getLeaveMsgNotReaderCountWithCallBack:callback];
}

- (void)updateNotReadCountCacheByJid:(NSString *)jid WithRealJid:(NSString *)realJid {
    [[STManager sharedInstance] updateNotReadCountCacheByJid:jid WithRealJid:realJid];
}

- (void)updateMessageStateWithNewState:(QIMMessageSendState)state ByMsgIdList:(NSArray *)MsgIdList {
    [[STManager sharedInstance] updateMessageStateWithNewState:state ByMsgIdList:MsgIdList];
}

- (void)updateNotReadCountCacheByJid:(NSString *)jid {
    [[STManager sharedInstance] updateNotReadCountCacheByJid:jid];
}

- (void)saveChatId:(NSString *)chatId ForUserId:(NSString *)userId {
    [[STManager sharedInstance] saveChatId:chatId ForUserId:userId];
}

- (void)setMsgSentFaild {
    [[STManager sharedInstance] setMsgSentFaild];
}

- (NSDictionary *)parseMessageByMsgRaw:(id)msgRaw {
    return [[STManager sharedInstance] parseMessageByMsgRaw:msgRaw];
}

- (NSDictionary *)parseOriginMessageByMsgRaw:(id)msgRaw {
    return [[STManager sharedInstance] parseOriginMessageByMsgRaw:msgRaw];
}

- (NSArray *)getNotReadMsgIdListByUserId:(NSString *)userId WithRealJid:(NSString *)realJid {
    return [[STManager sharedInstance] getNotReadMsgIdListByUserId:userId WithRealJid:realJid];
}

- (void)getRemoteSearchMsgListByUserId:(NSString *)userId WithRealJid:(NSString *)realJid withVersion:(long long)lastUpdateTime withDirection:(QIMGetMsgDirection)direction WithLimit:(int)limit WithOffset:(int)offset WithComplete:(void (^)(NSArray *))complete {
    [[STManager sharedInstance] getRemoteSearchMsgListByUserId:userId WithRealJid:realJid withVersion:lastUpdateTime withDirection:direction WithLimit:limit WithOffset:offset WithComplete:complete];
}

- (void)getMsgListByUserId:(NSString *)userId WithRealJid:(NSString *)realJid WithLimit:(int)limit WithOffset:(int)offset withLoadMore:(BOOL)loadMore WithComplete:(void (^)(NSArray *))complete{
    [[STManager sharedInstance] getMsgListByUserId:userId WithRealJid:realJid WithLimit:limit WithOffset:offset withLoadMore:loadMore WithComplete:complete];
}

- (void)getMsgListByUserId:(NSString *)userId WithRealJid:(NSString *)realJid FromTimeStamp:(long long)timeStamp WithComplete:(void (^)(NSArray *))complete {
    [[STManager sharedInstance] getMsgListByUserId:userId WithRealJid:realJid FromTimeStamp:timeStamp WithComplete:complete];
}

- (void)getConsultServerMsgLisByUserId:(NSString *)userId WithVirtualId:(NSString *)virtualId WithLimit:(int)limit WithOffset:(int)offset withLoadMore:(BOOL)loadMore WithComplete:(void (^)(NSArray *))complete {
    [[STManager sharedInstance] getConsultServerMsgLisByUserId:userId WithVirtualId:virtualId WithLimit:limit WithOffset:offset withLoadMore:loadMore WithComplete:complete];
}

- (NSMutableArray *)searchLocalMessageByKeyword:(NSString *)keyWord XmppId:(NSString *)xmppid RealJid:(NSString *)realJid {
    return [[STManager sharedInstance] searchLocalMessageByKeyword:keyWord XmppId:xmppid RealJid:realJid];
}


#pragma mark - 本地消息搜索

- (NSArray *)getLocalMediasByXmppId:(NSString *)xmppId ByRealJid:(NSString *)realJid {
    return [[STManager sharedInstance] getLocalMediasByXmppId:xmppId ByRealJid:realJid];
}

- (NSArray *)getMsgsForMsgType:(NSArray *)msgTypes ByXmppId:(NSString *)xmppId ByReadJid:(NSString *)realJid {
    return [[STManager sharedInstance] getMsgsForMsgType:msgTypes ByXmppId:xmppId ByReadJid:realJid];
}

- (NSArray *)getMsgsByKeyWord:(NSString *)keyWork ByXmppId:(NSString *)xmppId ByReadJid:(NSString *)realJid {
    return [[STManager sharedInstance] getMsgsByKeyWord:keyWork ByXmppId:xmppId ByReadJid:realJid];
}

- (NSArray *)getMsgsForMsgType:(NSArray *)msgTypes ByXmppId:(NSString *)xmppId {
    return [[STManager sharedInstance] getMsgsForMsgType:msgTypes ByXmppId:xmppId];
}

@end
