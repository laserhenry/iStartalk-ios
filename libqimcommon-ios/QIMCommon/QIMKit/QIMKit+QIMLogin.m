//
//  QIMKit+QIMLogin.m
//  qunarChatIphone
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//

#import "QIMKit+QIMLogin.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMLogin)

#pragma mark - setter and getter

- (void)setIsBackgroundLogin:(BOOL)isBackgroundLogin {
    [[STManager sharedInstance] setIsBackgroundLogin:isBackgroundLogin];
}

- (BOOL)isBackgroundLogin {
    return [[STManager sharedInstance] isBackgroundLogin];
}

- (void)setWillCancelLogin:(BOOL)willCancelLogin {
    [[STManager sharedInstance] setWillCancelLogin:willCancelLogin];
}

- (BOOL)willCancelLogin {
    return [[STManager sharedInstance] willCancelLogin];
}

- (void)setNeedTryRelogin:(BOOL)needTryRelogin {
    [[STManager sharedInstance] setNeedTryRelogin:needTryRelogin];
}

- (BOOL)needTryRelogin {
    return [[STManager sharedInstance] needTryRelogin];
}

#pragma mark - 登录

- (void)cancelLogin {
    
    [[STManager sharedInstance] cancelLogin];
}

- (void)sendHeartBeat {
    [[STManager sharedInstance] sendHeartBeat];
}

- (BOOL)isLogin {
    return [[STManager sharedInstance] isLogin];
}

- (void)loginWithUserName:(NSString *)userName WithPassWord:(NSString *)pwd {
    [[STManager sharedInstance] loginWithUserName:userName WithPassWord:pwd];
}

- (void)loginWithUserName:(NSString *)userName WithPassWord:(NSString *)pwd WithLoginNavDict:(NSDictionary *)navDict {
    [[STManager sharedInstance] loginWithUserName:userName WithPassWord:pwd WithLoginNavDict:navDict];
}

- (void)addUserCacheWithUserId:(NSString *)userId WithUserFullJid:(NSString *)userFullJid WithNavDict:(NSDictionary *)navDict {
    [[STManager sharedInstance] addUserCacheWithUserId:userId WithUserFullJid:userFullJid WithNavDict:navDict];
}

- (NSArray *)getLoginUsers {
    return [[STManager sharedInstance] getLoginUsers];
}

- (void)clearLogginUser {
    [[STManager sharedInstance] clearLogginUser];
}

- (void)clearUserToken {
    [[STManager sharedInstance] clearUserToken];
}

- (void)saveUserInfoWithName:(NSString *)userName passWord:(NSString *)pwd {
    [[STManager sharedInstance] saveUserInfoWithName:userName passWord:pwd];
}

- (void)quitLogin {
    
    [[STManager sharedInstance] quitLogin];
}

- (void)QChatLoginWithUserId:(NSString *)userId rsaPassword:(NSString *)password type:(NSString *)type withCallback:(QIMKitGetQChatBetaLoginTokenDic)callback {
    [[STManager sharedInstance] QChatLoginWithUserId:userId rsaPassword:password type:type withCallback:callback];
}

- (NSString *)getFormStringByDiction:(NSDictionary *)diction {
    
    return [[STManager sharedInstance] getFormStringByDiction:diction];
}

- (void)relogin {
    [[STManager sharedInstance] relogin];
}

- (BOOL)forgelogin {
    return [[STManager sharedInstance] forgelogin];
}

#pragma mark - 验证码

- (void)getUserTokenWithUserName:(NSString *)userName WithVerifyCode:(NSString *)verifCode withCallback:(QIMKitGetUserTokenSuccessBlock)callback {
    [[STManager sharedInstance] getUserTokenWithUserName:userName WithVerifyCode:verifCode withCallback:callback];
}

- (void)getVerifyCodeWithUserName:(NSString *)userName withCallback:(QIMKitGetVerifyCodeSuccessBlock)callback {
    [[STManager sharedInstance] getVerifyCodeWithUserName:userName withCallback:callback];
}

- (void)getNewUserTokenWithUserName:(NSString *)userName WithPassword:(NSString *)password withCallback:(QIMKitGetUserNewTokenSuccessBlock)callback {
    [[STManager sharedInstance] getNewUserTokenWithUserName:userName WithPassword:password withCallback:callback];
}

@end
