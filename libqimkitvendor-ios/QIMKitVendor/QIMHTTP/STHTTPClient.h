//
//  STHTTPClient.h
//  QIMKitVendor
//
//  Created by 李露 on 2018/8/2.
//  Copyright © 2018年 QIM. All rights reserved.
//  Copyright © 2021 Startalk Ltd.
//

#import <Foundation/Foundation.h>
#import "STHTTPRequest.h"
#import "QIMHttpCommon.h"

@interface STHTTPClient : NSObject

/**
 设置公共请求头参数，公共请求参数
 */
+ (void)setCommonRequestConfig:(void (^)(QIMHttpRequestConfig *config))configBlock;

/**
 切换至AFN后使用

 @param request 请求参数
 @param successHandler 请求成功返回，直接返回解析后的responseObj，非data
 @param failureHandler 请求失败返回，返回error
 */
+ (void)sendRequest:(STHTTPRequest *)request success:(QIMSuccessHandler)successHandler failure:(QIMFailureHandler)failureHandler;

//做ASI兼容，之后此方法不会用
+ (void)sendRequest:(STHTTPRequest *)request
           complete:(QIMCompleteHandler)completeHandler
            failure:(QIMFailureHandler)failureHandler NS_DEPRECATED_IOS(8_0, 9_0, "Method deprecated. Use setCommonRequestConfig instead.");


+ (void)sendRequest:(STHTTPRequest *)request
      progressBlock:(QIMProgressHandler)progreeBlock
           complete:(QIMCompleteHandler)completeHandler
            failure:(QIMFailureHandler)failureHandler;

@end
