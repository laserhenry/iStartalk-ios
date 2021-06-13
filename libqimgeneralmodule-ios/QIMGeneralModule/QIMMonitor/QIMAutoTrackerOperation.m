//
//  QIMAutoTrackerOperation.m
//  QIMAutoTracker
//
//  Created by lilulucas.li on 2019/04/18.
//

#import "QIMAutoTrackerOperation.h"
#import "QIMAutoTrackerManager.h"
#import "NSObject+QIMAutoTracker.h"
#import "QIMAutoTrackerDataManager.h"
#import "QIMKitPublicHeader.h"
#import "QIMJSONSerializer.h"
#import "STDataContraller.h"

@implementation QIMAutoTrackerOperation

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

/**
 发送日志
 
 @param eventId 日志id
 @param info 日志内容
 */
- (void)sendTrackerData:(NSString *)eventId info:(NSDictionary *)info {
    NSDictionary *trackerDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
            eventId.length > 0 ? eventId : @"", QIMAutoTrackerEventIDKey,
            info ? info : [[NSDictionary alloc] init], QIMAutoTrackerInfoKey, nil];

    if ([QIMAutoTrackerManager sharedInstance].configArray.count > 0 &&
            eventId.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(DD_TRACKER_EVENTID_KEY == %@)", eventId];
        NSArray *filtered = [[QIMAutoTrackerManager sharedInstance].configArray filteredArrayUsingPredicate:predicate];
        if ([filtered count] > 0) {
            if ([QIMAutoTrackerManager sharedInstance].successBlock) {
                [QIMAutoTrackerManager sharedInstance].successBlock(trackerDictionary);
            }
        }
    }

    if ([QIMAutoTrackerManager sharedInstance].isDebug &&
            [QIMAutoTrackerManager sharedInstance].debugBlock) {
        [QIMAutoTrackerManager sharedInstance].debugBlock(trackerDictionary);
    }
}

- (void)uploadTracerData {
    if ([[STKit sharedInstance] qimNav_UploadLog].length > 0) {
        long long reportTime = [[NSDate date] timeIntervalSince1970] * 1000;
        NSArray *traceLogs = [[QIMAutoTrackerDataManager qimDB_sharedLogDBInstance] qim_getTraceLogWithReportTime:reportTime];
        if (traceLogs.count > 0) {
            NSMutableDictionary *oldNavConfigUrlDict = [[STKit sharedInstance] userObjectForKey:@"QC_CurrentNavDict"];
            NSLog(@"本地找到的oldNavConfigUrlDict : %@", oldNavConfigUrlDict);
            NSString *navUrl = [oldNavConfigUrlDict objectForKey:@"NavUrl"];
            NSString *uid = [STKit getLastUserName];
            NSString *domain = [[STKit sharedInstance] getDomain];
            NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:3];
            if (uid.length && domain.length) {
                NSDictionary *userInfo = @{@"uid": uid, @"domain": domain, @"nav": navUrl};
                [result setObject:userInfo forKey:@"user"];

                NSMutableDictionary *deviceInfo = [NSMutableDictionary dictionaryWithCapacity:3];
                /*
                 "os": "iOS",
                 "osBrand": "iPhoneXMax",
                 "osModel": "iPhoneXMax",
                 "osVersion": 26,
                 "versionCode": 218,
                 "versionName": "3.1.0",
                 "plat": "qtalk",
                 "ip": "127.0.0.1",
                 "lat": "39.983605",
                 "lgt": "116.312536",
                 "net": "WIFI"
                 */
                NSString *os = @"iOS";
                NSString *osBrand = [[STKit sharedInstance] deviceName];
                NSString *osModel = [[STKit sharedInstance] deviceName];
                NSString *osVersion = [[STKit sharedInstance] SystemVersion];
                NSString *versionCode = [[STKit sharedInstance] AppBuildVersion];
                NSString *versionName = [[STKit sharedInstance] AppVersion];
                NSString *plat = [STKit getQIMProjectTitleName];
                
                long long dbSize = [[STDataContraller getInstance] sizeOfDBPath];
                long long dbWalSize = [[STDataContraller getInstance] sizeOfDBWALPath];
                NSString *dbSizeStr = [[STDataContraller getInstance] transfromTotalSize:dbSize];
                NSString *dbWalSizeStr = [[STDataContraller getInstance] transfromTotalSize:dbWalSize];
                
                NSString *allDBSize = [NSString stringWithFormat:@"DBDataSize : %@, DBDataWalSize : %@", dbSizeStr, dbWalSizeStr];

                [deviceInfo setObject:os forKey:@"os"];
                [deviceInfo setObject:osBrand forKey:@"osBrand"];
                [deviceInfo setObject:osModel forKey:@"osModel"];
                [deviceInfo setObject:osVersion forKey:@"osVersion"];
                [deviceInfo setObject:versionCode forKey:@"versionCode"];
                [deviceInfo setObject:versionName forKey:@"versionName"];
                [deviceInfo setObject:plat forKey:@"plat"];
                [deviceInfo setObject:allDBSize ? allDBSize : @"" forKey:@"DBSize"];

                [result setObject:deviceInfo forKey:@"device"];

                [result setObject:traceLogs forKey:@"infos"];

                NSData *data = [[QIMJSONSerializer sharedInstance] serializeObject:result error:nil];
                [[STKit sharedInstance] sendTPPOSTRequestWithUrl:[[STKit sharedInstance] qimNav_UploadLog] withRequestBodyData:data withSuccessCallBack:^(NSData *responseData) {
                    NSLog(@"清除本地日志上报数据");
                    [[QIMAutoTrackerDataManager qimDB_sharedLogDBInstance] qim_deleteTraceLog];
                }                              withFailedCallBack:^(NSError *error) {

                }];
            }
        }
    }
}

@end

