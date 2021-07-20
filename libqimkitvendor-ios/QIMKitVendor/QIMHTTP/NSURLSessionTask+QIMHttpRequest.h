//
//  NSURLSessionTask+QIMHttpRequest.h
//  QIMKitVendor
//
//  Created by qitmac000645 on 2019/6/20.
//

#import <Foundation/Foundation.h>
#import "STHTTPRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSURLSessionTask (QIMHttpRequest)
@property(nonatomic, strong) STHTTPRequest *sessionBindRequest;
@end

NS_ASSUME_NONNULL_END
