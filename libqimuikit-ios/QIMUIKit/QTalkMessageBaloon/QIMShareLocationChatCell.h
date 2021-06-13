//
//  LocationShareMsgCell.h
//  qunarChatIphone
//
//  Created by xueping on 15/7/9.
//
//

#import "QIMCommonUIFramework.h"

@class STMsgBaloonBaseCell;
@interface QIMShareLocationChatCell : STMsgBaloonBaseCell

+ (CGFloat)getCellHeightWithMessage:(STMsgModel *)message chatType:(ChatType)chatType;

- (void)refreshUI;

@end
