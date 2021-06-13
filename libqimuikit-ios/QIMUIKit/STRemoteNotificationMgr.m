//
//  QIMRemoteNotificationManager.m
//  qunarChatIphone
//
//  Created by chenjie on 2016/09/14.
//
//

#import "STRemoteNotificationMgr.h"
#import "QIMCommonUIFramework.h"
#import "UIApplication+QIMApplication.h"
#import "QIMGroupChatVC.h"
#import "QIMChatVC.h"

@implementation STRemoteNotificationMgr

+ (void)checkUpNotifacationHandle {
    
    NSDictionary * infoDic = [[STKit sharedInstance] userObjectForKey:@"LaunchByRemoteNotificationUserInfo"];
    if (infoDic) {
        [self openChatSessionWithInfoDic:infoDic];
        [[STKit sharedInstance] removeUserObjectForKey:@"LaunchByRemoteNotificationUserInfo"];
    }
}

//前往回话列表
+ (void)openChatSessionWithInfoDic:(NSDictionary *)userInfo
{
    UIViewController *rootViewController = [[UIApplication sharedApplication] visibleViewController];
    NSLog(@"rootViewController : %@", rootViewController);
    Class QIMMainVCClass = NSClassFromString(@"QIMMainVC");
    if (userInfo.count && [rootViewController isKindOfClass:QIMMainVCClass]) {
        NSString * userId = userInfo[@"userid"];
        if (userId.length) {
            if ([[[STKit sharedInstance] getCurrentSessionUserId] isEqualToString:userId]) {
                return;
            }
            NSInteger chatType = [[userInfo objectForKey:@"chattype"] integerValue];
            switch (chatType) {
                case 6: {
                    [STFastEntrance openSingleChatVCByUserId:userId];
                }
                    break;
                case 7: {
                    [STFastEntrance openGroupChatVCByGroupId:userId];
                }
                    break;
                case 132: {
                    NSInteger qchatId = [[userInfo objectForKey:@"chatid"] integerValue];
                    NSString *realJid = [userInfo objectForKey:@"realjid"];
                    if (qchatId == 4) {
                        [STFastEntrance openConsultServerChatByChatType:ChatType_ConsultServer WithVirtualId:userId WithRealJid:realJid];
                    } else {
                        [STFastEntrance openConsultChatByChatType:ChatType_Consult UserId:realJid WithVirtualId:userId];
                    }
                }
                    break;
                default:
                    break;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotifySelectTab object:@(0)];
        }
    }
}


@end
