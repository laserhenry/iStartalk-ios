//
//  QIMKit+QIMUserCacheManager.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMUserCacheManager.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMUserCacheManager)

- (void)chooseNewData:(BOOL)flag {
    [[STUserCacheManager sharedInstance] chooseNewData:flag];
}

- (void)setCacheName:(NSString *)cacheName {
    [[STUserCacheManager sharedInstance] setCacheName:cacheName];
}

- (BOOL)containsObjectForKey:(NSString *)key {
    return [[STUserCacheManager sharedInstance] containsObjectForKey:key];
}
- (void)setUserObject:(nullable id)object forKey:(nonnull NSString *)aKey {
    [[STUserCacheManager sharedInstance] setUserObject:object forKey:aKey];
}

- (nullable id)userObjectForKey:(nonnull NSString *)aKey {
    return [[STUserCacheManager sharedInstance] userObjectForKey:aKey];
}

- (void)removeUserObjectForKey:(nonnull NSString *)aKey {
    [[STUserCacheManager sharedInstance] removeUserObjectForKey:aKey];
}

- (void)clearUserCache {
    [[STUserCacheManager sharedInstance] clearUserCache];
}

- (void)saveUserDefault {
    [[STUserCacheManager sharedInstance] saveUserDefault];
}

- (void)removeUserDefaultFilePath {
    [[STUserCacheManager sharedInstance] removeUserDefaultFilePath];
}

@end
