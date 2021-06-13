//
//  QIMWorkMessageCell.h
//  QIMUIKit
//
//  Created by lilu on 2019/1/17.
//  Copyright © 2019 QIM. All rights reserved.
//

#import "QIMCommonUIFramework.h"
#import "QIMWorkNoticeMessageModel.h"
#import "QIMWorkMomentContentModel.h"

typedef enum : NSUInteger {
    QIMWorkMomentCellTypeMyMessage = 0,
    QIMWorkMomentCellTypeMyPOST = 1,
    QIMWorkMomentCellTypeMyREPLY,
    QIMWorkMomentCellTypeMyAT,
} QIMWorkMomentCellType;

NS_ASSUME_NONNULL_BEGIN

@interface QIMWorkMessageCell : UITableViewCell

@property (nonatomic, strong) QIMWorkNoticeMessageModel *noticeMsgModel;

@property (nonatomic, strong) QIMWorkMomentContentModel *contentModel;

@property (nonatomic, assign) QIMWorkMomentCellType cellType;

@end

NS_ASSUME_NONNULL_END
