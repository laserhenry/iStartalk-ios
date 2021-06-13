//
//  QIMKit+QIMQuickReply.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMQuickReply.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMQuickReply)

- (void)getRemoteQuickReply {
    [[QIMManager sharedInstance] getRemoteQuickReply];
}

- (NSInteger)getQuickReplyGroupCount {
    return [[QIMManager sharedInstance] getQuickReplyGroupCount];
}

- (NSArray *)getQuickReplyGroup {
    return [[QIMManager sharedInstance] getQuickReplyGroup];
}

- (NSArray *)getQuickReplyContentWithGroupId:(long)groupId {
    return [[QIMManager sharedInstance] getQuickReplyContentWithGroupId:groupId];
}
@end
