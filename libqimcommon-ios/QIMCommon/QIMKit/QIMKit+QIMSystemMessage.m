//
//  QIMKit+QIMSystemMessage.m
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMSystemMessage.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMSystemMessage)

#pragma mark - 系统消息

- (void)checkHeadlineMsg {
    [[QIMManager sharedInstance] checkHeadlineMsg];
}

- (void)updateLastSystemMsgTime {
    [[QIMManager sharedInstance] updateLastSystemMsgTime];
}

- (void)updateOfflineSystemNoticeMessages {
    [[QIMManager sharedInstance] updateOfflineSystemNoticeMessages];
}

- (void)getSystemMsgLisByUserId:(NSString *)userId WithFromHost:(NSString *)fromHost WithLimit:(int)limit WithOffset:(int)offset withLoadMore:(BOOL)loadMore WithComplete:(void (^)(NSArray *))complete {
    [[QIMManager sharedInstance] getSystemMsgLisByUserId:userId WithFromHost:fromHost WithLimit:limit WithOffset:offset withLoadMore:loadMore WithComplete:complete];
}

@end
