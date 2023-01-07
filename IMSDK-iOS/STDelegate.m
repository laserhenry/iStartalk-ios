//
//  STDelegate.m
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STDelegate.h"
#import <EventKit/EventKit.h>
#import <React/RCTLog.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AVFoundation/AVFoundation.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <objc/runtime.h>
#import <MAMapKit/MAMapKit.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

#if __has_include("QIMNoteManager.h")
#import "QIMNoteManager.h"
#endif

#if __has_include("QIMLocalLog.h")
#import "STLocalLog.h"
#endif
#import "AvoidCrash.h"
#import "QIMWatchDog.h"
#import "QIMJSONSerializer.h"
#import "QIMUUIDTools.h"
#import "QIMPublicRedefineHeader.h"
#import "QIMSDK.h"
#import "STShareExtensionHelper.h"
#import "STShareViewController.h"

#define GAODE_APIKEY @""

#pragma mark - 系统错误信号捕获

static int s_fatal_signals[] = {
    SIGABRT,
    SIGBUS,
    SIGFPE,
    SIGILL,
    SIGSEGV,
    SIGTRAP,
    SIGTERM,
    SIGKILL,
};

static int s_fatal_signal_num = sizeof(s_fatal_signals) / sizeof(s_fatal_signals[0]);

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols]; //得到当前调用栈信息
    NSString *reason = [exception reason]; //非常重要，就是崩溃的原因
    NSString *name = [exception name];   //异常类型
    QIMErrorLog(@"CrashMsgArray %@", arr);
    QIMErrorLog(@"CrashMsgReson %@", reason);
    QIMErrorLog(@"CrashMsgName %@", name);
    
    NSString *userId = [[STKit sharedInstance] getLastJid];
    NSString *systemVersion = [[STKit sharedInstance] SystemVersion];
    NSString *appVersion = [[STKit sharedInstance] AppBuildVersion];
    NSString *eventName = [NSString stringWithFormat:@"【%@】 -【SystemVersion:%@】-【AppVersion:%@】UncaughtExceptionHandler 捕获到崩溃了 - 【%@ %@】\n", userId, systemVersion, appVersion, name, reason];
#if __has_include("QIMLocalLog.h")

    [[STLocalLog sharedInstance] submitFeedBackWithContent:[NSString stringWithFormat:@"%@", eventName] withUserInitiative:NO];
    
#endif
    [[STKit sharedInstance] saveUserDefault];
}

void SignalHandler(int code)
{
    QIMErrorLog(@"SignalHandler = %d",code);
}

void InitCrashReport() {
    //系统错误信号捕获
    for (int i = 0; i < s_fatal_signal_num; ++i) {
        signal(s_fatal_signals[i], SignalHandler);
    }
    //oc未捕获异常的捕获
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

@interface STDelegate ()

@end

@implementation STDelegate

#pragma mark - life cicle

- (void) foo {
    [STSDKUIHelper signOutWithNoPush];
}

- (void)initRemoteNotification {
    //注册系统通知
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    //
    // So we remove all UILocalNotification -- laser
    //
 //   if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        
        UNUserNotificationCenter *notifyCenter = [UNUserNotificationCenter currentNotificationCenter];
        notifyCenter.delegate = self;
        [notifyCenter requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"通知权限request authorization successed!");
            }
        }];
        
        //用户通知权限变更
        [notifyCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            NSLog(@"用户通知权限设置%@", settings);
            NSLog(@"用户通知权限状态%ld", (long)settings.authorizationStatus); //// .authorized | .denied | .notDetermined
            NSLog(@"用户通知红角标权限%ld", (long)settings.badgeSetting); //
        }];
        UNTextInputNotificationAction *textInputAction = [UNTextInputNotificationAction actionWithIdentifier:@"comments" title:@"快捷回复" options:UNNotificationActionOptionDestructive textInputButtonTitle:@"回复" textInputPlaceholder:@"请输入回复内容"];
        //创建通知模板
        UNNotificationCategory * category = [UNNotificationCategory categoryWithIdentifier:@"msg" actions:@[textInputAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        [notifyCenter setNotificationCategories:[NSSet setWithObjects:category,nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    /*
    }else{
        UIMutableUserNotificationCategory *categorys = nil;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
            UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
            action.identifier = @"comments";
            action.title = @"回复";
            //当点击的时候不启动程序，在后台处理
            action.activationMode = UIUserNotificationActivationModeBackground;
            action.authenticationRequired = NO;
            //设置了behavior属性为 UIUserNotificationActionBehaviorTextInput 的话，则用户点击了该按钮会出现输入框供用户输入
            action.behavior = UIUserNotificationActionBehaviorTextInput;
            //这个字典定义了当用户点击了评论按钮后，输入框右侧的按钮名称，如果不设置该字典，则右侧按钮名称默认为 “发送”
            action.parameters = @{UIUserNotificationTextInputActionButtonTitleKey: @"回复"};
            
            categorys = [[UIMutableUserNotificationCategory alloc] init];
            categorys.identifier = @"msg";
            NSArray *actions = @[action];
            [categorys setActions:actions forContext:UIUserNotificationActionContextMinimal];
        }
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:[NSSet setWithObjects:categorys, nil]];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        } else {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
        }
    }
     */
#else
    /*
     
    UIMutableUserNotificationCategory *categorys = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
        action.identifier = @"comments";
        action.title = @"回复";
        //当点击的时候不启动程序，在后台处理
        action.activationMode = UIUserNotificationActivationModeBackground;
        action.authenticationRequired = YES;
        //设置了behavior属性为 UIUserNotificationActionBehaviorTextInput 的话，则用户点击了该按钮会出现输入框供用户输入
        action.behavior = UIUserNotificationActionBehaviorTextInput;
        //这个字典定义了当用户点击了评论按钮后，输入框右侧的按钮名称，如果不设置该字典，则右侧按钮名称默认为 “发送”
        action.parameters = @{UIUserNotificationTextInputActionButtonTitleKey: @"回复"};
        
        categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"msg";
        NSArray *actions = @[action];
        [categorys setActions:actions forContext:UIUserNotificationActionContextMinimal];
    }
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:[NSSet setWithObjects:categorys, nil]];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
     */
#endif
}

- (void)applicationInit {
    
    [STSDKUIHelper shareInstance];
    InitCrashReport();
    [[STKit sharedInstance] isFirstLauched];
    
    {
        // 检查版本，做首次升级使用。回头再挪
        long long localVersion = [[[STKit sharedInstance] userObjectForKey:@"QTalkApplicationLastVersion"] longLongValue];
        long long currentVersion = [[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey] longLongValue];
        
        if (localVersion != currentVersion) {
            // 清掉表情检查配置
            [[STKit sharedInstance] removeUserObjectForKey:@"emotion_check"];
        }
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([STKit getQIMProjectType] == QIMProjectTypeQChat) {
            [[STKit sharedInstance] qimNav_updateNavigationConfigWithCheck:YES];
            // 更新应用模版
            [[STSDKUIHelper shareInstance] updateMicroTourModel];
        }
    });
    {
        // 做登录超期使用
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(foo) name:@"kNotificationOutOfDateFromQTalkMainVc" object:nil];
    }
    
    {
        [self configureAPIKey];
        [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    }
    [self initRemoteNotification];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[STSDKUIHelper shareInstance] launchMainControllerWithWindow:self.window];
    //距离上次展示广告是否超过间隔时间
    NSTimeInterval nowTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval lastAdTime = [[[STKit sharedInstance] userObjectForKey:@"lastAdShowTime"] longLongValue];
    long long adShowIntervalTime = nowTime - lastAdTime;
    if ([[STKit sharedInstance] qimNav_AdShown] && [[[STKit sharedInstance] qimNav_AdItems] count] > 0 && adShowIntervalTime > [[STKit sharedInstance] qimNav_AdInterval]) {
        //展示广告window
        [[STSDKUIHelper shareInstance] launchMainAdvertWindow];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [STKit setQIMProjectType:0];
    [self applicationInit];
    [[STKit sharedInstance] chooseNewData:YES];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"应用程序将要入非活动状态执行,applicationWillResignActive");
    [[STKit sharedInstance] setWillCancelLogin:YES];
    [[STKit sharedInstance] saveUserDefault];
    if ([STKit getLastUserName]) {
        [[STKit sharedInstance] setNeedTryRelogin:YES];
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //            NSTimer *testTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(testiOS10LocalQuickReplyNotification) userInfo:nil repeats:YES];
        //            [[NSRunLoop currentRunLoop] addTimer:testTimer forMode:NSRunLoopCommonModes];
        //            [[NSRunLoop currentRunLoop] run];
        //        });
        //        [self performSelector:@selector(testiOS10LocalQuickReplyNotification) withObject:nil afterDelay:0.5];
        //        [self performSelector:@selector(testiOS10LocalQuickReplyNotification) withObject:nil afterDelay:1];
        //        [self performSelector:@selector(testiOS10LocalQuickReplyNotification) withObject:nil afterDelay:1.5];
    } else {
        //        [self testLocalQuickReplyNotification];
        //        [self performSelector:@selector(testLocalQuickReplyNotification) withObject:nil afterDelay:0.5];
        //        [self performSelector:@selector(testLocalQuickReplyNotification) withObject:nil afterDelay:1];
        //        [self performSelector:@selector(testLocalQuickReplyNotification) withObject:nil afterDelay:1.5];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    NSLog(@"应用程序入活动状态执行,applicationDidBecomeActive");
    [[STKit sharedInstance] setWillCancelLogin:YES];
    NSString *userToken = [[STKit sharedInstance] userObjectForKey:@"userToken"];
    NSString *lastUserName = [STKit getLastUserName];
    if (userToken.length > 0 && lastUserName.length > 0) {
        [[STKit sharedInstance] goOnline];
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        //        [self performSelector:@selector(testiOS10LocalQuickReplyNotification) withObject:nil afterDelay:0.5];
        //        [self performSelector:@selector(testiOS10LocalQuickReplyNotification) withObject:nil afterDelay:1];
        //        [self performSelector:@selector(testiOS10LocalQuickReplyNotification) withObject:nil afterDelay:1.5];
    } else {
        //        [self testLocalQuickReplyNotification];
        //        [self performSelector:@selector(testLocalQuickReplyNotification) withObject:nil afterDelay:0.5];
        //        [self performSelector:@selector(testLocalQuickReplyNotification) withObject:nil afterDelay:1];
        //        [self performSelector:@selector(testLocalQuickReplyNotification) withObject:nil afterDelay:1.5];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"应用程序将要入后台状态执行,applicationDidEnterBackground");
    NSLog(@"Supported background:%@", [UIDevice currentDevice].multitaskingSupported ? @"YES" : @"NO");
    [[STKit sharedInstance] setWillCancelLogin:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [[STKit sharedInstance] saveUserDefault];
        [STKit updateSessionListToKeyChain];
        [STKit updateGroupListToKeyChain];
        [STKit updateFriendListToKeyChain];
        [STKit updateRequestURL];
        [STKit updateRequestDomain];
    });
    
    [[STKit sharedInstance] updateAppNotReadCount];
    if ([STKit getLastUserName]) {
        [[STKit sharedInstance] setNeedTryRelogin:YES];
        //最近联系人数据写入3D Touch, 重新注册
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(setShortcutItems:)]) {
            [self create3DItemsWithIcons];
        }
        //设置状态为 离开
        [[STKit sharedInstance] goAway];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"应用程序将要入前台状态执行, applicationWillEnterForeground");
    [[STKit sharedInstance] setWillCancelLogin:NO];
    [[STKit sharedInstance] relogin];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 更新应用模版
        if ([STKit getQIMProjectType] == QIMProjectTypeQChat) {
            [[STSDKUIHelper shareInstance] updateMicroTourModel];
        }
    });
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[@"comments"]];
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[@"comments"]];
    [[UNUserNotificationCenter currentNotificationCenter] removeAllDeliveredNotifications];
    
    [[STKit sharedInstance] removeUserObjectForKey:@"LaunchByRemoteNotificationUserInfo"];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"App 异常退出了");
    [[STKit sharedInstance] saveUserDefault];
}

//performFetchWithCompletionHandler
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    //    [QTalkFastCommonTool excutePatch:3 completion:completionHandler];
}

#pragma mark - 本地通知
- (void)testiOS10LocalQuickReplyNotification {
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        
        UNTextInputNotificationAction * action = [UNTextInputNotificationAction actionWithIdentifier:@"comments" title:@"回复" options:UNNotificationActionOptionDestructive textInputButtonTitle:@"回复" textInputPlaceholder:@"请输入回复内容"];
        //创建通知模板
        UNNotificationCategory * category = [UNNotificationCategory categoryWithIdentifier:@"comments" actions:@[action] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        UNMutableNotificationContent * content = [UNMutableNotificationContent new];
        content.badge = @1;
        content.body = [NSString localizedUserNotificationStringForKey:@"测试推送的快捷回复" arguments:nil];
        content.subtitle = [NSString localizedUserNotificationStringForKey:@"这里是副标题" arguments:nil];
        content.title = [NSString localizedUserNotificationStringForKey:@"这里是通知的标题" arguments:nil];
        //默认的通知提示音
        content.sound = [UNNotificationSound defaultSound];
        //设置通知内容对应的模板 需要注意 这里的值要与对应模板id一致
        content.categoryIdentifier = @"comments";
        content.userInfo = @{@"aps": @{
                                     @"alert":@{
                                             @"title":@"Title is Happy day",
                                             @"subtitle":@"Subtitle is Happy day",
                                             @"body":@"按下以显示更多"
                                             },
                                     @"sound":@"新咨询的播报.wav",
                                     @"mutable-content":@(1),
                                     @"badge":@(1),
                                     },
                             @"category":@"msg",
                             @"userid":@"e5ad60f2a824456d87027246f7fa6e3d@conference.apple.com",
                             @"image":@"https://source.qunarzz.com/common/hf/logo.png"
                             };
        //设置5S之后执行
        UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObjects:category, nil]];
        UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:@"comments" content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                QIMErrorLog(@"Error");
            }
        }];
    }
#endif
}

//
// Laser revised below to UserNotification Framework
//
/*

- (void)testLocalQuickReplyNotification {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.alertBody = @"测试推送的快捷回复";
    notification.category = @"msg";
    notification.userInfo = @{@"aps":@{@"alert":@{@"body":@"测试推送进入"}, @"sound":@"hongbao.acc", @"badge": @(110), @"category":@"msg", @"userid":@"e5ad60f2a824456d87027246f7fa6e3d@conference.apple.com"},@"userid":@"e5ad60f2a824456d87027246f7fa6e3d@conference.apple.com"};
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
}
*/

#pragma mark - register notification
//ios8 需要调用内容
/*
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}
*/


//本地通知快捷回复，点击回复后回调 -- removed by Laser
/*
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UNNotificationRequest *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    NSLog(@"LocalNotification Identifier : %@, notification : %@, responseInfo : %@", identifier, notification, responseInfo);
    if ([identifier isEqualToString:@"comments"]) {
        NSString * replyValue = responseInfo[UIUserNotificationActionResponseTypedTextKey];
        NSDictionary * userInfo = notification.content.userInfo[@"aps"];
        
        if (userInfo) {
            NSString * userid1 = notification.content.userInfo[@"userid"];
            
            NSString * userid2 = userInfo[@"userid"];
            NSString * userId1 = notification.content.userInfo[@"userId"];
            NSString * userId2 = userInfo[@"userId"];
            
            if (userid1.length && replyValue.length) {
                [self send:replyValue to:userid1 extendInfo:nil msgType:QIMMessageType_Text completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                }];
            } else if (userid2.length && replyValue.length) {
                [self send:replyValue to:userid2 extendInfo:nil msgType:QIMMessageType_Text completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                }];
            } else if (userId1.length && replyValue.length) {
                [self send:replyValue to:userId1 extendInfo:nil msgType:QIMMessageType_Text completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                }];
            } else if (userId2.length && replyValue.length) {
                [self send:replyValue to:userId2 extendInfo:nil msgType:QIMMessageType_Text completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                }];
            }
        }
    }
    completionHandler();
}
//远程通知快捷回复，点击回复后回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    NSLog(@"iOS10之前远程通知快捷回复，点击回复后回调RemoteNotification Identifier : %@, userInfo : %@, responseInfo : %@", identifier, userInfo, responseInfo);
    if ([identifier isEqualToString:@"comments"]) {
        NSString * replyValue = responseInfo[UIUserNotificationActionResponseTypedTextKey];
        NSDictionary * userInfoDic = userInfo[@"aps"];
        NSLog(@"iOS10之前远程通知快捷回复 APS : %@", userInfoDic);
        if (userInfoDic) {
            
            NSString * userid = userInfo[@"userid"];
            
            if (userid.length && replyValue.length) {
                [self send:replyValue to:userid extendInfo:nil msgType:QIMMessageType_Text completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                }];
            }
        }
    }
    completionHandler();
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"收到本地通知 : %@,  userInfo : %@", notification, notification.userInfo);
    if (application.applicationState == UIApplicationStateInactive && notification.userInfo) {
        [[STKit sharedInstance] setUserObject:notification.userInfo forKey:@"LaunchByRemoteNotificationUserInfo"];
        if ([[STKit sharedInstance] appWorkState] == AppWorkState_Login) {
            [[STSDKUIHelper shareInstance] checkUpNotifacationHandle];
        }
    }else{
        [[STKit sharedInstance] removeUserObjectForKey:@"LaunchByRemoteNotificationUserInfo"];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    if (userInfo) {
        [[STKit sharedInstance] setUserObject:userInfo forKey:@"LaunchByRemoteNotificationUserInfo"];
        if (application.applicationState == UIApplicationStateInactive) {
            [[STSDKUIHelper shareInstance] checkUpNotifacationHandle];
        }
    }else{
        [[STKit sharedInstance] removeUserObjectForKey:@"LaunchByRemoteNotificationUserInfo"];
    }
}
 */

#pragma mark - iOS10接收远程通知
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSLog(@"iOS10通知快捷回复 %s : %@", __func__, response);
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    NSLog(@"iOS10通知快捷回复 userInfo : %@", userInfo);
    
    NSString *actionIdentifier = response.actionIdentifier;
    if ([actionIdentifier isEqualToString:@"comments"]) {
        if ([response respondsToSelector:@selector(userText)]) {
            NSString * replyValue = [(UNTextInputNotificationResponse *)response userText];
            NSDictionary * userInfoDic = userInfo[@"aps"];
            NSLog(@"iOS10通知快捷回复 aps : %@", userInfoDic);
            if (userInfoDic) {
                NSString *userid = userInfo[@"userid"];
                if (userid.length > 0 && replyValue.length > 0) {
                    [self send:replyValue to:userid extendInfo:nil msgType:QIMMessageType_Text completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    }];
                }
            }
        }
    } else{
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive && userInfo) {
            [[STKit sharedInstance] setUserObject:userInfo forKey:@"LaunchByRemoteNotificationUserInfo"];
            if ([[STKit sharedInstance] appWorkState] == AppWorkState_Login) {
                [[STSDKUIHelper shareInstance] checkUpNotifacationHandle];
            }
        }else{
            [[STKit sharedInstance] removeUserObjectForKey:@"LaunchByRemoteNotificationUserInfo"];
        }
    }
    completionHandler();
}

#endif

/*
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler {
    completionHandler();
}
*/
//ios8 push下拉扩展
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler {
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
    completionHandler();
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //添加token注册的回调
    
    // Token
    NSMutableString *deviceTokenString = [[NSMutableString alloc] init];
    // 获取bytes
    NSInteger length = [deviceToken length];
    if (length > 0) {
        const void *deviceBytes = [deviceToken bytes];
        for(NSInteger i = 0; i < length; i++)
        {
            [deviceTokenString appendFormat:@"%02.2hhx", ((char *)deviceBytes)[i]];
        }
        [[STKit sharedInstance] setUserObject:deviceTokenString forKey:@"myPushToken"];
        [[STKit sharedInstance] setPushToken:deviceTokenString];
        NSLog(@"注册的推送通知token : %@", deviceTokenString);
    } else {
        [[STKit sharedInstance] removeUserObjectForKey:@"myPushToken"];
        [[STKit sharedInstance] setPushToken:nil];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    QIMErrorLog(@"Push register token failed %@",error);
}

/*
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[STSDKUIHelper shareInstance] parseURL:url];
}
*/
- (void)configureAPIKey {
 
    [[STKit sharedInstance] setGAODE_APIKEY:GAODE_APIKEY];
}

- (void)send:(NSString *)content to:(NSString *)targetID extendInfo:(NSString *)extendInfo msgType:(int) msgType completionHandler:(void (^)(NSData * data, NSURLResponse * response, NSError * error))completionHandler {
    
    [[STKit sharedInstance] sendWlanMessage:content to:targetID extendInfo:extendInfo msgType:msgType completionHandler:completionHandler];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0

- (void)create3DItemsWithIcons {
    
    if ([STKit getQIMProjectType] == QIMProjectTypeQTalk) {
        
        CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (!(systemVersion >= 9.0)) {
            return;
        }
        NSString *lastUserName = [STKit getLastUserName];
        NSString * userToken = [[STKit sharedInstance] userObjectForKey:@"userToken"];
        if (lastUserName && userToken) {
            
            NSArray *applicationShortcutItems = nil;
            
            UIApplicationShortcutIcon *quickChatIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"qunar-msg_empty_o"];
            UIMutableApplicationShortcutItem *quickStartChatItem = [[UIMutableApplicationShortcutItem alloc]initWithType:@"quickChat" localizedTitle:@"发起聊天" localizedSubtitle:@"" icon:quickChatIcon userInfo:nil];
            UIApplicationShortcutIcon *lastedSingleChatIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"qunar-porfile_o"];
            NSDictionary *lastedSingleChatDic = [[STKit sharedInstance] getLastedSingleChatSession];
            NSString *userId = nil;
            NSString *userName = nil;
            if (lastedSingleChatDic.count) {
                userId = lastedSingleChatDic[@"XmppId"];
                if (userId) {
                    NSDictionary *userInfo = [[STKit sharedInstance] getUserInfoByUserId:userId];
                    if (userInfo.count) {
                        userName = userInfo[@"Name"];
                        if (userName) {
                            UIMutableApplicationShortcutItem *lastedSingleChatItem = [[UIMutableApplicationShortcutItem alloc]initWithType:@"lastestSingleChat" localizedTitle:userName localizedSubtitle:@"" icon:lastedSingleChatIcon userInfo:userInfo];
                            applicationShortcutItems = @[quickStartChatItem, lastedSingleChatItem];
                        }
                    }
                }
            } else {
                applicationShortcutItems = @[quickStartChatItem];
            }
            
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(setShortcutItems:)]) {
                [UIApplication sharedApplication].shortcutItems = applicationShortcutItems;
            }
        } else {
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(setShortcutItems:)]) {
                [UIApplication sharedApplication].shortcutItems = nil;
            }
        }
    }
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
    //判断先前我们设置的唯一标识
    
    //我的二维码
    if ([shortcutItem.type isEqualToString:@"MyQRCode"]) {
        [STSDKUIHelper showQRCodeWithQRId:[[STKit sharedInstance] getLastJid] withType:QRCodeType_UserQR];
    }
    //扫一扫
    if([shortcutItem.type isEqualToString:@"qrcode"]){
        [STSDKUIHelper openQRCodeVC];
    }
    //发起聊天
    if ([shortcutItem.type isEqualToString:@"quickChat"]) {
        [STSDKUIHelper openQIMGroupListVC];
    }
    //最近联系人
    if ([shortcutItem.type isEqualToString:@"lastestSingleChat"]) {
        NSDictionary *resultInfo = shortcutItem.userInfo;
        [[STKit sharedInstance] openChatSessionByUserId:[resultInfo objectForKey:@"XmppId"]];
        NSString *jid = [resultInfo objectForKey:@"XmppId"];
        [STSDKUIHelper openSingleChatVCByUserId:jid];
    }
}
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    
    return NO;
}

#else
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options {
    
    if([url.scheme isEqualToString:@"startalk"] && [url.host isEqualToString:@"share"]){
        STShareExtensionHelper * shareHelper = [STShareExtensionHelper sharedInstance];
        NSArray* items = [shareHelper shareItems];
        if(items != nil && items.count > 0){
            [self showShareController];
        }
    }else if(url.isFileURL){
        NSDictionary* shareItem = @{@"type": @"file", @"name": url.lastPathComponent, @"path": url.path};
        STShareExtensionHelper * shareHelper = [STShareExtensionHelper sharedInstance];
        [shareHelper setItems:@[shareItem]];
        [self showShareController];
    }
    
    return YES;
}

- (void) showShareController{
    UIViewController* rootViewController = self.window.rootViewController;
    UIViewController * shareViewController = [STShareViewController new];
    shareViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [rootViewController presentViewController: shareViewController animated: NO completion:^{}];
}
#endif

@end
