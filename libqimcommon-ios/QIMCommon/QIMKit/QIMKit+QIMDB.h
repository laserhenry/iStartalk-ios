//
//  QIMKit+QIMDB.h
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMDB)

- (NSString *)getDBPathWithUserXmppId:(NSString *)userJid;
/**
 清空数据库文件
 */
- (void)removeDataBase;

/**
 关闭数据库
 */
- (void)closeDataBase;

/**
 清空数据库
 */
- (void)clearDataBase;

@end
