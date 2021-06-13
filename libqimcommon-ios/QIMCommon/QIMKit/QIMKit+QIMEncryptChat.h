//
//  QIMKit+QIMEncryptChat.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMEncryptChat)

- (void)sendEncryptionChatWithType:(int)type WithBody:(NSString *)body ToJid:(NSString *)jid;

@end
