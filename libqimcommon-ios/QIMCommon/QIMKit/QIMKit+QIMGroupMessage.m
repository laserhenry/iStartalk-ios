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
    [[STManager sharedInstance] updateLastGroupMsgTime];
}

- (void)checkGroupChatMsg {
    [[STManager sharedInstance] checkGroupChatMsg];
}

- (void)updateOfflineGroupMessages {
    [[STManager sharedInstance] updateOfflineGroupMessages];
}

//更新群阅读指针，三次重试
- (void)updateMucReadMark {
    
    [[STManager sharedInstance] updateMucReadMark];
}

@end
