//
//  QIMManager+MiddleVirtualAccountManager.m
//  QIMCommon
//
//  Created by 李露 on 10/30/18.
//  Copyright © 2018 QIM. All rights reserved.
//

#import "QIMManager+MiddleVirtualAccountManager.h"

@implementation STManager (MiddleVirtualAccountManager)

- (NSArray *)getMiddleVirtualAccounts {
    NSString *fileTransId = [NSString stringWithFormat:@"%@@%@", @"file-transfer", [[STManager sharedInstance] getDomain]];
    NSString *dujiaId = [NSString stringWithFormat:@"%@@%@", @"dujia_warning", [[STManager sharedInstance] getDomain]];
    NSString *qtalktips = [NSString stringWithFormat:@"%@@%@", @"qtalktips", [[STManager sharedInstance] getDomain]];
    NSString *icrobot = [NSString stringWithFormat:@"%@@%@", @"ic-robot", [[STManager sharedInstance] getDomain]];
    NSString *worknotice = [NSString stringWithFormat:@"%@@%@", @"worknotice", [[STManager sharedInstance] getDomain]];
//    NSString *myId = [[QIMManager sharedInstance] getLastJid];
    return @[fileTransId, dujiaId, qtalktips, icrobot, worknotice];
}

- (BOOL)isMiddleVirtualAccountWithJid:(NSString *)jid {
    if (jid.length <= 0) {
        return NO;
    }
    if ([[self getMiddleVirtualAccounts] containsObject:jid]) {
        return YES;
    }
    return NO;
}

@end
