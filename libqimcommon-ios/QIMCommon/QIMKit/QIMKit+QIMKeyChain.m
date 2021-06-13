//
//  QIMKit+QIMKeyChain.m
//  qunarChatIphone
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMKeyChain.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMKeyChain)

+ (void)updateSessionListToKeyChain {
    [QIMManager updateSessionListToKeyChain];
}

+ (void)updateGroupListToKeyChain {
    [QIMManager updateGroupListToKeyChain];
}

+ (void)updateFriendListToKeyChain {
    [QIMManager updateFriendListToKeyChain];
}

+ (void)updateRequestFileURL {
    [QIMManager updateRequestFileURL];
}

+ (void)updateRequestURL {
    [QIMManager updateRequestURL];
}

+ (void)updateNewHttpRequestURL {
    [QIMManager updateNewHttpRequestURL];
}

+ (void)updateRequestDomain {
    [QIMManager updateRequestDomain];
}

@end
