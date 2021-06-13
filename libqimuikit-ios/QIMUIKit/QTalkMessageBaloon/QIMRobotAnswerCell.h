//
//  QIMRobotAnswerCell.h
//  QIMUIKit
//
//  Created by 李露 on 11/9/18.
//  Copyright © 2018 QIM. All rights reserved.
//

#import "QIMCommonUIFramework.h"
#import "STMsgBaloonBaseCell.h"

@protocol QIMRobotAnswerCellLoadDelegate <NSObject>

- (void)refreshRobotAnswerMessageCell:(STMsgBaloonBaseCell *)cell;

- (void)reTeachRobot;

@end

@interface QIMRobotAnswerCell : STMsgBaloonBaseCell

@property (nonatomic, weak) id<QIMRobotAnswerCellLoadDelegate,QIMMsgBaloonBaseCellDelegate> delegate;

@end
