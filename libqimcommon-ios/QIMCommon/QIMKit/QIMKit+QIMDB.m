//
//  QIMKit+QIMDB.m
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMDB.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMDB)

- (NSString *)getDBPathWithUserXmppId:(NSString *)userJid {
    return [[QIMManager sharedInstance] getDBPathWithUserXmppId:userJid];
}

- (void)removeDataBase {
    //关闭数据库
    [[QIMManager sharedInstance] removeDataBase];
}

- (void)closeDataBase {
    QIMWarnLog(@"关闭数据库");
    [[QIMManager sharedInstance] closeDataBase];
}

- (void)clearDataBase {
    //清理数据库
    [[QIMManager sharedInstance] clearDataBase];
}

@end
