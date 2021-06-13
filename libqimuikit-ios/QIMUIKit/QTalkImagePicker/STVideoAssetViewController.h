//
//  QTalkVideoAssetViewController.h
//  qunarChatIphone
//
//  Created by admin on 15/8/19.
//
//

#import "QIMCommonUIFramework.h"
@class ALAsset;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_8_0
@class STPHImgPickerController;
#endif
@interface STVideoAssetViewController : QTalkViewController
@property (nonatomic, strong) id videoAsset;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_8_0
@property (nonatomic, assign) STPHImgPickerController * picker;
@property (nonatomic, assign) float    videoDuration;
#endif
@end
