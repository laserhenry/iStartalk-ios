//
//  QIMManager+QuickReply.h
//  QIMCommon
//
//  Created by 李露 on 2018/8/8.
//  Copyright © 2018年 QIMKit. All rights reserved.
//

#import "STManager.h"

@interface STManager (QuickReply)

- (void)getRemoteQuickReply;

- (NSInteger)getQuickReplyGroupCount;

- (NSArray *)getQuickReplyGroup;

- (NSArray *)getQuickReplyContentWithGroupId:(long)groupId;

@end
