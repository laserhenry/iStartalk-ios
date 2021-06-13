//
//  QIMKit+QIMQuickReply.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMQuickReply)

- (void)getRemoteQuickReply;

- (NSInteger)getQuickReplyGroupCount;

- (NSArray *)getQuickReplyGroup;

- (NSArray *)getQuickReplyContentWithGroupId:(long)groupId;

@end
