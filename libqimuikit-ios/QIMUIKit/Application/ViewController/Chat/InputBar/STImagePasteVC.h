//
//  STImagePasteVC.h
//  QIMUIKit
//
//  Created by busylei on 2022/11/15.
//

#import <UIKit/UIKit.h>
#import "QIMTextBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface STImagePasteVC : UIViewController

@property UIImage * image;

@property (nonatomic, weak) id <QIMTextBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
