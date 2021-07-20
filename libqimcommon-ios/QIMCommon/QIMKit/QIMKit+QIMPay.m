//
//  QIMKit+QIMPay.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMPay.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMPay)

- (void)getBindPayAccount:(NSString *)userid withCallBack:(QIMKitPayCheckAccountBlock)callBack{
    [[STManager sharedInstance] getBindPayAccount:userid withCallBack:callBack];
}

- (void)sendRedEnvelop:(NSDictionary *)params withCallBack:(QIMKitPayCreateRedEnvelopBlock)callBack{
    [[STManager sharedInstance] sendRedEnvelop:params withCallBack:callBack];
}

- (void)bindAlipayAccount:(NSString *)aliOpenid withAliUid:(NSString *)aliUid userId:(NSString *)userid{
    [[STManager sharedInstance] bindAlipayAccount:aliOpenid withAliUid:aliUid userId:userid];
}

- (void)getRedEnvelopDetail:(NSString *)xmppid RedRid:(NSString *)rid IsChatRoom:(NSInteger)isRoom withCallBack:(QIMKitPayRedEnvelopDetailBlock)callBack{
    [[STManager sharedInstance] getRedEnvelopDetail:xmppid RedRid:rid IsChatRoom:isRoom withCallBack:callBack];
}

- (void)redEnvelopReceive:(NSInteger)page PageSize:(NSInteger)pageSize WithYear:(NSInteger)year withCallBack:(QIMKitPayRedEnvelopReceiveBlock)callBack{
    [[STManager sharedInstance] redEnvelopReceive:page PageSize:pageSize WithYear:year withCallBack:callBack];
}

- (void)redEnvelopSend:(NSInteger)page PageSize:(NSInteger)pageSize WithYear:(NSInteger)year withCallBack:(QIMKitPayRedEnvelopSendBlock)callBack{
    [[STManager sharedInstance] redEnvelopSend:page PageSize:pageSize WithYear:year withCallBack:callBack];
}

- (void)openRedEnvelop:(NSString *)xmppid RedRid:(NSString *)rid IsChatRoom:(NSInteger)isRoom withCallBack:(QIMkitPayRedEnvelopOpenBlock)callBack{
    [[STManager sharedInstance] openRedEnvelop:xmppid RedRid:rid IsChatRoom:isRoom withCallBack:callBack];
}

- (void)grapRedEnvelop:(NSString *)xmppid RedRid:(NSString *)rid IsChatRoom:(NSInteger)isRoom withCallBack:(QIMKitPayRedEnvelopGrapBlock)callBack{
    [[STManager sharedInstance] grapRedEnvelop:xmppid RedRid:rid IsChatRoom:isRoom withCallBack:callBack];
}

- (void)getAlipayLoginParams {
    [[STManager sharedInstance] getAlipayLoginParams];
}

@end
