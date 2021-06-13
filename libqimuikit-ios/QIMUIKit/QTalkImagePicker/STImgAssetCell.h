//
//  QTImageAssetCell.h
//  qunarChatIphone
//
//  Created by admin on 15/8/18.
//
//

#import "QIMCommonUIFramework.h"
#import <AssetsLibrary/AssetsLibrary.h>

@protocol STImgAssetCellDelegate <NSObject>
@optional
- (BOOL)shouldSelectAsset:(ALAsset*)asset;
- (void)didSelectAsset:(ALAsset*)asset;
- (void)didDeselectAsset:(ALAsset*)asset;
@end

@interface STImgAssetCell : UITableViewCell
@property (nonatomic, weak) id<STImgAssetCellDelegate> delegate;
@property (nonatomic, strong) NSArray *assets;
@property (nonatomic, strong) NSPredicate *selectionFilter;
+ (CGFloat)getCellHeight;
- (void)refreshUI; 

@end
