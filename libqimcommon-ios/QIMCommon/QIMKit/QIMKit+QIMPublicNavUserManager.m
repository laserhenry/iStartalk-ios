//
//  QIMKit+QIMPublicNavUserManager.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMPublicNavUserManager.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMPublicNavUserManager)

- (void)getPublicNavCompanyWithKeyword:(NSString *)keyword withCallBack:(QIMKitgetPublicCompanySuccessedBlock)callback {
    [[QIMManager sharedInstance] getPublicNavCompanyWithKeyword:keyword withCallBack:callback];
}

@end
