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
    
    [[QIMManager sharedInstance] goOnline];
}

- (void)goAway {
    
    [[QIMManager sharedInstance] goAway];
}

- (void)goDnd {
    
    [[QIMManager sharedInstance] goDnd];
}

- (void)goOffline {
    
    [[QIMManager sharedInstance] quitLogin];
}

- (void)deactiveReconnect {
    [[QIMManager sharedInstance] deactiveReconnect];
    
}

- (void)activeReconnect {
    [[QIMManager sharedInstance] activeReconnect];
}

@end
