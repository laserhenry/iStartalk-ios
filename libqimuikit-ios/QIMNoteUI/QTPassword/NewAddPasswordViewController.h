//
//  NewAddPasswordViewController.h
//  qunarChatIphone
//
//  Created by 李露 on 2017/7/11.
//
//

#import "QIMCommonUIFramework.h"
#if __has_include("QIMNoteManager.h")
#import "QIMNoteModel.h"

@interface NewAddPasswordViewController : UIViewController

@property (nonatomic, assign) BOOL edited;

- (void)setQIMNoteModel:(QIMNoteModel *)model;

@property (nonatomic, assign) NSInteger CID;

@property (nonatomic, assign) NSInteger QID;

@end
#endif
