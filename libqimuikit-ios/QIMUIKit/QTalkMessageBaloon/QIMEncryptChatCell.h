//
//  QIMEncryptChatCell.h
//  qunarChatIphone
//
//  Created by 李露 on 2017/9/7.
//
//

@class STMsgBaloonBaseCell;

@interface QIMEncryptChatCell : STMsgBaloonBaseCell

+ (CGFloat)getCellHeightWithMessage:(STMsgModel *)message chatType:(ChatType)chatType;

- (void)refreshUI;
@end
