
#import "QIMCommonUIFramework.h"

@class STMsgBaloonBaseCell;
@interface QIMShockMsgCell : STMsgBaloonBaseCell

+ (CGFloat)getCellHeightWithMessage:(STMsgModel *)message chatType:(ChatType)chatType;

- (void)refreshUI;

@end
