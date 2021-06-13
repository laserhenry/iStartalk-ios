//
//  QIMKit+QIMSystemMessage.h
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMSystemMessage)

- (void)checkHeadlineMsg;

- (void)updateLastSystemMsgTime;

- (void)updateOfflineSystemNoticeMessages;

- (void)getSystemMsgLisByUserId:(NSString *)userId WithFromHost:(NSString *)fromHost WithLimit:(int)limit WithOffset:(int)offset withLoadMore:(BOOL)loadMore WithComplete:(void (^)(NSArray *))complete;

@end
