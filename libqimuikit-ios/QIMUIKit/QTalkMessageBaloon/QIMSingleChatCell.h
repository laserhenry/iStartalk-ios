//
//  QIMSingleChatCell.h
//  Marquette
//
//  Created by ping.xue on 14-2-13.
//
//
#import "QIMMenuImageView.h"
#import "QIMCommonUIFramework.h"

#define kTextLabelTag       9999
@class STMsgModel;
@protocol QIMSingleChatCellDelegate <NSObject>
@required
- (void)processEvent:(int)event withMessage:(id) message;
@end

@interface QIMSingleChatCell : UITableViewCell

@property (nonatomic, retain)STMsgModel *message;
@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, weak) id<QIMSingleChatCellDelegate> delegate;
@property (nonatomic, assign) NSInteger imageIndex;
@property (nonatomic, assign) CGRect imageRect;
@property (nonatomic, retain) QIMMenuImageView *backView;

- (void)refreshUI;

- (NSInteger)indexForCellImagesAtLocation:(CGPoint)location;

@end
