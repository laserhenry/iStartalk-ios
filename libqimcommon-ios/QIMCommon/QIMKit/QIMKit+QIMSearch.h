//
//  QIMKit+QIMSearch.h
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

@interface STKit (QIMSearch)

- (void)searchWithUrl:(NSString *)url withParams:(NSDictionary *)params withSuccessCallBack:(QIMKitSearchSuccessBlock)successCallback withFaildCallBack:(QIMKitSearchFaildBlock)faildCallback;

#pragma mark - Searchkey History

- (void)getRemoteSearchKeyHistory;

- (NSArray *)getLocalSearchKeyHistoryWithSearchType:(NSInteger)searchType withLimit:(NSInteger)limit;

- (void)updateLocalSearchKeyHistory:(NSDictionary *)searchDic;

- (void)deleteSearchKeyHistory;

@end

NS_ASSUME_NONNULL_END
