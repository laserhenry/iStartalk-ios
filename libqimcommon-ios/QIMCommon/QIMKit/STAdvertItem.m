//
//  QIMAdvertItem.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STAdvertItem.h"

@implementation STAdvertItem

- (void)dealloc{
    [self setAdLinkUrl:nil];
    [self setAdImgUrl:nil];
}

@end
