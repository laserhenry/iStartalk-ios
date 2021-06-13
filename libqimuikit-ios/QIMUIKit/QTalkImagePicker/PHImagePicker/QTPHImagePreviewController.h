//
//  QTImagePreviewController.h
//  qunarChatIphone
//
//  Created by admin on 15/8/19.
//
//

//#import "QIMCommonUIFramework.h"
#import "QIMCommonUIFramework.h"

@class STPHImgPickerController;
@class STPHGridViewController;
@interface QTPHImagePreviewController : QTalkViewController
@property (nonatomic,assign) STPHImgPickerController * picker;
@property (nonatomic,assign) STPHGridViewController * gridVC;
@property (nonatomic, strong) NSArray *photoArray;
@end
