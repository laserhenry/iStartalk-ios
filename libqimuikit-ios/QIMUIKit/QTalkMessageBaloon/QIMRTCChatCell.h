//
//  QIMRTCChatCell.h
//  qunarChatIphone
//
//  Created by Qunar-Lu on 2017/3/22.
//
//

@class STMsgBaloonBaseCell;
@interface QIMRTCChatCell : STMsgBaloonBaseCell

+ (CGFloat)getCellHeightWithMessage:(STMsgModel *)message chatType:(ChatType)chatType;

- (void)refreshUI;

@end
