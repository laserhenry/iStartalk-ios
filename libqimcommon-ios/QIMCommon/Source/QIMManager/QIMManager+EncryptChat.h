//
//  QIMManager+EncryptChat.h
//  QIMCommon
//
//  Created by 李露 on 2018/6/11.
//  Copyright © 2018年 QIMKit. All rights reserved.
//

#import "STManager.h"

@interface STManager (EncryptChat)

- (void)sendEncryptionChatWithType:(int)type WithBody:(NSString *)body ToJid:(NSString *)jid;

@end
