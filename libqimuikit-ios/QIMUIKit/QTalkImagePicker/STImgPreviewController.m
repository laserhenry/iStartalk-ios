//
//  QTImagePreviewController.m
//  qunarChatIphone
//
//  Created by admin on 15/8/19.
//
//

#import "STImgPreviewController.h"
#import "STImgPickerController.h"
#import "QIMImageEditViewController.h"
#import "STImgAssetTools.h"
#import "QIMMWPhotoBrowser.h"
#import "QIMStringTransformTools.h"

@interface STImgPreviewController ()<QIMMWPhotoBrowserDelegate,UIAlertViewDelegate,QIMImageEditViewControllerDelegate,UIActionSheetDelegate>{
    QIMMWPhotoBrowser *_photoBrowser;
    UIView   *_bottomView;
    UIButton *_editButton;
    UIButton *_photoTypeButton;
    UIButton *_sendButton;
    
    UIButton *_rightButton;
    
}

@end

@implementation STImgPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:[NSBundle qim_localizedStringForKey:@"Preview"]];

    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_rightButton setImage:[UIImage qim_imageNamedFromQIMUIKitBundle:@"photo_browser_header_icon_unchecked"] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage qim_imageNamedFromQIMUIKitBundle:@"photo_browser_header_icon_checked"] forState:UIControlStateSelected];
    [_rightButton addTarget:self action:@selector(onRightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    [self initPhotoScroll];
    [self initBottomView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_photoBrowser viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init UI

- (void)initPhotoScroll{
    _photoBrowser = [[QIMMWPhotoBrowser alloc] init];
    [_photoBrowser setNotAutoHidenControls:YES];
    [_photoBrowser setDelegate:self];
    _photoBrowser.displayActionButton = YES;
    _photoBrowser.zoomPhotosToFill = YES;
    _photoBrowser.enableSwipeToDismiss = NO;
    [_photoBrowser setCurrentPhotoIndex:self.photoArray.count - 1];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    _photoBrowser.wantsFullScreenLayout = YES;
#endif 
    [_photoBrowser.view setFrame:CGRectMake(0, -64, self.view.width, self.view.height + 64)];
    [self.view addSubview:_photoBrowser.view];
}

- (void)initBottomView{
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 64 - [[QIMDeviceManager sharedInstance] getHOME_INDICATOR_HEIGHT], self.view.width, 49)];
    [_bottomView setBackgroundColor:[UIColor qim_colorWithHex:0xf1f1f1 alpha:1]];
    [self.view addSubview:_bottomView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _bottomView.width, 0.5)];
    [lineView setBackgroundColor:[UIColor qim_colorWithHex:0x999999 alpha:1]];
    [_bottomView addSubview:lineView];
    
    _editButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_editButton setFrame:CGRectMake(10, 8, 60, 30)];
    [_editButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_editButton setTitle:[NSBundle qim_localizedStringForKey:@"Edit"] forState:UIControlStateNormal];
    [_editButton setTitleColor:[UIColor qim_colorWithHex:0xa1a1a1 alpha:1] forState:UIControlStateDisabled];
    [_editButton addTarget:self action:@selector(onEditClick) forControlEvents:UIControlEventTouchUpInside];
    [_editButton setEnabled:NO];
    [_bottomView addSubview:_editButton];
    
    _photoTypeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_photoTypeButton.titleLabel setNumberOfLines:0];
    [_photoTypeButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_photoTypeButton setFrame:CGRectMake(_editButton.right + 15, 8, 100, 30)];
    [_photoTypeButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_photoTypeButton setImage:[UIImage qim_imageNamedFromQIMUIKitBundle:@"photo_browser_button_arrow_normal"] forState:UIControlStateNormal];
    [_photoTypeButton setImage:[UIImage qim_imageNamedFromQIMUIKitBundle:@"photo_browser_button_arrow_pressed"] forState:UIControlStateHighlighted];
    [_photoTypeButton setTitle:[NSBundle qim_localizedStringForKey:@"Standard Definition"] forState:UIControlStateNormal];
    [_photoTypeButton setTitleColor:[UIColor qim_colorWithHex:0xa1a1a1 alpha:1] forState:UIControlStateDisabled];
    [_photoTypeButton setEnabled:NO];
    [_photoTypeButton addTarget:self action:@selector(onPhotoTypeClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_photoTypeButton];
    
    _sendButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 90, 8, 80, 30)];
    [_sendButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_sendButton setBackgroundImage:[[UIImage qim_imageNamedFromQIMUIKitBundle:@"common_button_focus_nor"] stretchableImageWithLeftCapWidth:10 topCapHeight:15] forState:UIControlStateNormal];
    [_sendButton setBackgroundImage:[[UIImage qim_imageNamedFromQIMUIKitBundle:@"common_button_focus_pressed"] stretchableImageWithLeftCapWidth:10 topCapHeight:15] forState:UIControlStateHighlighted];
    [_sendButton setBackgroundImage:[[UIImage qim_imageNamedFromQIMUIKitBundle:@"common_button_disabled"] stretchableImageWithLeftCapWidth:10 topCapHeight:15] forState:UIControlStateDisabled];
    [_sendButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor qim_colorWithHex:0xa1a1a1 alpha:1] forState:UIControlStateDisabled];
    [_sendButton setTitle:[NSBundle qim_localizedStringForKey:@"Confirm"] forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(onSendClick) forControlEvents:UIControlEventTouchUpInside];
    [_sendButton setEnabled:NO];
    [_bottomView addSubview:_sendButton];
    
    STImgPickerController *picker = (STImgPickerController *)self.navigationController;
    [self setTitleWithSelectedIndexPaths:picker.indexPathsForSelectedItems];
}


- (void)setTitleWithSelectedIndexPaths:(NSArray *)indexPaths
{
    STImgPickerController *picker = (STImgPickerController *)self.navigationController;
    BOOL photosSelected = NO;
    BOOL videoSelected  = NO;
    
    for (int i=0; i<indexPaths.count; i++) {
        ALAsset *asset = indexPaths[i];
        
        if ([[asset valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypePhoto]) {
            picker.selectedPhoto = YES;
            photosSelected  = YES;
            break;
        }
        if ([[asset valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
            videoSelected   = YES;
        
        if (photosSelected && videoSelected)
            break;
        
    }
    
    if (indexPaths.count > 0) {
        if (indexPaths.count == 1) {
            [_editButton setEnabled:YES];
        } else {
            [_editButton setEnabled:NO];
        }
        [_photoTypeButton setEnabled:YES];
        [_sendButton setEnabled:YES];
        [_sendButton setTitle:[NSString stringWithFormat:@"%@(%ld/%ld)", [NSBundle qim_localizedStringForKey:@"Confirm"], (long)indexPaths.count,(long)picker.maximumNumberOfSelection] forState:UIControlStateNormal];
    } else {
        [_editButton setEnabled:NO];
        [_photoTypeButton setEnabled:NO];
        [_sendButton setEnabled:NO];
        [_sendButton setTitle:[NSBundle qim_localizedStringForKey:@"Confirm"] forState:UIControlStateNormal];
    }
    picker.isOriginalImage =  [[STKit sharedInstance] pickerPixelOriginal];
    if (picker.isOriginalImage == NO) {
        [_photoTypeButton setTitle:[NSString stringWithFormat:@"   %@\r(%@)", [NSBundle qim_localizedStringForKey:@"Standard Definition"], [QIMStringTransformTools qim_CapacityTransformStrWithSize:picker.compressDataLength]] forState:UIControlStateNormal];
    } else {
        [_photoTypeButton setTitle:[NSString stringWithFormat:@"   %@\r(%@)", [NSBundle qim_localizedStringForKey:@"Full Image"], [QIMStringTransformTools qim_CapacityTransformStrWithSize:picker.originalDataLength]] forState:UIControlStateNormal];
    }
}

#pragma mark - action

- (void)onRightButtonClick{
    ALAsset *asset = [self.photoArray objectAtIndex:_photoBrowser.currentIndex];
    STImgPickerController *picker = (STImgPickerController *)self.navigationController;
    if ([picker.indexPathsForSelectedItems containsObject:asset]) {
        [picker.indexPathsForSelectedItems removeObject:asset];
        [_rightButton setSelected:NO];
        NSURL *assetUrl = [asset valueForProperty:ALAssetPropertyAssetURL];
        ALAssetRepresentation *representation = [asset defaultRepresentation];
        picker.originalDataLength -= [representation size];
        NSNumber *bqNum = [picker.compressDataLengthDic objectForKey:assetUrl];
        if (bqNum) {
            picker.compressDataLength -= bqNum.longLongValue;
        } else {
            @autoreleasepool {
                long long temp = [[STImgAssetTools getCompressImageFromALAsset:asset] length];
                picker.compressDataLength -= temp > [representation size]? [representation size]:temp;
                [picker.compressDataLengthDic setObject:@(temp > [representation size]? [representation size]:temp) forKey:assetUrl];
            }
        }
    } else {
        [picker.indexPathsForSelectedItems addObject:asset];
        [_rightButton setSelected:YES];
        NSURL *assetUrl = [asset valueForProperty:ALAssetPropertyAssetURL];
        ALAssetRepresentation *representation = [asset defaultRepresentation];
        picker.originalDataLength += [representation size];
        NSNumber *bqNum = [picker.compressDataLengthDic objectForKey:assetUrl];
        if (bqNum) {
            picker.compressDataLength += bqNum.longLongValue;
        } else {
            @autoreleasepool {
                long long temp = [[STImgAssetTools getCompressImageFromALAsset:asset] length];
                picker.compressDataLength += temp > [representation size]? [representation size]:temp;
                [picker.compressDataLengthDic setObject:@(temp > [representation size]? [representation size]:temp) forKey:assetUrl];
            }
        }
    }
    [self setTitleWithSelectedIndexPaths:picker.indexPathsForSelectedItems];
}

- (void)onEditClick{
    STImgPickerController *picker = (STImgPickerController *)self.navigationController;
    if (picker.indexPathsForSelectedItems.count > 0) {
        ALAsset * asset = picker.indexPathsForSelectedItems.lastObject;
        UIImage * image = nil;
        if (picker.isOriginalImage) {
            uint8_t *buffer = (uint8_t *)malloc((unsigned long)asset.defaultRepresentation.size);
            NSInteger length = [asset.defaultRepresentation getBytes:buffer fromOffset:0 length:(unsigned long)asset.defaultRepresentation.size error:nil];
            NSData * imageData = [NSData dataWithBytes:buffer length:length];
            free(buffer);
            image = [UIImage imageWithData:imageData];
        }else{
            image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage                                         scale:asset.defaultRepresentation.scale orientation:(UIImageOrientation)asset.defaultRepresentation.orientation];
        }
        QIMImageEditViewController * imageEditVC = [[QIMImageEditViewController alloc] initWithImage:image];
        imageEditVC.delegate = self;
        [self.navigationController pushViewController:imageEditVC animated:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    STImgPickerController *picker = (STImgPickerController *)self.navigationController;
    if (buttonIndex == 0) {
        [_photoTypeButton setTitle:[NSString stringWithFormat:@"   %@\r(%@)",[NSBundle qim_localizedStringForKey:@"Standard Definition"], [QIMStringTransformTools qim_CapacityTransformStrWithSize:picker.compressDataLength]] forState:UIControlStateNormal];
        picker.isOriginalImage = NO;
        [[STKit sharedInstance] setPickerPixelOriginal:NO];
    } else if (buttonIndex == 1) {
        
        [_photoTypeButton setTitle:[NSString stringWithFormat:@"   %@\r(%@)",[NSBundle qim_localizedStringForKey:@"Full Image"], [QIMStringTransformTools qim_CapacityTransformStrWithSize:picker.originalDataLength]] forState:UIControlStateNormal];
        picker.isOriginalImage = YES;
        [[STKit sharedInstance] setPickerPixelOriginal:YES];
    }
}

- (void)onPhotoTypeClick{
    STImgPickerController *picker = (STImgPickerController *)self.navigationController;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:[NSBundle qim_localizedStringForKey:@"Select photo size"] delegate:self cancelButtonTitle:[NSBundle qim_localizedStringForKey:@"Cancel"] destructiveButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"%@ (%@)", [NSBundle qim_localizedStringForKey:@"Standard Definition"], [QIMStringTransformTools qim_CapacityTransformStrWithSize:picker.compressDataLength]],
                            [NSString stringWithFormat:@"%@ (%@)", [NSBundle qim_localizedStringForKey:@"Full Image"], [QIMStringTransformTools qim_CapacityTransformStrWithSize:picker.originalDataLength]],nil];
    [sheet showInView:self.view];
}

- (void)onSendClick{
    STImgPickerController *picker = (STImgPickerController *)self.navigationController;
    if (picker.indexPathsForSelectedItems.count < picker.minimumNumberOfSelection) {
        if (picker.imageDelegate!=nil&&[picker.imageDelegate respondsToSelector:@selector(qtImagePickerControllerDidMaximum:)]) {
            [picker.imageDelegate qtImagePickerControllerDidMaximum:picker];
        }
    }
    
    if ([picker.imageDelegate respondsToSelector:@selector(qtImagePickerController:didFinishPickingAssets:ToOriginal:)])
        [picker.imageDelegate qtImagePickerController:picker didFinishPickingAssets:picker.indexPathsForSelectedItems ToOriginal:picker.isOriginalImage];
}

#pragma mark - photo browser delegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(QIMMWPhotoBrowser *)photoBrowser
{
    return self.photoArray.count;
}

- (id <QIMMWPhoto>)photoBrowser:(QIMMWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    ALAsset *asset = [self.photoArray objectAtIndex:index];
    QIMMWPhoto *photo = [[QIMMWPhoto alloc] initWithImage:[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage]];
    return photo;
}

- (void)photoBrowser:(QIMMWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index{
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%d/%d",(int)index+1,(int)self.photoArray.count]];
    
    ALAsset *asset = [self.photoArray objectAtIndex:index];
    STImgPickerController *picker = (STImgPickerController *)self.navigationController;
    if ([picker.indexPathsForSelectedItems containsObject:asset]) {
        [_rightButton setSelected:YES];
    } else {
        [_rightButton setSelected:NO];
    }
}
#pragma mark - QIMImageEditViewControllerDelegate

- (void)imageEditVC:(QIMImageEditViewController *)imageEditVC didEditWithProductImage:(UIImage *)productImage
{
    STImgPickerController *picker = (STImgPickerController *)self.navigationController;
    if ([picker.imageDelegate respondsToSelector:@selector(qtImagePickerController:didFinishPickingImage:)])
        [picker.imageDelegate qtImagePickerController:picker didFinishPickingImage:productImage];
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}
@end
