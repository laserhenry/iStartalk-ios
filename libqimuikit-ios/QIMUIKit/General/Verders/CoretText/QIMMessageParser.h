//
//  QIMMessageParser.h
//  qunarChatIphone
//
//  Created by chenjie on 16/7/6.
//
//

#import "QIMCommonUIFramework.h"

@class STMsgModel;
@class QIMAttributedLabel;
@class QIMTextContainer;

@interface QIMMessageParser : NSObject

+ (instancetype)sharedInstance;

+ (QIMAttributedLabel *)attributedLabelForMessage:(STMsgModel *)message;

+ (QIMTextContainer *)textContainerForMessage:(STMsgModel *)message;

+ (QIMTextContainer *)textContainerForMessage:(STMsgModel *)message fromCache:(BOOL)fromCache;

+ (QIMTextContainer *)textContainerForMessageCtnt:(NSString *)ctnt withId:(NSString *)signId direction:(QIMMessageDirection)direction;

+ (NSArray *)storagesFromMessage:(STMsgModel *)message;

+ (float)getCellWidth;

+ (STMsgModel *)reductionMessageForMessage:(STMsgModel *)message;

            

- (void)parseForXMLString:(NSString *)xmlStr complete:(void (^)(NSDictionary *info))complete;

@end
