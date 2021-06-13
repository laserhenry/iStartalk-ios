//
//  QIMKit+QIMPublicNavUserManager.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface STKit (QIMPublicNavUserManager)

- (void)getPublicNavCompanyWithKeyword:(NSString *)keyword withCallBack:(QIMKitgetPublicCompanySuccessedBlock)callback;

@end

NS_ASSUME_NONNULL_END
