//
//  IMDataManager+QIMSearchKeyHistory.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STDataMgr.h"

NS_ASSUME_NONNULL_BEGIN

@interface STDataMgr (QIMSearchKeyHistory)

- (NSArray *)qimDB_getLocalSearchKeyHistoryWithSearchType:(NSInteger)searchType withLimit:(NSInteger)limit;

- (void)qimDB_updateLocalSearchKeyHistory:(NSDictionary *)searchDic;

- (void)qimDB_deleteSearchKeyHistoryWithSearchType:(NSInteger)searchType;

- (void)qimDB_deleteSearchKeyHistory;

@end

NS_ASSUME_NONNULL_END
