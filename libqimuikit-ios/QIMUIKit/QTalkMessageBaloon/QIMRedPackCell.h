//
//  QIMRedPackCell.h
//  qunarChatIphone
//
//  Created by chenjie on 15/12/24.
//
//

#import "QIMCommonUIFramework.h"
@class STMsgBaloonBaseCell;
@interface QIMRedPackCell : STMsgBaloonBaseCell

+ (CGFloat)getCellHeightWithMessage:(STMsgModel *)message  chatType:(ChatType)chatType;

@end
