//
//  QIMKit+QIMEncryptChat.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMEncryptChat.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMEncryptChat)

- (void)sendEncryptionChatWithType:(int)type WithBody:(NSString *)body ToJid:(NSString *)jid {
    [[STManager sharedInstance] sendEncryptionChatWithType:type WithBody:body ToJid:jid];
}

@end
