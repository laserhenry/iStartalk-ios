//
//  QTImageAlbumCell.h
//  qunarChatIphone
//
//  Created by admin on 15/8/18.
//
//

#import "QIMCommonUIFramework.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface STImgAlbumCell : UITableViewCell

+ (CGFloat)getCellHeight;

- (void)bind:(ALAssetsGroup *)assetsGroup;

@end
