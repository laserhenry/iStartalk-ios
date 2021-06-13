//
//  GMGridViewController.h
//  GMPhotoPicker
//
//  Created by Guillermo Muntaner Perelló on 19/09/14.
//  Copyright (c) 2014 Guillermo Muntaner Perelló. All rights reserved.
//


#import "STPHImgPickerController.h"
@interface STPHGridViewController : UICollectionViewController

@property (strong) PHFetchResult *assetsFetchResults;

-(id)initWithPicker:(STPHImgPickerController *)picker;

- (void)refresh;
    
@end
