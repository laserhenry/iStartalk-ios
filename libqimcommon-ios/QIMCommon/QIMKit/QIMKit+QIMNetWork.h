//
//  QIMKit+QIMNetWork.h
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"
#import "QIMCommonEnum.h"

@interface STKit (QIMNetWork)


/**
 获取当前网络状态

 @return appWorkState
 */
- (AppWorkState)appWorkState;


/**
 检查网络是否能够连接到互联网

 @return YES / NO
 */
- (void)checkNetWorkWithCallBack:(QIMKitCheckNetWorkBlock)callback;


/**
 检查用户是否掉线，是否需要重新登录
 */
- (void)checkNetworkStatus;


/**
 接收网络变更通知

 @param notify 网络变更通知
 */
- (void)onNetworkChange:(NSNotification *)notify;


/**
 更新当前网络状态

 @param appWorkState 网络状态
 */
- (void)updateAppWorkState:(AppWorkState)appWorkState;

@end
