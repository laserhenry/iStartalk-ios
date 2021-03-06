//
//  QIMLocalLog.m
//  qunarChatIphone
//
//  Created by Qunar-Lu on 2017/3/10.
//
//

#import "STLocalLog.h"
#import "QIMZipArchive.h"
#import "NSString+QIMUtility.h"
#import "NSDateFormatter+QIMCategory.h"
#import "QIMKitPublicHeader.h"
#import "QIMJSONSerializer.h"
#import "QIMUUIDTools.h"
#import "QIMNetwork.h"
#import "STLogFormatter.h"
#import "CocoaLumberjack.h"
#import "QIMPublicRedefineHeader.h"

static NSString *LocalLogsPath = @"Logs";
static NSString *LocalZipLogsPath = @"ZipLogs";

@interface STLocalLog ()

@end

@implementation STLocalLog

+ (void)load {
    [STLocalLog sharedInstance];
}

+ (instancetype)sharedInstance {
    static STLocalLog *__localLog = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __localLog = [[STLocalLog alloc] init];
    });
    return __localLog;
}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self startLog];
    }
    return self;
}

- (void)startLog {

    UIDevice *device = [UIDevice currentDevice];
    NSString *lastUserName = [STKit getLastUserName];
    [[STKit sharedInstance] setCacheName:[[STKit sharedInstance] getLastJid]];
    QIMLocalLogType logType = [[[STKit sharedInstance] userObjectForKey:@"recordLogType"] integerValue];
    logType = QIMLocalLogTypeOpened;
    [[STKit sharedInstance] setUserObject:@(QIMLocalLogTypeOpened) forKey:@"recordLogType"];
    if ([lastUserName containsString:@"dan.liu"] || [lastUserName containsString:@"weiping.he"] || [lastUserName containsString:@"geng.li"] || [lastUserName containsString:@"lilulucas.li"] || [lastUserName containsString:@"ping.xue"] || [lastUserName containsString:@"wenhui.fan"] || [lastUserName containsString:@"ping.yang"]) {

        [self initDDLog];

        QIMLocalLogType logType = [[[STKit sharedInstance] userObjectForKey:@"recordLogType"] integerValue];
        if (logType == QIMLocalLogTypeDefault) {
            [[STKit sharedInstance] setUserObject:@(QIMLocalLogTypeOpened) forKey:@"recordLogType"];
        }
    }
    QIMLocalLogType newlogType = [[[STKit sharedInstance] userObjectForKey:@"recordLogType"] integerValue];
    if (newlogType == QIMLocalLogTypeOpened) {
        [self deleteLocalLog];
        [self initDDLog];
    }
    [self initDDLog];
}

- (void)initDDLog {
    NSString *logPath = [self getLocalLogsPath];
    DDLogFileManagerDefault *logFileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:logPath];
    STLogFormatter *logFormatter = [[STLogFormatter alloc] init];
    [DDASLLogger sharedInstance].logFormatter = logFormatter;
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:logFileManager];
    fileLogger.logFormatter = logFormatter;
    fileLogger.rollingFrequency = (24 * 60 * 60) * 2;   //2???
    fileLogger.maximumFileSize = 1024 * 1024 * 1; //??????log????????????2M
    fileLogger.logFileManager.maximumNumberOfLogFiles = 30; //????????????100?????????
    fileLogger.logFileManager.logFilesDiskQuota = 30 * 1024 * 1024; //15M
    [DDLog addLogger:fileLogger withLevel:DDLogLevelAll];
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
}

- (void)stopLog {
    QIMVerboseLog(@"????????????????????????");
    fclose(stdout);
    fclose(stderr);
}

- (NSString *)getLogFilePath {
    NSString *logDirectory = [self getLocalLogsPath];

    NSArray *logArray = [self allLogFilesAtPath:logDirectory];
    NSString *logFilePath = nil;
    if (logArray.count > 0) {
        NSString *lastLogFilePath = [logArray lastObject];
        NSDictionary *logFileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:lastLogFilePath error:nil];
        if (logFileAttributes != nil) {
            NSDate *fileModDate = [logFileAttributes objectForKey:NSFileModificationDate]; //????????????
            NSNumber *theFileSize = [logFileAttributes objectForKey:NSFileSize]; //???????????????
            CGFloat overSizeFileFlag = theFileSize.longLongValue / 1024 / 1024;
            NSTimeInterval timeIntervalSinceNow = [fileModDate timeIntervalSinceNow];
            //??????????????????log??????????????????????????????Size>5M?????????????????????????????????
            if (fabs(fabs(timeIntervalSinceNow) / (3600 * 2)) >= 1 || overSizeFileFlag >= 5) {
                logFilePath = [self createNewLogFileWithDirectory:logDirectory];
            } else {
                logFilePath = lastLogFilePath;
            }
        }
    } else {
        logFilePath = [self createNewLogFileWithDirectory:logDirectory];
    }
    if (logFilePath.length <= 0 || !logFilePath) {
        logFilePath = [self createNewLogFileWithDirectory:logDirectory];
    }
    return logFilePath;
}

- (void)redirectNSLogToDocumentFolder {

    NSString *logFilePath = [self getLogFilePath];
    // ???log???????????????
    QIMVerboseLog(@"?????????????????? : %@", logFilePath);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

- (NSArray *)allLogFilesAtPath:(NSString *)dirPath {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *tempArray = [fileMgr contentsOfDirectoryAtPath:dirPath error:nil];
    for (NSString *fileName in tempArray) {
        BOOL flag = YES;
        NSString *fullPath = [dirPath stringByAppendingPathComponent:fileName];
        if ([fileMgr fileExistsAtPath:fullPath isDirectory:&flag]) {
            if (!flag) {
                [array addObject:fullPath];
            }
        }
    }
    return array;
}

- (NSArray *)allLogFileAttributes {
    NSString *dirPath = [self getLocalLogsPath];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *tempArray = [fileMgr contentsOfDirectoryAtPath:dirPath error:nil];
    for (NSString *fileName in tempArray) {
        BOOL flag = YES;
        NSString *fullPath = [dirPath stringByAppendingPathComponent:fileName];
        if ([fileMgr fileExistsAtPath:fullPath isDirectory:&flag]) {
            if (!flag) {
                NSDictionary *logFileAttributeDict = [[NSFileManager defaultManager] attributesOfItemAtPath:fullPath error:nil];
                [array addObject:@{@"LogFilePath": fullPath, @"logFileAttribute": logFileAttributeDict}];
            }
        }
    }
    return array;
}

- (NSString *)createNewLogFileWithDirectory:(NSString *)logDirectory {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [NSDateFormatter qim_defaultDateFormatter];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSString *newFileName = [dateStr stringByAppendingString:@".log"];
    NSString *newLogFilePath = [logDirectory stringByAppendingPathComponent:newFileName];
    if (newLogFilePath.length) {
        return newLogFilePath;
    }
    return nil;
}

- (void)deleteLocalLog {
    NSString *logDirectory = [self getLocalLogsPath];
    NSArray *logArray = [self allLogFilesAtPath:logDirectory];
    for (NSString *logFilePath in logArray) {
        NSDictionary *logFileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:logFilePath error:nil];
        NSDate *fileModDate = [logFileAttributes objectForKey:NSFileModificationDate]; //????????????
        NSTimeInterval timeIntervalSinceNow = [fileModDate timeIntervalSinceNow];
        if (fabs(fabs(timeIntervalSinceNow) / (3600 * 24 * 1.5)) >= 1) { //????????????????????????????????????
            NSError *error = nil;
            BOOL removeSuccess = [[NSFileManager defaultManager] removeItemAtPath:logFilePath error:&error];
            if (removeSuccess) {
                QIMVerboseLog(@"???????????????<%@>??????", logFilePath);
            } else {
                QIMVerboseLog(@"<?????????????????????, ???????????? : %@>", error);
            }
        }
    }
}

- (NSString *)getLocalLogsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:LocalLogsPath];
    BOOL isDir;
    if (![[NSFileManager defaultManager] fileExistsAtPath:logDirectory isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:logDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return logDirectory;
}

- (NSString *)getLocalZipLogsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:LocalZipLogsPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:logDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:logDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return logDirectory;
}

//?????????????????????????????????
- (NSData *)allLogData {

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifySubmitLog object:@{@"promotMessage":@"??????????????????????????????????????????????????????"}];
    });
    NSMutableArray *logArray = [NSMutableArray arrayWithCapacity:5];

    NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];

    //UserDefault??????
    NSString *userDefaultPath = [libraryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@.plist", @"Preferences", [[NSBundle mainBundle] bundleIdentifier]]];
    [logArray addObject:userDefaultPath];

    [[STKit sharedInstance] qimDB_dbCheckpoint];

    //App
    NSString *appPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"/APP/"]];
    [logArray addObject:appPath];

    //??????Path
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@/", [[STKit sharedInstance] getLastJid]]];
    [logArray addObject:cachePath];


    //???????????????
    NSString *dbPath = [[STKit sharedInstance] getDBPathWithUserXmppId:[[STKit sharedInstance] getLastJid]];
    [logArray addObject:dbPath];

    //???????????????shm??????
    NSString *dbSHMPath = [NSString stringWithFormat:@"%@%@", dbPath, @"-shm"];
    [logArray addObject:dbSHMPath];

    //???????????????wal??????
    NSString *dbWALPath = [NSString stringWithFormat:@"%@%@", dbPath, @"-wal"];
    [logArray addObject:dbWALPath];

    //?????????Version??????
    NSString *dbVersionPath = [[dbPath stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"DBVersion"];
    [logArray addObject:dbVersionPath];
    
    //????????????
    NSArray *allLocalLogs = [self allLogFilesAtPath:[self getLocalLogsPath]];
    for (NSString *logPath in allLocalLogs) {
        [logArray addObject:logPath];
    }
    NSString *zipFileName = [NSString stringWithFormat:@"%@-log.zip", [[STKit sharedInstance] getLastJid]];

    NSString *zipFilePath = [[QIMZipArchive sharedInstance] zipFiles:logArray ToFile:[[STLocalLog sharedInstance] getLocalZipLogsPath] ToZipFileName:zipFileName WithZipPassword:@"lilulucas.li"];
    NSData *logData = [NSData dataWithContentsOfFile:zipFilePath];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifySubmitLog object:@{@"promotMessage":@"???????????????????????????????????????, ??????????????????????????????"}];
    });
    return logData;
}

- (void)submitFeedBackWithContent:(NSString *)content WithLogSelected:(BOOL)selected {
    QIMVerboseLog(@"????????????");
    if (selected) {
        [self submitFeedBackWithContent:content withUserInitiative:YES];
    } else {
        [self sendFeedBackWithLogFileUrl:nil WithContent:content withUserInitiative:YES];
    }
}

//????????????
- (void)submitFeedBackWithContent:(NSString *)content withUserInitiative:(BOOL)initiative {
    QIMVerboseLog(@"????????????");
    [[STKit sharedInstance] qim_uploadFileWithFileData:[[STLocalLog sharedInstance] allLogData] WithPathExtension:@"zip" WithCallback:^(NSString *logFileUrl) {
        if (logFileUrl.length) {
            if (![logFileUrl qim_hasPrefixHttpHeader]) {
                logFileUrl = [NSString stringWithFormat:@"%@/%@", [[STKit sharedInstance] qimNav_InnerFileHttpHost], logFileUrl];
            }
            [self sendFeedBackWithLogFileUrl:logFileUrl WithContent:content withUserInitiative:initiative];
        }
    }];
}

- (void)sendFeedBackWithLogFileUrl:(NSString *)logFileUrl WithContent:(NSString *)content withUserInitiative:(BOOL)initiative {
    NSString *title = [NSString stringWithFormat:@"???IOS????????????%@???????????????", [[STKit sharedInstance] getLastJid]];
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    [requestDic setObject:@"app@startalk.im" forKey:@"from"];
    [requestDic setObject:@"QChat Team" forKey:@"from_name"];
    [requestDic setObject:@[@"app@startalk.im", @"hejingyu@startalk.im"] forKey:@"tos"];
    [requestDic setObject:title forKey:@"subject"];
    NSString *systemVersion = [[STKit sharedInstance] SystemVersion];
    NSString *appVersion = [[STKit sharedInstance] AppBuildVersion];
    NSMutableDictionary *oldNavConfigUrlDict = [[STKit sharedInstance] userObjectForKey:@"QC_CurrentNavDict"];
    QIMVerboseLog(@"???????????????oldNavConfigUrlDict : %@", oldNavConfigUrlDict);
    NSString *platName = @"Startalk";
    if ([STKit getQIMProjectType] == QIMProjectTypeQChat) {
        platName = @"QChat";
    } else if ([STKit getQIMProjectType] == QIMProjectTypeQTalk) {
        platName = @"QTalk";
    } else {
        platName = @"Startalk";
    }
    
    NSString *eventName = [NSString stringWithFormat:@"???????????????%@\n?????????%@\n??????ID???%@\n????????????: %@\n???????????? : %@\n???????????????%@\n?????????????????????%@\nApp??????:%@", content, platName, [[STKit sharedInstance] getLastJid], [oldNavConfigUrlDict objectForKey:QIMNavUrlKey], logFileUrl, [[[STKit sharedInstance] deviceName] stringByReplacingOccurrencesOfString:@" " withString:@""], systemVersion, appVersion];
    
    [requestDic setObject:eventName forKey:@"body"];
    [requestDic setObject:[platName lowercaseString] forKey:@"plat"];
    [requestDic setObject:@"????????????" forKey:@"alt_body"];
    [requestDic setObject:@"true" forKey:@"is_html"];
    NSData *requestData = [[QIMJSONSerializer sharedInstance] serializeObject:requestDic error:nil];
    NSURL *requestUrl = [NSURL URLWithString:@"https://uk.startalk.im/emailtest"];

    NSMutableDictionary *requestHeader = [NSMutableDictionary dictionaryWithCapacity:1];
    [requestHeader setObject:@"application/json;" forKey:@"Content-type"];

    STHTTPRequest *request = [[STHTTPRequest alloc] initWithURL:requestUrl];
    [request setHTTPMethod:QIMHTTPMethodPOST];
    [request setHTTPBody:requestData];
    [request setTimeoutInterval:10];
    request.HTTPRequestHeaders = requestHeader;
    [STHTTPClient sendRequest:request complete:^(QIMHTTPResponse *response) {
        if (response.code == 200) {
            QIMVerboseLog(@"??????????????????");
            if (initiative == YES) {
                [[STLocalLog sharedInstance] deleteLocalLog];
                NSDictionary *responseDic = [[QIMJSONSerializer sharedInstance] deserializeObject:response.data error:nil];
                BOOL ret = [[responseDic objectForKey:@"ret"] boolValue];
                NSInteger errcode = [[responseDic objectForKey:@"errcode"] integerValue];
                if (ret && errcode == 0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifySubmitLog object:@{@"promotMessage":@"??????????????????????????????"}];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifySubmitLog object:@{@"promotMessage":@"?????????????????????????????????"}];
                    });
                }
            }
        }
    }                  failure:^(NSError *error) {
        QIMVerboseLog(@"?????????????????? : %@", error);
        if (initiative == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotifySubmitLog object:@{@"promotMessage":@"?????????????????????????????????"}];
            });
        }
    }];
}

@end
