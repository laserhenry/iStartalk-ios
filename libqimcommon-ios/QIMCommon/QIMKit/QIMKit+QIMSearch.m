//
//  QIMKit+QIMSearch.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMSearch.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMSearch)

- (void)searchWithUrl:(NSString *)url withParams:(NSDictionary *)params withSuccessCallBack:(QIMKitSearchSuccessBlock)successCallback withFaildCallBack:(QIMKitSearchFaildBlock)faildCallback {
    [[STManager sharedInstance] searchWithUrl:url withParams:params withSuccessCallBack:successCallback withFaildCallBack:faildCallback];
}

#pragma mark - Searchkey History

- (void)getRemoteSearchKeyHistory {
    [[STManager sharedInstance] getRemoteSearchKeyHistory];
}

- (NSArray *)getLocalSearchKeyHistoryWithSearchType:(NSInteger)searchType withLimit:(NSInteger)limit {
    return [[STManager sharedInstance] getLocalSearchKeyHistoryWithSearchType:searchType withLimit:limit];
}

- (void)updateLocalSearchKeyHistory:(NSDictionary *)searchDic {
    [[STManager sharedInstance] updateLocalSearchKeyHistory:searchDic];
}

- (void)deleteSearchKeyHistory {
    [[STManager sharedInstance] deleteSearchKeyHistory];
}

@end
