//
//  QIMKit+QIMHelper.h
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMHelper)

/**
 红包提示音
 */
- (void)playHongBaoSound;

/**
 新消息提示音
 */
- (void)playSound;

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

/**
 窗口抖动
 */
- (void)shockWindow;

@end
