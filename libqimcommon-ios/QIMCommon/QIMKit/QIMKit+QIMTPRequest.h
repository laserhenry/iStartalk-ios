//
//  QIMKit+QIMTPRequest.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMTPRequest)

- (void)sendTPPOSTRequestWithUrl:(NSString *)url withSuccessCallBack:(QIMKitSendTPRequesSuccessedBlock)sCallback withFailedCallBack:(QIMKitSendTPRequesFailedBlock)fCallback;

- (void)sendTPPOSTRequestWithUrl:(NSString *)url withRequestBodyData:(NSData *)bodyData withSuccessCallBack:(QIMKitSendTPRequesSuccessedBlock)sCallback withFailedCallBack:(QIMKitSendTPRequesFailedBlock)fCallback;

- (void)sendTPPOSTRequestWithUrl:(NSString *)url withChatId:(NSString *)chatId withRealJid:(NSString *)realJid withChatType:(ChatType)chatType;

- (void)sendTPGetRequestWithUrl:(NSString *)url
           withProgressCallBack:(QIMKitSendTPRequesProgressBlock)pCallback
            withSuccessCallBack:(QIMKitSendTPRequesSuccessedBlock)sCallback withFailedCallBack:(QIMKitSendTPRequesFailedBlock)fCallback;

- (void)sendTPGetRequestWithUrl:(NSString *)url withSuccessCallBack:(QIMKitSendTPRequesSuccessedBlock)sCallback withFailedCallBack:(QIMKitSendTPRequesFailedBlock)fCallback;

- (void)synchronizeDujiaWarningWithJid:(NSString *)dujiaJid;

- (void)sendTPPOSTFormUrlEncodedRequestWithUrl:(NSString *)url withRequestBodyData:(NSData *)bodyData withSuccessCallBack:(QIMKitSendTPRequesSuccessedBlock)sCallback withFailedCallBack:(QIMKitSendTPRequesFailedBlock)fCallback;

- (void)downloadFileRequest:(NSString *)downloadFileUrl withTargetFilePath:(NSString *)targetFilePath withProgressBlock:(QIMKitSendTPRequesProgressBlock)pCallback withSuccessCallBack:(QIMKitSendTPRequesSuccessedBlock)sCallback withFailedCallBack:(QIMKitSendTPRequesFailedBlock)fCallback;

- (void)sendTPGETFormUrlEncodedRequestWithUrl:(NSString *)url withSuccessCallBack:(QIMKitSendTPRequesSuccessedBlock)sCallback withFailedCallBack:(QIMKitSendTPRequesFailedBlock)fCallback;

@end
