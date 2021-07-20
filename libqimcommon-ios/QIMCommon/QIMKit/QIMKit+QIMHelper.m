//
//  QIMKit+QIMHelper.m
//  qunarChatIphone
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//

#import "QIMKit+QIMHelper.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMHelper)

- (void)playHongBaoSound {
    [[STManager sharedInstance] playHongBaoSound];
}

- (void)playSound {
    
    [[STManager sharedInstance] playSound];
}

- (void)shockWindow {
    [[STManager sharedInstance] shockWindow];
}

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL {
    return [[STManager sharedInstance] addSkipBackupAttributeToItemAtURL:URL];
}

@end
