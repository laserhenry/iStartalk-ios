//
//  QIMKit+QIMNetWork.m
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMNetWork.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMNetWork)

- (AppWorkState)appWorkState {
    return [[QIMManager sharedInstance] appWorkState];
}

#pragma mark - 网络状态监测

- (void)checkNetWorkWithCallBack:(QIMKitCheckNetWorkBlock)callback {
    [[QIMManager sharedInstance] checkNetWorkWithCallBack:callback];
}


- (void)checkNetworkStatus{
    [[QIMManager sharedInstance] checkNetworkStatus];
}

- (void)onNetworkChange:(NSNotification *)notify{
    
    [[QIMManager sharedInstance] onNetworkChange:notify];
}

- (void)updateAppWorkState:(AppWorkState)appWorkState {
    [[QIMManager sharedInstance] updateAppWorkState:appWorkState];
}

@end
