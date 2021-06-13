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
    [[QIMManager sharedInstance] playHongBaoSound];
}

- (void)playSound {
    
    [[QIMManager sharedInstance] playSound];
}

- (void)shockWindow {
    [[QIMManager sharedInstance] shockWindow];
}

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL {
    return [[QIMManager sharedInstance] addSkipBackupAttributeToItemAtURL:URL];
}

@end
