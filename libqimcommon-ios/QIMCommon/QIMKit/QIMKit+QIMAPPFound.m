//
//  QIMKit+QIMAPPFound.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMAPPFound.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMAPPFound)

- (void)getRemoteFoundNavigation {
    return [[STManager sharedInstance] getRemoteFoundNavigation];
}

- (NSString *)getLocalFoundNavigation {
    return [[STManager sharedInstance] getLocalFoundNavigation];
}

@end
