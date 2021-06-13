//
//  QIMHintTableViewCell.h
//  QIMUIKit
//
//  Created by qitmac000645 on 2019/8/22.
//

#import "STMsgBaloonBaseCell.h"

@class QIMHintTableViewCell;
@protocol QIMHintCellDelegate <NSObject>

- (void)hintCell:(QIMHintTableViewCell *)cell linkClickedWithInfo:(NSDictionary *)infoFic;

@end
NS_ASSUME_NONNULL_BEGIN

@interface QIMHintTableViewCell : STMsgBaloonBaseCell
@property (nonatomic,weak) id<QIMHintCellDelegate> hintDelegate;

+ (CGFloat)getCellHeightWihtMessage:(STMsgModel *)message chatType:(ChatType)chatType;

@end

NS_ASSUME_NONNULL_END
