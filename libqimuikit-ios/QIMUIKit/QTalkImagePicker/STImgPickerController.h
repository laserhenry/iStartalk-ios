//
//  QTImagePickerController.h
//  qunarChatIphone
//
//  Created by admin on 15/8/18.
//
//

#import "QIMCommonUIFramework.h"
#import <AssetsLibrary/AssetsLibrary.h>

@class STImgPickerController;

@protocol STImgPickerControllerDelegate <NSObject>
@optional

-(void)qtImagePickerController:(STImgPickerController *)picker didFinishPickingAssets:(NSArray *)assets ToOriginal:(BOOL)flag;
-(void)qtImagePickerController:(STImgPickerController *)picker didFinishPickingImage:(UIImage *)image;
- (void)qtImagePickerController:(STImgPickerController *)picker didFinishPickingVideo:(NSDictionary *)videoDic;

-(void)qtImagePickerControllerDidCancel:(STImgPickerController *)picker;
-(void)qtImagePickerController:(STImgPickerController *)picker didSelectAsset:(ALAsset*)asset;
-(void)qtImagePickerController:(STImgPickerController *)picker didDeselectAsset:(ALAsset*)asset;
-(void)qtImagePickerControllerDidMaximum:(STImgPickerController *)picker;
-(void)qtImagePickerControllerDidMinimum:(STImgPickerController *)picker;
@end

@interface STImgPickerController : UINavigationController

@property (nonatomic, weak) id <STImgPickerControllerDelegate> imageDelegate;
@property (nonatomic, strong) ALAssetsFilter *assetsFilter;
@property (nonatomic, strong) NSMutableArray *indexPathsForSelectedItems;
@property (nonatomic, assign) NSInteger maximumNumberOfSelection;
@property (nonatomic, assign) NSInteger minimumNumberOfSelection;
@property (nonatomic, strong) NSPredicate *selectionFilter;
@property (nonatomic, assign) BOOL showCancelButton;
@property (nonatomic, assign) BOOL showEmptyGroups;
@property (nonatomic, assign) BOOL isFinishDismissViewController;

@property (nonatomic, assign) long long originalDataLength;
@property (nonatomic, assign) long long compressDataLength;
@property (nonatomic, assign) BOOL isOriginalImage;
@property (nonatomic, strong) NSMutableDictionary *compressDataLengthDic;
@property (nonatomic, assign) BOOL selectedPhoto;

@end

