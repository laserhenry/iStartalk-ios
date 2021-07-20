//
//  QIMManager+Helper.h
//  qunarChatIphone
//
//  Created by 李露 on 2018/4/3.
//

#import "STManager.h"

@interface STManager (Helper)

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
