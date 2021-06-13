//
//  QIMWorkCommentTableView.h
//  QIMUIKit
//
//  Created by lilu on 2019/1/9.
//  Copyright © 2019 QIM. All rights reserved.
//

#import "QIMCommonUIFramework.h"

NS_ASSUME_NONNULL_BEGIN

@class QIMWorkCommentModel;

@protocol QIMWorkCommentTableViewDelegate <NSObject>

- (void)loadNewComments;

- (void)loadMoreComments;

- (void)endAddComment;

- (void)beginControlCommentWithComment:(QIMWorkCommentModel *)commentModel withIsHotComment:(BOOL)isHotComment withIndexPath:(NSIndexPath *)indexPath;

- (void)beginAddCommentWithComment:(QIMWorkCommentModel *)commentModel;

@end

@interface QIMWorkCommentTableView : UIView

@property (nonatomic, strong) NSMutableArray *hotCommentModels;

@property (nonatomic, strong) NSMutableArray *commentModels;

@property (nonatomic, weak) id <QIMWorkCommentTableViewDelegate> commentDelegate;

@property (nonatomic, strong) UIView *commentHeaderView;

@property (nonatomic, assign) NSInteger commentNum;

- (void)scrollTheTableViewForCommentWithKeyboardHeight:(CGFloat)keyboardHeight;

- (void)reloadUploadCommentWithModel:(QIMWorkCommentModel *)commentModel;

- (void)reloadCommentsData;

- (void)endRefreshingHeader;

- (void)endRefreshingFooter;

- (void)endRefreshingFooterWithNoMoreData;

- (void)scrollCommentModelToTopIndex;

- (void)reloadCommentWithIndexPath:(NSIndexPath *)indexPath withIsHotComment:(BOOL)isHotComment;

- (void)removeCommentWithIndexPath:(NSIndexPath *)indexPath withIsHotComment:(BOOL)isHotComment withSuperStatus:(NSInteger)superParentStatus;

@end

NS_ASSUME_NONNULL_END
