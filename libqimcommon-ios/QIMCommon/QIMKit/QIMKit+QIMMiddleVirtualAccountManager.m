//
//  QIMKit+QIMMiddleVirtualAccountManager.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMMiddleVirtualAccountManager.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMMiddleVirtualAccountManager)

- (NSArray *)getMiddleVirtualAccounts {
    return [[STManager sharedInstance] getMiddleVirtualAccounts];
}

- (BOOL)isMiddleVirtualAccountWithJid:(NSString *)jid {
    return [[STManager sharedInstance] isMiddleVirtualAccountWithJid:jid];
}

@end
