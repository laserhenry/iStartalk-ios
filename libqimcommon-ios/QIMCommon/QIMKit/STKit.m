//
//  QIMKit.m
//  QIMCommon
//
//  Created by 李露 on 2018/4/19.
//  Copyright © 2018年 QIMKit. All rights reserved.
//

#import "STKit.h"
#import "QIMPrivateHeader.h"
#import "Message.pb.h"
#import "AvoidCrash.h"

@implementation STKit

static STKit *__global_QIMKit = nil;

+ (STKit *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __global_QIMKit = [[STKit alloc] init];
    });
    return __global_QIMKit;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initQIMKit];
    }
    return self;
}

- (void)initQIMKit {
    QIMInfoLog(@"QIMKit initialize");
    [QIMFilteredProtocol start];
    [STManager sharedInstance];
    [AvoidCrash makeAllEffective];
    NSArray *noneSelClassStrings = @[
                                     @"NSNull",
                                     @"NSNumber",
                                     @"NSString",
                                     @"NSMutableString",
                                     @"NSDictionary",
                                     @"NSMutableDictionary",
                                     @"NSArray",
                                     @"NSMutableArray"
                                     ];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
    [AvoidCrash avoidCrashExchangeMethodIfDealWithNoneSel:YES];
//    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
}

- (void)dealwithCrashMessage:(NSNotification *)note {
    //注意:所有的信息都在userInfo中
    QIMErrorLog(@"QIMKit dealwithCrashMessage : %@",note.userInfo);
}

- (void)clearSTManager {
    [[STManager sharedInstance] clearSTManager];
}

- (NSMutableDictionary *)timeStempDic {
    return [[STManager sharedInstance] timeStempDic];
}

- (dispatch_queue_t)getLastQueue {
    return [[STManager sharedInstance] lastQueue];
}

- (dispatch_queue_t)getLoadSessionNameQueue {
    return [[[STManager sharedInstance] load_session_name] queue];
}

- (dispatch_queue_t)getLoadHeaderImageQueue {
    return [[[STManager sharedInstance] load_user_header] queue];
}

- (dispatch_queue_t)getLoadSessionContentQueue {
    return [[[STManager sharedInstance] load_session_content] queue];
}

- (dispatch_queue_t)getLoadSessionUnReadCountQueue {
    return [[[STManager sharedInstance] load_session_unreadcount] queue];
}

- (dispatch_queue_t)getLoadGroupCardFromDBQueue {
    return [[[STManager sharedInstance] load_groupDB_VCard] queue];
}

- (dispatch_queue_t)getLoadMsgNickNameQueue {
    return [[[STManager sharedInstance] load_msgNickName] queue];
}

- (dispatch_queue_t)getLoadMsgMedalListQueue {
    return [[[STManager sharedInstance] load_msgMedalList] queue];
}

- (dispatch_queue_t)getLoad_msgHeaderImageQueue {
    return [[[STManager sharedInstance] load_msgHeaderImage] queue];
}

- (NSString *)getOpsFoundRNDebugUrl {
    return [[STManager sharedInstance] opsFoundRNDebugUrl];
}

- (void)setOpsFoundRNDebugUrl:(NSString *)opsFoundRNDebugUrl {
    [[STManager sharedInstance] setOpsFoundRNDebugUrl:opsFoundRNDebugUrl];
}

- (NSString *)qtalkFoundRNDebugUrl {
    return [[STManager sharedInstance] qtalkFoundRNDebugUrl];
}

- (void)setQtalkFoundRNDebugUrl:(NSString *)qtalkFoundRNDebugUrl {
    [[STManager sharedInstance] setQtalkFoundRNDebugUrl:qtalkFoundRNDebugUrl];
}

- (NSString *)qtalkSearchRNDebugUrl {
    return [[STManager sharedInstance] qtalkSearchRNDebugUrl];
}

- (void)setQtalkSearchRNDebugUrl:(NSString *)qtalkSearchRNDebugUrl {
    [[STManager sharedInstance] setQtalkSearchRNDebugUrl:qtalkSearchRNDebugUrl];
}

- (NSString *)getImagerCache {
    return [[STManager sharedInstance] getImagerCache];
}

- (NSString *)updateRemoteLoginKey {
    return [[STManager sharedInstance] updateRemoteLoginKey];
}

@end

@implementation STKit (Common)

- (NSData *)updateOrganizationalStructure {
    return [[STManager sharedInstance] updateOrganizationalStructure];
}

@end

@implementation STKit (CommonConfig)

- (NSString *)remoteKey {
    return [[STManager sharedInstance] remoteKey];
}

- (NSString *)myRemotelogginKey {
    return [[STManager sharedInstance] myRemotelogginKey];
}

- (NSString *) thirdpartKeywithValue {
    return [[STManager sharedInstance] thirdpartKeywithValue];
}

- (void)setIsMerchant:(BOOL)isMerchant {
    [[STManager sharedInstance] setIsMerchant:isMerchant];
}

- (BOOL)isMerchant {
    return [[STManager sharedInstance] isMerchant];
}

+ (NSString *)getLastUserName {
    return [STManager getLastUserName];
}

/**
 更新最后一个登录用户的临时Token
 
 @param token 用户token
 */
- (void)updateLastTempUserToken:(NSString *)token {
    [[STManager sharedInstance] updateLastTempUserToken:token];
}

/**
 获取最后一个登录用户的临时Token
 
 @return 用户token
 */
- (NSString *)getLastTempUserToken {
    return [[STManager sharedInstance] getLastTempUserToken];
}

/**
 更新最后一个登录用户的token
 
 @param tempUserToken 用户token
 */
- (void)updateLastUserToken:(NSString *)tempUserToken {
    [[STManager sharedInstance] updateLastUserToken:tempUserToken];
}

/**
 获取最后一个登录用户的token
 
 @return 用户token
 */
- (NSString *)getLastUserToken {
    return [[STManager sharedInstance] getLastUserToken];
}

- (NSString *)getLastPassword {
    return [[STManager sharedInstance] getLastPassword];
}

- (NSString *)getLastJid {
    return [[STManager sharedInstance] getLastJid];
}

- (NSString *)getMyNickName {
    return [[STManager sharedInstance] getMyNickName];
}

- (NSString *)getDomain {
    return [[STManager sharedInstance] getDomain];
}

- (long long)getCurrentServerTime {
    return [[STManager sharedInstance] getCurrentServerTime];
}

- (int)getServerTimeDiff {
    return [[STManager sharedInstance] getServerTimeDiff];
}

- (NSHTTPCookie *)cookie {
    return [[STManager sharedInstance] cookie];
}

// 更新导航配置
- (void)updateNavigationConfig {
    [[STManager sharedInstance] updateNavigationConfig];
}

- (void)checkClientConfig {
    [[STManager sharedInstance] checkClientConfig];
}

- (NSArray *)trdExtendInfo {
    return [[STManager sharedInstance] trdExtendInfo];
}

- (NSString *)aaCollectionUrlHost {
    return [[STManager sharedInstance] aaCollectionUrlHost];
}

- (NSString *)redPackageUrlHost {
    return [[STManager sharedInstance] redPackageUrlHost];
}

- (NSString *)redPackageBalanceUrl {
    return [[STManager sharedInstance] redPackageBalanceUrl];
}

- (NSString *)myRedpackageUrl {
    return [[STManager sharedInstance] myRedpackageUrl];
}

#pragma mark get user agent
- (NSString *)getDefaultUserAgentString {
    return [[STManager sharedInstance] getDefaultUserAgentString];
}

- (BOOL)isNewMsgNotify {
    return [[STManager sharedInstance] isNewMsgNotify];
}

- (void)setNewMsgNotify:(BOOL)flag {
    [[STManager sharedInstance] setNewMsgNotify:flag];
}

- (BOOL)pickerPixelOriginal {
    return [[STManager sharedInstance] pickerPixelOriginal];
}

- (void)setPickerPixelOriginal:(BOOL)flag {
    [[STManager sharedInstance] setPickerPixelOriginal:flag];
}

- (BOOL)moodshow {
    return [[STManager sharedInstance] moodshow];
}

- (void)setMoodshow:(BOOL)flag {
    [[STManager sharedInstance] setMoodshow:flag];
}

//是否展示水印
- (BOOL)waterMarkState {
    return [[STManager sharedInstance] waterMarkState];
}

- (void)setWaterMarkState:(BOOL)flag {
    [[STManager sharedInstance] setWaterMarkState:flag];
}

//艾特消息
- (NSArray *)getHasAtMeByJid:(NSString *)jid  {
    return [[STManager sharedInstance] getHasAtMeByJid:jid];
}

- (void)updateAtMeMessageWithJid:(NSString *)groupId withMsgIds:(NSArray *)msgIds withReadState:(QIMAtMsgReadState)readState {
    [[STManager sharedInstance] updateAtMeMessageWithJid:groupId withMsgIds:msgIds withReadState:readState];
}

- (void)clearAtMeMessageWithJid:(NSString *)groupId {
    [[STManager sharedInstance] clearAtMeMessageWithJid:groupId];
}

- (void)addOfflineAtMeMessageByJid:(NSString *)groupId withType:(QIMAtType)atType withMsgId:(NSString *)msgId withMsgTime:(long long)msgTime {
    [[STManager sharedInstance] addOfflineAtMeMessageByJid:groupId withType:atType withMsgId:msgId withMsgTime:msgTime];
}

- (void)addAtMeMessageByJid:(NSString *)groupId withType:(QIMAtType)atType withMsgId:(NSString *)msgId withMsgTime:(long long)msgTime {
    [[STManager sharedInstance] addAtMeMessageByJid:groupId withType:atType withMsgId:msgId withMsgTime:msgTime];
}

//输入框草稿
- (NSDictionary *)getNotSendTextByJid:(NSString *)jid {
    return [[STManager sharedInstance] getNotSendTextByJid:jid];
}

- (void)setNotSendText:(NSString *)text inputItems:(NSArray *)inputItems ForJid:(NSString *)jid {
    [[STManager sharedInstance] setNotSendText:text inputItems:inputItems ForJid:jid];
}

- (void)getQChatTokenWithBusinessLineName:(NSString *)businessLineName withCallBack:(QIMKitGetQChatTokenSuccessBlock)callback {
    [[STManager sharedInstance] getQChatTokenWithBusinessLineName:businessLineName withCallBack:callback];
}

- (NSDictionary *)getQVTForQChat {
    return [[STManager sharedInstance] getQVTForQChat];
}

- (void)removeQVTForQChat {
    [[STManager sharedInstance] removeQVTForQChat];
}

- (NSString *)getDownloadFilePath {
    return [[STManager sharedInstance] getDownloadFilePath];
}

- (void)clearcache {
    [[STManager sharedInstance] clearcache];
}

- (void)setStickWithCombineJid:(NSString *)combineJid WithChatType:(ChatType)chatType withCallback:(QIMKitUpdateRemoteClientConfig)callback {
    [[STManager sharedInstance] setStickWithCombineJid:combineJid WithChatType:chatType withCallback:callback];
}

- (void)removeStickWithCombineJid:(NSString *)jid WithChatType:(ChatType)chatType withCallback:(QIMKitUpdateRemoteClientConfig)callback{
    [[STManager sharedInstance] removeStickWithCombineJid:jid WithChatType:chatType withCallback:callback];
}

- (BOOL)isStickWithCombineJid:(NSString *)jid {
    return [[STManager sharedInstance] isStickWithCombineJid:jid];
}

- (NSDictionary *)stickList {
    return [[STManager sharedInstance] stickList];
}

- (void)setMsgNotifySettingWithIndex:(QIMMSGSETTING)setting WithSwitchOn:(BOOL)switchOn withCallBack:(QIMKitSetMsgNotifySettingSuccessBlock)callback {
    [[STManager sharedInstance] setMsgNotifySettingWithIndex:setting WithSwitchOn:switchOn withCallBack:callback];
}

- (BOOL)getLocalMsgNotifySettingWithIndex:(QIMMSGSETTING)setting {
    return [[STManager sharedInstance] getLocalMsgNotifySettingWithIndex:setting];
}

- (void)getMsgNotifyRemoteSettings {
    [[STManager sharedInstance] getMsgNotifyRemoteSettings];
}

#pragma mark - kNotificationSetting

- (void)sendNoPush {
    [[STManager sharedInstance] sendNoPush];
}

- (void)sendServer:(NSString *)notificationToken withUsername:(NSString *)username withParamU:(NSString *)paramU withParamK:(NSString *)paramK WithDelete:(BOOL)deleteFlag withCallback:(QIMKitRegisterPushTokenSuccessBlock)callback {
    [[STManager sharedInstance] sendServer:notificationToken withUsername:username withParamU:paramU withParamK:paramK WithDelete:deleteFlag withCallback:callback];
}

- (void)sendPushTokenWithMyToken:(NSString *)myToken WithDeleteFlag:(BOOL)deleteFlag withCallback:(QIMKitRegisterPushTokenSuccessBlock)callback {
    [[STManager sharedInstance] sendPushTokenWithMyToken:myToken WithDeleteFlag:deleteFlag withCallback:callback];
}

- (void)checkClearCache {
    [[STManager sharedInstance] checkClearCache];
}

@end
