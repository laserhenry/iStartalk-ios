//
//  QIMKit+QIMMySelfStatus.m
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMMySelfStatus.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMMySelfStatus)

- (void)goOnline {
    
    [[STManager sharedInstance] goOnline];
}

- (void)goAway {
    
    [[STManager sharedInstance] goAway];
}

- (void)goDnd {
    
    [[STManager sharedInstance] goDnd];
}

- (void)goOffline {
    
    [[STManager sharedInstance] quitLogin];
}

- (void)deactiveReconnect {
    [[STManager sharedInstance] deactiveReconnect];
    
}

- (void)activeReconnect {
    [[STManager sharedInstance] activeReconnect];
}

@end
