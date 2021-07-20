//
//  QIMHttpRequestEngine.h
//  QIMKitVendor
//
//  Created by qitmac000645 on 2019/6/19.
//

#import <Foundation/Foundation.h>
#import "QIMHttpCommon.h"
@class STHTTPRequest;
NS_ASSUME_NONNULL_BEGIN

typedef void(^QIMHttpCompletionHandler)(id _Nullable responseObject, NSInteger HTTPStatusCode, NSError * _Nullable error);

@interface QIMHttpRequestEngine : NSObject

+(instancetype)shareEngine;

- (void)sendRequest:(STHTTPRequest *)request completionHandle:(QIMHttpCompletionHandler)completionHandler;

- (STHTTPRequest *)cancelRequestIdentifier:(NSString *)identifier;

- (STHTTPRequest *)getRequestWithIdentifier:(NSString *)identifier;

- (void)setMaxCurrentOperationCount:(NSInteger)count;

- (NSInteger)reacheablityStatus;

@end

NS_ASSUME_NONNULL_END
