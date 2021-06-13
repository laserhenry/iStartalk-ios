//
//  QIMAACollectionCell.h
//  qunarChatIphone
//
//  Created by admin on 16/1/18.
//
//

#import "QIMCommonUIFramework.h"

@class STMsgBaloonBaseCell;

@interface STAACollectionCell : STMsgBaloonBaseCell
+ (CGFloat)getCellHeightWithMessage:(STMsgModel *)message  chatType:(ChatType)chatType;
@end
