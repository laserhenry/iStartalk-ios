//
//  QIMKit+QIMGroupMessage.m
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//

#import "QIMKit+QIMGroupMessage.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMGroupMessage)

- (void)updateLastGroupMsgTime {
    [[QIMManager sharedInstance] updateLastGroupMsgTime];
}

- (void)checkGroupChatMsg {
    [[QIMManager sharedInstance] checkGroupChatMsg];
}

- (void)updateOfflineGroupMessages {
    [[QIMManager sharedInstance] updateOfflineGroupMessages];
}

//更新群阅读指针，三次重试
- (void)updateMucReadMark {
    
    [[QIMManager sharedInstance] updateMucReadMark];
}

@end
