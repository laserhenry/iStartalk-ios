//
//  QIMSDKUIHelper+BaseUI.m
//  QIMSDK
//
//  Created by 李露 on 2018/9/29.
//  Copyright © 2018年 QIM. All rights reserved.
//

#import "QIMSDKUIHelper+BaseUI.h"
#import "QIMKitPublicHeader.h"
#import "STFastEntrance.h"
#import "STAppWindowMgr.h"

@implementation STSDKUIHelper (BaseUI)

- (void)launchMainControllerWithWindow:(UIWindow *)window {
    [[STFastEntrance sharedInstance] launchMainControllerWithWindow:window];
}

- (void)launchMainAdvertWindow {
    [[STFastEntrance sharedInstance] launchMainAdvertWindow];
}

- (UIView *)getQIMSessionListViewWithBaseFrame:(CGRect)frame {
    return [[STFastEntrance sharedInstance] getQIMSessionListViewWithBaseFrame:frame];
}

- (UIViewController *)getUserChatInfoByUserId:(NSString *)userId {
    return [[STFastEntrance sharedInstance] getUserChatInfoByUserId:userId];
}

- (UIViewController *)getUserCardVCByUserId:(NSString *)userId {
    return [[STFastEntrance sharedInstance] getUserCardVCByUserId:userId];
}

- (UIViewController *)getQIMGroupCardVCByGroupId:(NSString *)groupId {
    return [[STFastEntrance sharedInstance] getQIMGroupCardVCByGroupId:groupId];
}

- (UIViewController *)getConsultChatByChatType:(NSInteger)chatType UserId:(NSString *)userId WithVirtualId:(NSString *)virtualId {
    return [[STFastEntrance sharedInstance] getConsultChatByChatType:chatType UserId:userId WithVirtualId:virtualId];
}

- (UIViewController *)getSingleChatVCByUserId:(NSString *)userId {
    return [[STFastEntrance sharedInstance] getSingleChatVCByUserId:userId];
}

- (UIViewController *)getGroupChatVCByGroupId:(NSString *)groupId {
    return [[STFastEntrance sharedInstance] getGroupChatVCByGroupId:groupId];
}

- (UIViewController *)getHeaderLineVCByJid:(NSString *)jid {
    return [[STFastEntrance sharedInstance] getHeaderLineVCByJid:jid];
}

- (UIViewController *)getVCWithNavigation:(UINavigationController *)navVC
                            WithHiddenNav:(BOOL)hiddenNav
                               WithModule:(NSString *)module
                           WithProperties:(NSDictionary *)properties {
    return [[STFastEntrance sharedInstance] getVCWithNavigation:navVC WithHiddenNav:hiddenNav WithModule:module WithProperties:properties];
}

- (UIViewController *)getRobotCard:(NSString *)robotJid {
    return [[STFastEntrance sharedInstance] getRobotCard:robotJid];
}

- (UIViewController *)getRNSearchVC {
    return [[STFastEntrance sharedInstance] getRNSearchVC];
}

- (UIViewController *)getUserFriendsVC {
    return [[STFastEntrance sharedInstance] getUserFriendsVC];
}

- (UIViewController *)getQIMGroupListVC {
    return [[STFastEntrance sharedInstance] getQIMGroupListVC];
}

- (UIViewController *)getNotReadMessageVC {
    return [[STFastEntrance sharedInstance] getNotReadMessageVC];
}

- (UIViewController *)getQIMPublicNumberVC {
    return [[STFastEntrance sharedInstance] getQIMPublicNumberVC];
}

- (UIViewController *)getMyFileVC {
    return [[STFastEntrance sharedInstance] getMyFileVC];
}

- (UIViewController *)getOrganizationalVC {
    return [[STFastEntrance sharedInstance] getOrganizationalVC];
}

- (UIViewController *)getRobotChatVC:(NSString *)robotJid {
    return [[STFastEntrance sharedInstance] getRobotChatVC:robotJid];
}

- (UIViewController *)getQTalkNotesVC {
    return [[STFastEntrance sharedInstance] getQTalkNotesVC];
}

- (UIViewController *)getMyRedPack {
    return [[STFastEntrance sharedInstance] getMyRedPack];
}

- (UIViewController *)getMyRedPackageBalance {
    return [[STFastEntrance sharedInstance] getMyRedPackageBalance];
}

- (UIViewController *)getQRCodeWithQRId:(NSString *)qrId withType:(NSInteger)qrcodeType {
    return [[STFastEntrance sharedInstance] getQRCodeWithQRId:qrId withType:qrcodeType];
}

- (UIViewController *)getContactSelectionVC:(STMsgModel *)msg withExternalForward:(BOOL)externalForward {
    return [[STFastEntrance sharedInstance] getContactSelectionVC:msg withExternalForward:externalForward];
}

@end
