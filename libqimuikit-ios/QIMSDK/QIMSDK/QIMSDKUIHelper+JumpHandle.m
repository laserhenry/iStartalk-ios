//
//  QIMSDKUIHelper+JumpHandle.m
//  QIMSDK
//
//  Created by 李露 on 2018/9/29.
//  Copyright © 2018年 QIM. All rights reserved.
//

#import "QIMSDKUIHelper+JumpHandle.h"
#import "STJumpURLHandle.h"
#import "STFastEntrance.h"

@implementation STSDKUIHelper (JumpHandle)

- (BOOL)parseURL:(NSURL *)url {
    return [STJumpURLHandle parseURL:url];
}

- (void)sendMailWithRootVc:(UIViewController *)rootVc ByUserId:(NSString *)userId {
    [[STFastEntrance sharedInstance] sendMailWithRootVc:rootVc ByUserId:userId];
}

+ (void)openUserChatInfoByUserId:(NSString *)userId {
    [STFastEntrance openUserChatInfoByUserId:userId];
}

+ (void)openUserCardVCByUserId:(NSString *)userId {
    [STFastEntrance openUserCardVCByUserId:userId];
}

+ (void)openQIMGroupCardVCByGroupId:(NSString *)groupId {
    [STFastEntrance openQIMGroupCardVCByGroupId:groupId];
}

+ (void)openConsultChatByChatType:(NSInteger)chatType UserId:(NSString *)userId WithVirtualId:(NSString *)virtualId {
    [STFastEntrance openConsultChatByChatType:chatType UserId:userId WithVirtualId:virtualId];
}

+ (void)openSingleChatVCByUserId:(NSString *)userId {
    [STFastEntrance openSingleChatVCByUserId:userId];
}

+ (void)openGroupChatVCByGroupId:(NSString *)groupId {
    [STFastEntrance openGroupChatVCByGroupId:groupId];
}

+ (void)openHeaderLineVCByJid:(NSString *)jid {
    [STFastEntrance openHeaderLineVCByJid:jid];
}

+ (void)openQIMRNVCWithModuleName:(NSString *)moduleName WithProperties:(NSDictionary *)properties {
    [STFastEntrance openQIMRNVCWithModuleName:moduleName WithProperties:properties];
}

+ (void)openRobotCard:(NSString *)robotJId {
    [STFastEntrance openRobotCard:robotJId];
}

+ (void)openWebViewWithHtmlStr:(NSString *)htmlStr showNavBar:(BOOL)showNavBar {
    [STFastEntrance openWebViewWithHtmlStr:htmlStr showNavBar:showNavBar];
}

+ (void)openWebViewForUrl:(NSString *)url showNavBar:(BOOL)showNavBar {
    [STFastEntrance openWebViewForUrl:url showNavBar:showNavBar];
}

+ (void)openUserMedalFlutterWithUserId:(NSString *)userId {
    [STFastEntrance openUserMedalFlutterWithUserId:userId];
}

+ (void)openRNSearchVC {
    [STFastEntrance openRNSearchVC];
}

+ (void)openUserFriendsVC {
    [STFastEntrance openUserFriendsVC];
}

+ (void)openQIMGroupListVC {
    [STFastEntrance openQIMGroupListVC];
}

+ (void)openNotReadMessageVC {
    [STFastEntrance openNotReadMessageVC];
}

+ (void)openQIMPublicNumberVC {
    [STFastEntrance openQIMPublicNumberVC];
}

+ (void)openMyFileVC {
    [STFastEntrance openMyFileVC];
}

+ (void)openOrganizationalVC {
    [STFastEntrance openOrganizationalVC];
}

+ (void)openQRCodeVC {
    [STFastEntrance openQRCodeVC];
}

+ (void)openRobotChatVC:(NSString *)robotJid {
    [STFastEntrance openRobotChatVC:robotJid];
}

+ (void)openQTalkNotesVC {
    [STFastEntrance openQTalkNotesVC];
}

+ (void)openTransferConversation:(NSString *)shopId withVistorId:(NSString *)realJid {
    [STFastEntrance openTransferConversation:shopId withVistorId:realJid];
}

+ (void)openMyAccountInfo {
    [STFastEntrance openMyAccountInfo];
}

+ (void)showQRCodeWithQRId:(NSString *)qrId withType:(NSInteger)qrcodeType {
    [STFastEntrance showQRCodeWithQRId:qrId withType:qrcodeType];
}

+ (void)signOut {
    [STFastEntrance signOut];
}

+ (void)signOutWithNoPush {
    [STFastEntrance signOutWithNoPush];
}

@end
