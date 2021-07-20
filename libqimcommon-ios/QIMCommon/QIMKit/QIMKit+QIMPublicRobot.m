//
//  QIMKit+QIMPublicRobot.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMPublicRobot.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMPublicRobot)

- (int)getDealIdState:(NSString *)dealId {
    return [[STManager sharedInstance] getDealIdState:dealId];
}

- (void)setDealId:(NSString *)dealId ForState:(int)state {
    [[STManager sharedInstance]setDealId:dealId ForState:state];
}

#pragma mark - 公众号名片信息

- (UIImage *)getPublicNumberHeaderImageByFileName:(NSString *)fileName {
    return [[STManager sharedInstance] getPublicNumberHeaderImageByFileName:fileName];
}

- (NSString *)getPublicNumberDefaultHeaderPath {
    return [[STManager sharedInstance] getPublicNumberDefaultHeaderPath];
}

- (NSDictionary *)getPublicNumberCardByJid:(NSString *)publicNumberId {
    return [[STManager sharedInstance] getPublicNumberCardByJid:publicNumberId];
}

- (void)updatePublicNumberCardByIds:(NSArray *)publicNumberIdList WithNeedUpdate:(BOOL)flag withCallBack:(QIMKitUpdatePublicNumberCardCallBack)callback {
    [[STManager sharedInstance] updatePublicNumberCardByIds:publicNumberIdList WithNeedUpdate:flag withCallBack:callback];
}

#pragma mark - sss

- (NSArray *)getPublicNumberList {
    return [[STManager sharedInstance] getPublicNumberList];
}

- (void)updatePublicNumberList {
    [[STManager sharedInstance] updatePublicNumberList];
}

- (void)focusOnPublicNumberId:(NSString *)publicNumberId withCallBack:(QIMKitFocusPublicNumberCallBack)callback {
    [[STManager sharedInstance] focusOnPublicNumberId:publicNumberId withCallBack:callback];
}

- (void)cancelFocusOnPublicNumberId:(NSString *)publicNumberId withCallBack:(QIMKitCancelFocusPublicNumberCallBack)callback {
    [[STManager sharedInstance] cancelFocusOnPublicNumberId:publicNumberId withCallBack:callback];
}

#pragma mark - 公众号消息

- (STMsgModel *)createPublicNumberMessageWithMsg:(NSString *)msg extenddInfo:(NSString *)extendInfo publicNumberId:(NSString *)publicNumberId msgType:(PublicNumberMsgType)msgType {
    return [[STManager sharedInstance] createPublicNumberMessageWithMsg:msg extenddInfo:extendInfo publicNumberId:publicNumberId msgType:msgType];
}

- (STMsgModel *)sendMessage:(NSString *)msg ToPublicNumberId:(NSString *)publicNumberId WithMsgId:(NSString *)msgId WithMsgType:(int)msgType {
    return [[STManager sharedInstance] sendMessage:msg ToPublicNumberId:publicNumberId WithMsgId:msgId WithMsgType:msgType];
}

- (NSArray *)getPublicNumberMsgListById:(NSString *)publicNumberId WithLimit:(int)limit WithOffset:(int)offset {
    return [[STManager sharedInstance] getPublicNumberMsgListById:publicNumberId WithLimit:limit WithOffset:offset];
}

- (void)clearNotReadMsgByPublicNumberId:(NSString *)jid {
    [[STManager sharedInstance] clearNotReadMsgByPublicNumberId:jid];
}

- (void)setNotReaderMsgCount:(int)count ForPublicNumberId:(NSString *)jid {
    [[STManager sharedInstance] setNotReaderMsgCount:count ForPublicNumberId:jid];
}

- (int)getNotReaderMsgCountByPublicNumberId:(NSString *)jid {
    return [[STManager sharedInstance] getNotReaderMsgCountByPublicNumberId:jid];
}

- (void)checkPNMsgTimeWithJid:(NSString *)jid WithMsgDate:(long long)msgDate {
    [[STManager sharedInstance] checkPNMsgTimeWithJid:jid WithMsgDate:msgDate];
}

- (void)searchRobotByKeyStr:(NSString *)keyStr withCallBack:(QIMKitSearchRobotByKeyStrCallBack)callback {
    [[STManager sharedInstance] searchRobotByKeyStr:keyStr withCallBack:callback];
}

@end
