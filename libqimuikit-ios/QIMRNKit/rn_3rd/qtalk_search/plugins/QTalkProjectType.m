//
//  QTalkProjectType.m
//  qunarChatIphone
//
//  Created by wangyu.wang on 16/9/12.
//
//

#import "QTalkProjectType.h"
//#import "Login.h"

@implementation QTalkProjectType

// The React Native bridge needs to know our module
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(getProjectType:(RCTResponseSenderBlock)success:(RCTResponseSenderBlock)error) {
    
    NSDictionary *responseData = nil;
    
    NSString *key = [[STKit sharedInstance] thirdpartKeywithValue];
    NSString *lastJid = [[STKit sharedInstance] getLastJid];
    NSString *myNickName = [[STKit sharedInstance] getMyNickName];
    NSString *realKey = key.length ? key : @"";
    NSString *realLastJid = lastJid.length ? lastJid : @"";
    NSString *realMyNickName = myNickName.length ? myNickName : @"";
    if ([STKit getQIMProjectType] == QIMProjectTypeQTalk) {
        // qtalk
        NSNumber *WorkFeedEntrance = [[STKit sharedInstance] userObjectForKey:@"kUserWorkFeedEntrance"];
        if (WorkFeedEntrance == nil) {
            WorkFeedEntrance = @(NO);
        }
        NSLog(@"WorkFeedEntrance : %@", WorkFeedEntrance);
        responseData = @{@"isQTalk": @YES, @"domain": realLastJid, @"fullname": realMyNickName, @"c_key": realKey, @"checkUserKeyHost":[[STKit sharedInstance] qimNav_HttpHost], @"showOA":@([[STKit sharedInstance] qimNav_ShowOA]), @"isShowWorkWorld":WorkFeedEntrance};
    } else {
        // qchat
        BOOL is = [[STKit sharedInstance] isMerchant];
        NSNumber *isSupplier = is == YES ? @YES : @NO;
        
        responseData = @{@"isQTalk": @NO, @"domain": realLastJid, @"fullname": realMyNickName, @"c_key": realKey, @"isSupplier": isSupplier};
    }
    QIMVerboseLog(@"getProjectType : %@", responseData);
    success(@[responseData]);
}

@end
