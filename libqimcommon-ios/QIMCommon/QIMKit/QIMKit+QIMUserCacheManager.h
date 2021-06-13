//
//  QIMKit+QIMUserCacheManager.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMUserCacheManager)

- (void)chooseNewData:(BOOL)flag;
- (void)setCacheName:(NSString *)cacheName;

- (BOOL)containsObjectForKey:(NSString *)key;
- (void)setUserObject:(nullable id)object forKey:(nonnull NSString *)aKey;
- (nullable id)userObjectForKey:(nonnull NSString *)aKey;
- (void)removeUserObjectForKey:(nonnull NSString *)aKey;
- (void)clearUserCache;
- (void)saveUserDefault;

- (void)removeUserDefaultFilePath;

@end
