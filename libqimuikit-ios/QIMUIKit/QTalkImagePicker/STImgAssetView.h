//
//  QTImageAssetView.h
//  qunarChatIphone
//
//  Created by admin on 15/8/18.
//
//

#import "QIMCommonUIFramework.h"
#import <AssetsLibrary/AssetsLibrary.h>

@protocol STImgAssetViewDelegate <NSObject>
@optional
-(BOOL)shouldSelectAsset:(ALAsset*)asset;
-(void)tapSelectHandle:(BOOL)select asset:(ALAsset*)asset;
@end
@interface STImgAssetView : UIView
@property (nonatomic, weak) id<STImgAssetViewDelegate> delegate;

- (void)bind:(ALAsset *)asset selectionFilter:(NSPredicate*)selectionFilter isSeleced:(BOOL)isSeleced;

@end
