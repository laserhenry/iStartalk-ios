//
//  NSURLSessionTask+QIMHttpRequest.m
//  QIMKitVendor
//
//  Created by qitmac000645 on 2019/6/20.
//

#import "NSURLSessionTask+QIMHttpRequest.h"
#import <objc/runtime.h>

@implementation NSURLSessionTask (QIMHttpRequest)

- (STHTTPRequest *)sessionBindRequest {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSessionBindRequest:(STHTTPRequest *)sessionBindRequest {
    objc_setAssociatedObject(self, @selector(sessionBindRequest), sessionBindRequest, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
