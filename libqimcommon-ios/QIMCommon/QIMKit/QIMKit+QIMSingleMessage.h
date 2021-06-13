//
//  QIMKit+QIMSingleMessage.h
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//

#import "STKit.h"

@interface STKit (QIMSingleMessage)

- (void)checkSingleChatMsg;

/**
 更新最后一条单人消息时间
 */
- (void)updateLastMsgTime;

- (void)getReadFlag;

- (void)sendRecevieMessageState;

- (BOOL)updateOfflineMessagesV2;

@end
