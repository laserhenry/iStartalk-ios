
//
//  QIMKit+QIMConsult.m
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMConsult.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMConsult)

- (NSArray *)getAllHotLines {
    return [[STManager sharedInstance] getAllHotLines];
}

- (NSArray *)getMyhotLinelist {
    return [[STManager sharedInstance] getMyhotLinelist];
}

/**
 发送Consult消息
 
 @param msgId MsgId
 @param msg 消息Body内容
 @param info 消息ExtendInfo
 @param toJid 消息
 @param realToJid 真实RealJid
 @param chatType 会话类型
 @param msgType 消息类型
 @return 消息对象Message
 */
- (STMsgModel *)sendConsultMessageId:(NSString *)msgId WithMessage:(NSString *)msg WithInfo:(NSString *)info toJid:(NSString *)toJid realToJid:(NSString *)realToJid WithChatType:(ChatType)chatType WithMsgType:(int)msgType {
    return [[STManager sharedInstance] sendConsultMessageId:msgId WithMessage:msg WithInfo:info toJid:toJid realToJid:realToJid WithChatType:chatType WithMsgType:msgType];
}

/**
 获取远程的热线账号列表
 */
- (void)getRemoteHotlineShopList {
    [[STManager sharedInstance] getRemoteHotlineShopList];
}

//V2版获取客服坐席列表：支持多店铺
- (void)getSeatSeStatusWithCallback:(QIMKitGetSeatSeStatusBlock)callback {
    [[STManager sharedInstance] getSeatSeStatusWithCallback:callback];
}

//V2版区别Shop来设置服务模式upSeatSeStatusWithSid.qunar

/**
 根据店铺Id 设置服务模式
 
 @param shopId 店铺Id
 @param shopServiceStatus 服务模式
 @return 是否设置成功
 */
- (void)updateSeatSeStatusWithShopId:(NSInteger)shopId WithStatus:(NSInteger)shopServiceStatus withCallBack:(QIMKitUpdateSeatSeStatusBlock)callback {
    [[STManager sharedInstance] updateSeatSeStatusWithShopId:shopId WithStatus:shopServiceStatus withCallBack:callback];
}

/**
 根据服务模式获取基础信息
 
 @param userStatus 服务模式
 */
- (NSDictionary *)userSeatStatusDict:(int)userStatus {
    return [[STManager sharedInstance] userSeatStatusDict:userStatus];
}

- (NSString *)userStatusTitleWithStatus:(int)userStatus {
    return [[STManager sharedInstance] userStatusTitleWithStatus:userStatus];
}

/**
 获取状态坐席状态列表
 */
- (NSArray *)availableUserSeatStatus {
    return [[STManager sharedInstance] availableUserSeatStatus];
}

/**
 关闭会话
 
 @param shopId ShopId
 @param visitorId 客人Id
 @return 关闭之后的提示语
 */
- (void)closeSessionWithShopId:(NSString *)shopId WithVisitorId:(NSString *)visitorId withBlock:(QIMCloseSessionBlock)block {
    [[STManager sharedInstance] closeSessionWithShopId:shopId WithVisitorId:visitorId withBlock:block];
}

- (void)getConsultServerMsgLisByUserId:(NSString *)userId WithVirtualId:(NSString *)virtualId WithLimit:(int)limit WithOffset:(int)offset withLoadMore:(BOOL)loadMore WithComplete:(void (^)(NSArray *))complete {
    [[STManager sharedInstance] getConsultServerMsgLisByUserId:userId WithVirtualId:virtualId WithLimit:limit WithOffset:offset withLoadMore:loadMore WithComplete:complete];
}

@end
