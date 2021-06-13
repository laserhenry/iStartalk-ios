//
//  DataController.h
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//  Created by wangshihai on 14/12/30.
//  Copyright (c) 2014年 ping.xue. All rights reserved.
//
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface STDataContraller : NSObject

+ (STDataContraller *)getInstance;

-(void)save;

-(void)deleteResourceWithFileName:(NSString *)fileName;

- (void)saveResourceWithFileName:(NSString *)fileName data:(NSData *)data;

- (UIImage *)getResourceImage:(NSString *)key;

- (void)addResource:(id)resource withKey:(NSString *)key;

- (NSString *)getSourcePath:(NSString *)fileName;

- (void) removeAllImage;

- (void)clearLogFiles;

- (long long)sizeofImagePath;

- (long long)sizeOfDBPath;
    
- (long long)sizeOfDBWALPath;

- (NSString *)transfromTotalSize:(long long)totalSize;

@end
