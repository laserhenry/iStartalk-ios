//
//  QTPHImagePickerManager.m
//  QIMUIKit
//
//  Created by lilu on 2019/1/6.
//  Copyright © 2019 QIM. All rights reserved.
//

#import "STPHImgPickerManager.h"

@implementation STPHImgPickerManager

static STPHImgPickerManager *__imagePickerManager = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __imagePickerManager = [[STPHImgPickerManager alloc] init];
        __imagePickerManager.maximumNumberOfSelection = 9;
        __imagePickerManager.mixedSelection = YES;
        __imagePickerManager.canContinueSelectionVideo = YES;
    });
    return __imagePickerManager;
}

@end
