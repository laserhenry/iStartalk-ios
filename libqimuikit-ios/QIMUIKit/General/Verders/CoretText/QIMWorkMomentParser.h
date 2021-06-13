//
//  QIMWorkMomentParser.h
//  QIMUIKit
//
//  Created by lilu on 2019/2/25.
//  Copyright © 2019 QIM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class STMsgModel;
@class QIMAttributedLabel;
@class QIMTextContainer;
@interface QIMWorkMomentParser : NSObject

+ (instancetype) sharedInstance;
+ (QIMTextContainer *)textContainerForMessage:(STMsgModel *)message fromCache:(BOOL)fromCache withCellWidth:(CGFloat)cellWidth withFontSize:(CGFloat)fontSize withFontColor:(UIColor *)textColor withNumberOfLines:(NSInteger)numberOfLines;

+ (NSArray *)storagesFromMessage:(STMsgModel *)message;
            
- (void)parseForXMLString:(NSString *)xmlStr complete:(void (^)(NSDictionary * info))complete;

@end

NS_ASSUME_NONNULL_END
