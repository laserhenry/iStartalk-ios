//
//  QIMChatNotifyInfoCell.h
//  qunarChatIphone
//
//  Created by admin on 16/2/26.
//
//

#import "QIMCommonUIFramework.h"

@class STMsgBaloonBaseCell;
@protocol QIMChatNotifyInfoCellDelegate <NSObject>

@end

@interface QIMChatNotifyInfoCell : STMsgBaloonBaseCell

@property (nonatomic, weak) id<QIMChatNotifyInfoCellDelegate,QIMMsgBaloonBaseCellDelegate> delegate;

@end

@interface TransferInfoCell : STMsgBaloonBaseCell

@property (nonatomic, weak) id<QIMChatNotifyInfoCellDelegate,QIMMsgBaloonBaseCellDelegate> delegate;

@end
