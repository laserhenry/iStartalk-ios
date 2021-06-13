//
//  Message.m
//  qunarChatMac
//
//  Created by ping.xue on 14-2-28.
//  Copyright (c) 2014年 May. All rights reserved.
//

#import "STMsgModel.h"
#import "QIMPrivateHeader.h"

@implementation STMsgModel

- (NSString *)description{
    NSMutableString *str = [NSMutableString stringWithString:[self qim_properties_aps]];
    return str;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"message" : @"MessageBody",
             @"to" : @"ToJid",
             @"messageId" : @"MessageId",
             @"messageType" : @"MessageType",
             @"extendInformation" : @"MessageExtendInfo",
             @"backupInfo" : @"MessageBackUpInfo",
             @"channelInfo" : @"MessageChannelInfo",
             @"chatId" : @"MessageChatId",
             @"appendInfoDict" : @"MessageAppendInfoDict"
             };
}

@end

