//
//  QIMAdvertItem.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "QIMCommonEnum.h"

@interface STAdvertItem : NSObject

@property (nonatomic, assign) AdvertType adType;
@property (nonatomic, strong) NSString *adLinkUrl;
@property (nonatomic, strong) NSString *adImgUrl;

@end
