//
//  QIMKit+QIMWorkFeed.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//

#import "QIMKit+QIMWorkFeed.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMWorkFeed)

- (NSArray *)getHotCommentUUIdsForMomentId:(NSString *)momentId {
    return [[STManager sharedInstance] getHotCommentUUIdsForMomentId:momentId];
}

- (void)setHotCommentUUIds:(NSArray *)hotCommentUUIds ForMomentId:(NSString *)momentId {
    [[STManager sharedInstance] setHotCommentUUIds:hotCommentUUIds ForMomentId:momentId];
}

- (void)removeHotCommentUUIdsForMomentId:(NSString *)momentId {
    [[STManager sharedInstance] removeHotCommentUUIdsForMomentId:momentId];
}

- (void)removeAllHotCommentUUIds {
    [[STManager sharedInstance] removeAllHotCommentUUIds];
}

- (void)updateLastWorkFeedMsgTime {
    [[STManager sharedInstance] updateLastWorkFeedMsgTime];
}

- (void)getRemoteMomentDetailWithMomentUUId:(NSString *)momentId withCallback:(QIMKitgetMomentDetailSuccessedBlock)callback {
    [[STManager sharedInstance] getRemoteMomentDetailWithMomentUUId:momentId withCallback:callback];
}

- (void)getAnonyMouseDicWithMomentId:(NSString *)momentId WithCallBack:(QIMKitgetAnonymouseSuccessedBlock)callback {
    [[STManager sharedInstance] getAnonyMouseDicWithMomentId:momentId WithCallBack:callback];
}

- (void)pushNewMomentWithMomentDic:(NSDictionary *)momentDic withCallBack:(QIMKitPushMomentSuccessedBlock)callback {
    [[STManager sharedInstance] pushNewMomentWithMomentDic:momentDic withCallBack:callback];
}

- (void)getMomentHistoryWithLastMomentId:(NSString *)momentId {
    [[STManager sharedInstance] getMomentHistoryWithLastMomentId:momentId];
}

- (void)deleteRemoteMomentWithMomentId:(NSString *)momentId {
    [[STManager sharedInstance] deleteRemoteMomentWithMomentId:momentId];
}

- (void)likeRemoteMomentWithMomentId:(NSString *)momentId withLikeFlag:(BOOL)likeFlag withCallBack:(QIMKitLikeContentSuccessedBlock)callback {
    [[STManager sharedInstance] likeRemoteMomentWithMomentId:momentId withLikeFlag:likeFlag withCallBack:callback];
}

- (void)likeRemoteCommentWithCommentId:(NSString *)commentId withSuperParentUUID:(NSString *)superParentUUID withMomentId:(NSString *)momentId withLikeFlag:(BOOL)likeFlag withCallBack:(QIMKitLikeContentSuccessedBlock)callback {
    [[STManager sharedInstance] likeRemoteCommentWithCommentId:commentId withSuperParentUUID:superParentUUID withMomentId:momentId withLikeFlag:likeFlag withCallBack:callback];
}

- (void)uploadCommentWithCommentDic:(NSDictionary *)commentDic {
    [[STManager sharedInstance] uploadCommentWithCommentDic:commentDic];
}

- (void)getRemoteRecentHotCommentsWithMomentId:(NSString *)momentId withHotCommentCallBack:(QIMKitWorkCommentBlock)callback {
    [[STManager sharedInstance] getRemoteRecentHotCommentsWithMomentId:momentId withHotCommentCallBack:callback];
}

- (void)getRemoteRecentNewCommentsWithMomentId:(NSString *)momentId withNewCommentCallBack:(QIMKitWorkCommentBlock)callback {
    [[STManager sharedInstance] getRemoteRecentNewCommentsWithMomentId:momentId withNewCommentCallBack:callback];
}

- (NSDictionary *)getWorkMomentWithMomentId:(NSString *)momentId {
    return [[STManager sharedInstance] getWorkMomentWithMomentId:momentId];
}

- (void)getWorkMomentWithLastMomentTime:(long long)lastMomentTime withUserXmppId:(NSString *)xmppId WithLimit:(int)limit WithOffset:(int)offset withFirstLocalMoment:(BOOL)firstLocal WithComplete:(void (^)(NSArray *))complete {
    [[STManager sharedInstance] getWorkMomentWithLastMomentTime:lastMomentTime withUserXmppId:xmppId WithLimit:limit WithOffset:offset withFirstLocalMoment:firstLocal WithComplete:complete];
}

- (void)getWorkMoreMomentWithLastMomentTime:(long long)lastMomentTime withUserXmppId:(NSString *)xmppId WithLimit:(int)limit WithOffset:(int)offset withFirstLocalMoment:(BOOL)firstLocal WithComplete:(void (^)(NSArray *))complete {
    [[STManager sharedInstance] getWorkMoreMomentWithLastMomentTime:lastMomentTime withUserXmppId:xmppId WithLimit:limit WithOffset:offset withFirstLocalMoment:firstLocal WithComplete:complete];
}

- (void)deleteRemoteCommentWithComment:(NSString *)commentId withPostUUId:(NSString *)postUUId withSuperParentUUId:(NSString *)superParentUUID withCallback:(QIMKitWorkCommentDeleteSuccessBlock)callback {
    [[STManager sharedInstance] deleteRemoteCommentWithComment:commentId withPostUUId:postUUId withSuperParentUUId:superParentUUID withCallback:callback];
}

//我的驼圈儿获取我的回复数据源
- (void)getRemoteOwnerCamelGetMyReplyWithCreateTime:(long long)createTime pageSize:(NSInteger)pageSize complete:(void (^)(NSArray *))complete{
    [[STManager sharedInstance] getRemoteOwnerCamelGetMyReplyWithCreateTime:createTime pageSize:pageSize complete:complete];
}

//我的驼圈儿获取我@我的数据源
- (void)getRemoteOwnerCamelGetAtListWithCreateTime:(long long)createTime pageSize:(NSInteger)pageSize complete:(void (^)(NSArray *))complete{
    [[STManager sharedInstance] getRemoteOwnerCamelGetAtListWithCreateTime:createTime pageSize:20 complete:complete];
}
#pragma mark - Remote Notice

- (void)updateRemoteWorkNoticeMsgReadStateWithTime:(long long)time {
    [[STManager sharedInstance] updateRemoteWorkNoticeMsgReadStateWithTime:time];
}

#pragma mark - Local Comment

- (void)getWorkCommentWithLastCommentRId:(NSInteger)lastCommentRId withMomentId:(NSString *)momentId WithLimit:(int)limit WithOffset:(int)offset withFirstLocalComment:(BOOL)firstLocal WithComplete:(void (^)(NSArray *))complete {
    [[STManager sharedInstance] getWorkCommentWithLastCommentRId:lastCommentRId withMomentId:momentId WithLimit:limit WithOffset:offset withFirstLocalComment:firstLocal WithComplete:complete];
}

- (NSArray *)getWorkChildCommentsWithParentCommentUUID:(NSString *)parentCommentUUID {
    return [[STManager sharedInstance] getWorkChildCommentsWithParentCommentUUID:parentCommentUUID];
}

#pragma mark - 驼圈提醒
- (BOOL)getLocalWorkMomentNotifyConfig {
    return [[STManager sharedInstance] getLocalWorkMomentNotifyConfig];
}

- (void)getRemoteWorkMomentSwitch {
    [[STManager sharedInstance] getRemoteWorkMomentSwitch];
}

- (void)updateRemoteWorkMomentNotifyConfig:(BOOL)flag withCallBack:(QIMKitUpdateMomentNotifyConfigSuccessedBlock)callback {
    [[STManager sharedInstance] updateRemoteWorkMomentNotifyConfig:flag withCallBack:callback];
}

#pragma mark - Search Moment

- (void)searchMomentWithKey:(NSString *)key withSearchTime:(long long)searchTime withStartNum:(NSInteger)startNum withPageNum:(NSInteger)pageNum withSearchType:(NSInteger)searchType  withCallBack:(QIMKitSearchMomentBlock)callback {
        [[STManager sharedInstance] searchMomentWithKey:key withSearchTime:searchTime withStartNum:startNum withPageNum:pageNum withSearchType:searchType withCallBack:callback];
    }

#pragma mark - Local NoticeMsg

- (void)getRemoteLastWorkMoment {
    [[STManager sharedInstance] getRemoteLastWorkMoment];
}

- (NSDictionary *)getLastWorkMoment {
    return [[STManager sharedInstance] getLastWorkMoment];
}

- (NSInteger)getWorkNoticeMessagesCountWithEventType:(NSArray *)eventTypes {
    return [[STManager sharedInstance] getWorkNoticeMessagesCountWithEventType:eventTypes];
}

- (BOOL)checkWorkMomentExistWithMomentId:(NSString *)momentId {
    return [[STManager sharedInstance] checkWorkMomentExistWithMomentId:momentId];
}

- (NSArray *)getWorkNoticeMessagesWithLimit:(int)limit WithOffset:(int)offset eventTypes:(NSArray *)eventTypes readState:(int)readState {
    return [[STManager sharedInstance] getWorkNoticeMessagesWithLimit:(int)limit WithOffset:(int)offset eventTypes:(NSArray *)eventTypes readState:(int)readState];
}

- (NSArray *)getWorkNoticeMessagesWithLimit:(int)limit WithOffset:(int)offset eventTypes:(NSArray *)eventTypes {
    return [[STManager sharedInstance] getWorkNoticeMessagesWithLimit:(int)limit WithOffset:(int)offset eventTypes:(NSArray *)eventTypes];
}

- (void)updateLocalWorkNoticeMsgReadStateWithTime:(long long)time {
    [[STManager sharedInstance] updateLocalWorkNoticeMsgReadStateWithTime:time];
}

@end
