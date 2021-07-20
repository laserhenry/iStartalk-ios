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
    [STManager updateSessionListToKeyChain];
}

+ (void)updateGroupListToKeyChain {
    [STManager updateGroupListToKeyChain];
}

+ (void)updateFriendListToKeyChain {
    [STManager updateFriendListToKeyChain];
}

+ (void)updateRequestFileURL {
    [STManager updateRequestFileURL];
}

+ (void)updateRequestURL {
    [STManager updateRequestURL];
}

+ (void)updateNewHttpRequestURL {
    [STManager updateNewHttpRequestURL];
}

+ (void)updateRequestDomain {
    [STManager updateRequestDomain];
}

@end
