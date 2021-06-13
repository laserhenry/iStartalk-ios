//
//  QTImageAssetTipView.h
//  qunarChatIphone
//
//  Created by admin on 15/8/18.
//
//

//#import "QIMCommonUIFramework.h"
#import "QIMCommonUIFramework.h"

@protocol STImgAssetTapViewDelegate <NSObject>
@optional
-(void)touchSelect:(BOOL)select;
-(BOOL)shouldTap;
@end
@interface STImgAssetTapView : UIView
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL disabled;
@property (nonatomic, weak) id<STImgAssetTapViewDelegate> delegate;
@end
