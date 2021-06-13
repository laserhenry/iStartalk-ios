//
//  QIMSDKUIHelper.m
//  QIMSDK
//
//  Created by 李露 on 2018/9/29.
//  Copyright © 2018年 QIM. All rights reserved.
//

#import "STSDKUIHelper.h"
#import "STFastEntrance.h"
#import "STNotificationMgr.h"
//#import "QIMBusinessModleUpdate.h"
#import "STRemoteNotificationMgr.h"

@interface STSDKUIHelper ()

@property (nonatomic, strong) UINavigationController *rootNav;

@property (nonatomic, strong) UIViewController *rootVc;

@end

@implementation STSDKUIHelper

+ (void)load {
    
    [STNotificationMgr sharedInstance];
}

static STSDKUIHelper *_uiHelper = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _uiHelper = [[STSDKUIHelper alloc] init];
        [STKit sharedInstance];
    });
    return _uiHelper;
}

+ (instancetype)sharedInstanceWithRootNav:(UINavigationController *)rootNav rootVc:(UIViewController *)rootVc {
    STSDKUIHelper *helper = [STSDKUIHelper shareInstance];
    if (rootNav && rootVc) {
        helper.rootNav = rootNav;
        helper.rootVc = rootVc;
        [STFastEntrance sharedInstanceWithRootNav:rootNav rootVc:rootVc];
    } else {
        NSAssert(rootNav, @"RootNav shuold not be nil, Please check the rootNav");
        NSAssert(rootVc, @"RootVc should not be nil, Please check the rootVC");
    }
    return helper;
}

- (void)checkUpNotifacationHandle {
    [STRemoteNotificationMgr checkUpNotifacationHandle];
}

- (void)updateMicroTourModel {
//    [QIMBusinessModleUpdate updateMicroTourModel];
}

@end
