//
//  STFileMngrCell.h
//  qunarChatIphone
//
//  Created by chenjie on 15/7/24.
//
//
// Copyright © Startalk Ltd.

#import "QIMCommonUIFramework.h"

@interface STFileMngrCell : UITableViewCell

- (void)setCellMessage:(STMsgModel *)message;

@property (nonatomic,assign) BOOL isSelect;//是否是可选的

- (void)setCellSelected : (BOOL)selected;
- (BOOL)isCellSelected;

@end
