//
//  QIMKit+QIMresetLoginInfo.m
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMresetLoginInfo.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMresetLoginInfo)

- (void)resetIP:(NSString *)ip port:(int)port domain:(NSString *)domain httpServer:(NSString *)http fileServer:(NSString *)fileServer {
    //
    // 这里可能需要判断，如果用户换了，则要重新生成用户数据的事儿
    [[QIMManager sharedInstance] resetIP:ip port:port domain:domain httpServer:http fileServer:fileServer];
}

@end
