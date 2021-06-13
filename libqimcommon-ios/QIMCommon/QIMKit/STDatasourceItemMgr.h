//
//  QIMDatasourceItemManager.h
//  QIMCommon
//
//  Created by lilu on 2019/3/18.
//  Copyright © 2019 QIM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STDatasourceItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface STDatasourceItemMgr : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)getQIMMergedRootBranch;
- (NSDictionary *)getChildItems;
- (NSDictionary *)getTotalItems;

- (STDatasourceItem *)getChildDataSourceItemWithId:(NSString *)itemId;

- (STDatasourceItem *)getTotalDataSourceItemWithId:(NSString *)itemId;

- (void)addChildDataSourceItem:(STDatasourceItem *)item WithId:(NSString *)itemId;

- (void)addTotalDataSourceItem:(STDatasourceItem *)item WithId:(NSString *)itemId;


-(void)expandBranchAtIndex:(NSInteger)index;

-(void)collapseBranchAtIndex:(NSInteger)index;

- (void)createDataSource;

@end

NS_ASSUME_NONNULL_END
