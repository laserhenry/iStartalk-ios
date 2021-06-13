//
//  QTImageAssetTools.h
//  qunarChatIphone
//
//  Created by admin on 15/8/19.
//
//

#import "QIMCommonUIFramework.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface STImgAssetTools : NSObject

+ (NSData *)getCompressImageFromALAsset:(ALAsset *)asset;

@end
