//
//  QIMKit+QIMMySelfStatus.h
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMMySelfStatus)

/**
 上线
 */
- (void)goOnline;

/**
 离开
 */
- (void)goAway;

/**
 忙碌
 */
- (void)goDnd;

/**
 下线
 */
- (void)goOffline;

- (void) deactiveReconnect;

/**
 active reconnect
 */
- (void) activeReconnect;

@end
