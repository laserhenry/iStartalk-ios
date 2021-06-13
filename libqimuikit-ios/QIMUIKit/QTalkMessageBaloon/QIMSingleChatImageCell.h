//
//  QIMSingleChatImageCell.h
//  DangDiRen
//
//  Created by ping.xue on 14-3-27.
//  Copyright (c) 2014年 Qunar.com. All rights reserved.
//

#import "QIMCommonUIFramework.h"
#import "STMsgBaloonBaseCell.h"
@class STMsgModel;

@protocol QIMSingleChatImageCellDelegate <NSObject>
@optional
- (void)openBigPhoto:(UIImage *)image FromRect:(CGRect)rect;
- (void)openBigPhotoUrl:(NSString *)imageUrl FromRect:(CGRect)rect;
@end

@interface QIMSingleChatImageCell : STMsgBaloonBaseCell
 
@property (nonatomic, weak) id<QIMSingleChatImageCellDelegate, QIMMsgBaloonBaseCellDelegate> delegate;

+ (CGFloat)getCellHeight;

- (void)refreshUI;

@end
