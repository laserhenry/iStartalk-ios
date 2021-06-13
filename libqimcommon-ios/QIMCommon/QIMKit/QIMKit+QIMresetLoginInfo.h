//
//  QIMKit+QIMresetLoginInfo.h
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMresetLoginInfo)

- (void) resetIP:(NSString *) ip port:(int) port domain:(NSString *) domain httpServer:(NSString *) http fileServer:(NSString *) fileServer;

@end
