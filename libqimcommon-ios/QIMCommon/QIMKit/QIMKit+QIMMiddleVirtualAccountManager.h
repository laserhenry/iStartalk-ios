//
//  QIMKit+QIMMiddleVirtualAccountManager.h
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

@interface STKit (QIMMiddleVirtualAccountManager)

- (NSArray *)getMiddleVirtualAccounts;

- (BOOL)isMiddleVirtualAccountWithJid:(NSString *)jid;

@end

NS_ASSUME_NONNULL_END
