//
//  IMDataManager+QIMDBPublicNumber.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "IMDataManager+QIMDBPublicNumber.h"
#import "QIMDataBase.h"
#import "QIMPublicRedefineHeader.h"

@implementation STDataMgr (QIMDBPublicNumber)

#pragma mark - 公众账号
// ******************** 公众账号 ***************************** //

- (NSDictionary *)qimDB_getPublicNumberSession {
    __block NSMutableDictionary *result = nil;
    [[self dbInstance] inDatabase:^(QIMDataBase* _Nonnull database) {
        NSString *psql = @"Select b.XmppId,A.Name,b.Content,b.Type,b.LastUpdateTime From (Select XmppId,Content,Type,LastUpdateTime From IM_Public_Number_Message Order By LastUpdateTime Desc Limit 1) as b Left Join IM_Public_Number as a On a.XmppId=b.XmppId;";
        DataReader *pReader = [database executeReader:psql withParameters:nil];
        if ([pReader read]) {
            result = [[NSMutableDictionary alloc] init];
            [STDataMgr safeSaveForDic:result setObject:[pReader objectForColumnIndex:0] forKey:@"XmppId"];
            [STDataMgr safeSaveForDic:result setObject:[pReader objectForColumnIndex:1] forKey:@"Name"];
            [STDataMgr safeSaveForDic:result setObject:[pReader objectForColumnIndex:2] forKey:@"Content"];
            [STDataMgr safeSaveForDic:result setObject:[pReader objectForColumnIndex:3] forKey:@"MsgType"];
            [STDataMgr safeSaveForDic:result setObject:[pReader objectForColumnIndex:4] forKey:@"MsgDateTime"];
            [STDataMgr safeSaveForDic:result setObject:@(ChatType_PublicNumber) forKey:@"ChatType"];
        }
    }];
    return result;
}

- (BOOL)qimDB_checkPublicNumberMsgById:(NSString *)msgId {
    __block BOOL flag = NO;
    [[self dbInstance] inDatabase:^(QIMDataBase* _Nonnull database) {
        NSString *sql = [NSString stringWithFormat:@"Select 1 From IM_Public_Number_Message Where MsgId = '%@';", msgId];
        DataReader *reader = [database executeReader:sql withParameters:nil];
        if ([reader read]) {
            flag = YES;
        }
        [reader close];
    }];
    return flag;
}

- (void)qimDB_checkPublicNumbers:(NSArray *)publicNumberIds {
    [[self dbInstance] syncUsingTransaction:^(QIMDataBase* _Nonnull database, BOOL * _Nonnull rollback) {
        CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
        if (publicNumberIds.count > 0) {
            NSString *sql = @"INSERT OR IGNORE INTO IM_Public_Number(XmppId,PublicNumberId,LastUpdateTime) VALUES(:XmppId,:PublicNumberId,:LastUpdateTime);";
            NSMutableArray *paramList = [NSMutableArray array];
            for(NSString *publicId in publicNumberIds ) {
                NSString *xmppId = [NSString stringWithFormat:@"%@@%@",publicId,[self getDBOwnerDomain]];
                
                NSMutableArray *params = [NSMutableArray array];
                [params addObject:xmppId];
                [params addObject:publicId];
                [params addObject:@(-1)];
                [paramList addObject:params];
            }
            [database executeBulkInsert:sql withParameters:paramList];
        }
        CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
        QIMVerboseLog(@"检查公众号列表%ld条数据, 耗时 = %f s", publicNumberIds.count, end - start); //s
    }];
}

- (void)qimDB_bulkInsertPublicNumbers:(NSArray *)publicNumberList {
    [[self dbInstance] syncUsingTransaction:^(QIMDataBase* _Nonnull database, BOOL * _Nonnull rollback) {
        NSString *sql = @"INSERT OR REPLACE INTO IM_Public_Number(XmppId,PublicNumberId,PublicNumberType,Name,DescInfo,HeaderSrc,SearchIndex,PublicNumberInfo,LastUpdateTime) VALUES(:XmppId,:PublicNumberId,:PublicNumberType,:Name,:DescInfo,:HeaderSrc,:SearchIndex,:PublicNumberInfo,:LastUpdateTime);";
        
        NSMutableArray *paramList = [NSMutableArray array];
        for(NSDictionary *dic in publicNumberList ) {
            long long version = [[dic objectForKey:@"rbt_ver"] intValue];
            
            NSDictionary *rbtBodyDict = [NSDictionary dictionary];
            if ([dic objectForKey:@"rbt_body"]) {
                rbtBodyDict = [dic objectForKey:@"rbt_body"];
            } else {
                rbtBodyDict = dic;
            }
            NSString *publicNumberId = [rbtBodyDict objectForKey:@"robotEnName"];
            NSString *xmppId = [NSString stringWithFormat:@"%@@%@", publicNumberId, [self getDBOwnerDomain]];
            NSString *nickName = [rbtBodyDict objectForKey:@"robotCnName"];
            NSString *headerurl = [rbtBodyDict objectForKey:@"headerurl"];
            NSString *robotDesc = [rbtBodyDict objectForKey:@"robotDesc"];
            NSData *userInfo = [NSKeyedArchiver archivedDataWithRootObject:rbtBodyDict];
            NSString *searchIndex = [rbtBodyDict objectForKey:@"searchIndex"];
            
            NSMutableArray *params = [NSMutableArray array];
            [params addObject:xmppId];
            [params addObject:publicNumberId];
            [params addObject:@(0)];
            [params addObject:nickName?nickName:@":NULL"];
            [params addObject:robotDesc?robotDesc:@":NULL"];
            [params addObject:headerurl?headerurl:@":NULL"];
            [params addObject:searchIndex?searchIndex:@":NULL"];
            [params addObject:userInfo?userInfo:@":NULL"];
            [params addObject:@(version)];
            [paramList addObject:params];
        }
        [database executeBulkInsert:sql withParameters:paramList];
    }];
}

- (void)qimDB_insertPublicNumberXmppId:(NSString *)xmppId
                    WithPublicNumberId:(NSString *)publicNumberId
                  WithPublicNumberType:(int)publicNumberType
                              WithName:(NSString *)name
                         WithHeaderSrc:(NSString *)headerSrc
                          WithDescInfo:(NSString *)descInfo
                       WithSearchIndex:(NSString *)searchIndex
                        WithPublicInfo:(NSString *)publicInfo
                           WithVersion:(int)version {
    if (xmppId == nil) {
        return;
    }
    [[self dbInstance] syncUsingTransaction:^(QIMDataBase* _Nonnull database, BOOL * _Nonnull rollback) {
        NSString *sql = @"INSERT OR REPLACE INTO IM_Public_Number(XmppId,PublicNumberId,PublicNumberType,Name,DescInfo,HeaderSrc,SearchIndex,PublicNumberInfo,LastUpdateTime) VALUES(:XmppId,:PublicNumberId,:PublicNumberType,:Name,:DescInfo,:HeaderSrc,:SearchIndex,:PublicNumberInfo,:LastUpdateTime);";
        NSMutableArray *params = [NSMutableArray array];
        [params addObject:xmppId];
        [params addObject:publicNumberId];
        [params addObject:@(publicNumberType)];
        [params addObject:name?name:@":NULL"];
        [params addObject:headerSrc?headerSrc:@":NULL"];
        [params addObject:searchIndex?searchIndex:@":NULL"];
        [params addObject:descInfo?descInfo:@":NULL"];
        [params addObject:publicInfo?publicInfo:@":NULL"];
        [params addObject:@(version)];
        [database executeNonQuery:sql withParameters:params];
    }];
}

- (void)qimDB_deletePublicNumberId:(NSString *)publicNumberId {
    [[self dbInstance] syncUsingTransaction:^(QIMDataBase* _Nonnull database, BOOL * _Nonnull rollback) {
        NSString *sql = @"Delete From IM_Public_Number Where PublicNumberId=:PublicNumberId;";
        [database executeNonQuery:sql withParameters:@[publicNumberId]];
    }];
}

- (NSArray *)qimDB_getPublicNumberVersionList {
    __block NSMutableArray *resultList = nil;
    [[self dbInstance] inDatabase:^(QIMDataBase* _Nonnull database) {
        NSString *sql = @"SELECT PublicNumberId,LastUpdateTime FROM IM_Public_Number;";
        DataReader *reader = [database executeReader:sql withParameters:nil];
        while ([reader read]) {
            
            if (resultList == nil) {
                resultList = [[NSMutableArray alloc] init];
            }
            
            NSString *xmppId = [reader objectForColumnIndex:0];
            NSNumber *lastUpdateTime = [reader objectForColumnIndex:1];
            
            NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
            [STDataMgr safeSaveForDic:value setObject:xmppId forKey:@"robot_name"];
            [STDataMgr safeSaveForDic:value setObject:lastUpdateTime forKey:@"version"];
            [resultList addObject:value];
        }
    }];
    return resultList;
}

- (NSArray *)qimDB_getPublicNumberList {
    __block NSMutableArray *resultList = nil;
    [[self dbInstance] inDatabase:^(QIMDataBase* _Nonnull database) {
        NSString *sql = @"SELECT a.XmppId,a.PublicNumberId,a.PublicNumberType,a.Name,a.DescInfo,a.HeaderSrc,a.SearchIndex,a.PublicNumberInfo,b.LastUpdateTime,b.Content,b.Type FROM IM_Public_Number as a Left Join (Select XmppId,Content,Type,LastUpdateTime From IM_Public_Number_Message Order By LastUpdateTime Desc Limit 1) as b On a.XmppId=b.XmppId Order By b.LastUpdateTime Desc;";
        DataReader *reader = [database executeReader:sql withParameters:nil];
        while ([reader read]) {
            
            if (resultList == nil) {
                resultList = [[NSMutableArray alloc] init];
            }
            
            NSString *xmppId = [reader objectForColumnIndex:0];
            NSString *publicNumberId = [reader objectForColumnIndex:1];
            NSNumber *publicNumberType = [reader objectForColumnIndex:2];
            NSString *name = [reader objectForColumnIndex:3];
            NSString *descInfo = [reader objectForColumnIndex:4];
            NSString *headerSrc = [reader objectForColumnIndex:5];
            NSString *searchIndex = [reader objectForColumnIndex:6];
            NSData   *publicData = [reader objectForColumnIndex:7];
            NSDictionary *pInfo = [NSKeyedUnarchiver unarchiveObjectWithData:publicData];
            NSNumber *lastUpdateTime = [reader objectForColumnIndex:8];
            NSString *content = [reader objectForColumnIndex:9];
            NSNumber *msgType = [reader objectForColumnIndex:10];
            
            NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
            [STDataMgr safeSaveForDic:value setObject:xmppId forKey:@"XmppId"];
            [STDataMgr safeSaveForDic:value setObject:publicNumberId forKey:@"PublicNumberId"];
            [STDataMgr safeSaveForDic:value setObject:publicNumberType forKey:@"PublicNumberType"];
            [STDataMgr safeSaveForDic:value setObject:name forKey:@"Name"];
            [STDataMgr safeSaveForDic:value setObject:descInfo forKey:@"DescInfo"];
            [STDataMgr safeSaveForDic:value setObject:headerSrc forKey:@"HeaderSrc"];
            [STDataMgr safeSaveForDic:value setObject:searchIndex forKey:@"SearchIndex"];
            [STDataMgr safeSaveForDic:value setObject:pInfo forKey:@"PublicNumberInfo"];
            [STDataMgr safeSaveForDic:value setObject:lastUpdateTime forKey:@"LastUpdateTime"];
            [STDataMgr safeSaveForDic:value setObject:content forKey:@"Content"];
            [STDataMgr safeSaveForDic:value setObject:msgType forKey:@"MsgType"];
            [resultList addObject:value];
        }
        
    }];
    return resultList;
}

- (NSArray *)qimDB_searchPublicNumberListByKeyStr:(NSString *)keyStr {
    __block NSMutableArray *resultList = nil;
    [[self dbInstance] inDatabase:^(QIMDataBase* _Nonnull database) {
        NSString *sql = [NSString stringWithFormat:@"SELECT a.XmppId,a.PublicNumberId,a.PublicNumberType,a.Name,a.DescInfo,a.HeaderSrc,a.SearchIndex,a.PublicNumberInfo,b.LastUpdateTime,b.Content,b.Type FROM IM_Public_Number as a Left Join (Select XmppId,Content,Type,LastUpdateTime From IM_Public_Number_Message Order By LastUpdateTime Desc Limit 1) as b On a.XmppId=b.XmppId Where a.PublicNumberId Like '%%%@%%' Or a.Name Like '%%%@%%' Or a.SearchIndex Like '%%%@%%' Order By b.LastUpdateTime Desc;",keyStr,keyStr,keyStr];
        DataReader *reader = [database executeReader:sql withParameters:nil];
        while ([reader read]) {
            
            if (resultList == nil) {
                resultList = [[NSMutableArray alloc] init];
            }
            
            NSString *xmppId = [reader objectForColumnIndex:0];
            NSString *publicNumberId = [reader objectForColumnIndex:1];
            NSNumber *publicNumberType = [reader objectForColumnIndex:2];
            NSString *name = [reader objectForColumnIndex:3];
            NSString *descInfo = [reader objectForColumnIndex:4];
            NSString *headerSrc = [reader objectForColumnIndex:5];
            NSString *searchIndex = [reader objectForColumnIndex:6];
            NSData   *publicData = [reader objectForColumnIndex:7];
            NSDictionary *pInfo = [NSKeyedUnarchiver unarchiveObjectWithData:publicData];
            NSNumber *lastUpdateTime = [reader objectForColumnIndex:8];
            NSString *content = [reader objectForColumnIndex:9];
            NSNumber *msgType = [reader objectForColumnIndex:10];
            
            NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
            [STDataMgr safeSaveForDic:value setObject:xmppId forKey:@"XmppId"];
            [STDataMgr safeSaveForDic:value setObject:publicNumberId forKey:@"PublicNumberId"];
            [STDataMgr safeSaveForDic:value setObject:publicNumberType forKey:@"PublicNumberType"];
            [STDataMgr safeSaveForDic:value setObject:name forKey:@"Name"];
            [STDataMgr safeSaveForDic:value setObject:descInfo forKey:@"DescInfo"];
            [STDataMgr safeSaveForDic:value setObject:headerSrc forKey:@"HeaderSrc"];
            [STDataMgr safeSaveForDic:value setObject:searchIndex forKey:@"SearchIndex"];
            [STDataMgr safeSaveForDic:value setObject:pInfo forKey:@"PublicNumberInfo"];
            [STDataMgr safeSaveForDic:value setObject:lastUpdateTime forKey:@"LastUpdateTime"];
            [STDataMgr safeSaveForDic:value setObject:content forKey:@"Content"];
            [STDataMgr safeSaveForDic:value setObject:msgType forKey:@"MsgType"];
            [resultList addObject:value];
        }
    }];
    return resultList;
}

- (NSInteger)qimDB_getRnSearchPublicNumberListByKeyStr:(NSString *)keyStr {
    __block NSInteger count = 0;
    [[self dbInstance] inDatabase:^(QIMDataBase* _Nonnull database) {
        NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) a.XmppId,a.PublicNumberId,a.PublicNumberType,a.Name,a.DescInfo,a.HeaderSrc,a.SearchIndex,a.PublicNumberInfo,b.LastUpdateTime,b.Content,b.Type FROM IM_Public_Number as a Left Join (Select XmppId,Content,Type,LastUpdateTime From IM_Public_Number_Message Order By LastUpdateTime Desc Limit 1) as b On a.XmppId=b.XmppId Where a.PublicNumberId Like '%%%@%%' Or a.Name Like '%%%@%%' Or a.SearchIndex Like '%%%@%%' Order By b.LastUpdateTime Desc;",keyStr,keyStr,keyStr];
        DataReader *reader = [database executeReader:sql withParameters:nil];
        if ([reader read]) {
            count = [[reader objectForColumnIndex:0] intValue];
        }
        [reader close];
    }];
    return count;
}

- (NSArray *)qimDB_rnSearchPublicNumberListByKeyStr:(NSString *)keyStr limit:(NSInteger)limit offset:(NSInteger)offset {
    __block NSMutableArray *resultList = nil;
    [[self dbInstance] inDatabase:^(QIMDataBase* _Nonnull database) {
        NSString *sql = [NSString stringWithFormat:@"SELECT a.XmppId,a.PublicNumberId,a.PublicNumberType,a.Name,a.DescInfo,a.HeaderSrc,a.SearchIndex,a.PublicNumberInfo,b.LastUpdateTime,b.Content,b.Type FROM IM_Public_Number as a Left Join (Select XmppId,Content,Type,LastUpdateTime From IM_Public_Number_Message Order By LastUpdateTime Desc Limit 1) as b On a.XmppId=b.XmppId Where a.PublicNumberId Like '%%%@%%' Or a.Name Like '%%%@%%' Or a.SearchIndex Like '%%%@%%' Order By b.LastUpdateTime Desc LIMIT %ld OFFSET %ld;",keyStr,keyStr,keyStr, (long)limit, (long)offset];
        DataReader *reader = [database executeReader:sql withParameters:nil];
        while ([reader read]) {
            if (resultList == nil) {
                resultList = [[NSMutableArray alloc] init];
            }
            NSString *uri = [reader objectForColumnIndex:0];
            NSString *publicNumberId = [reader objectForColumnIndex:1];
            NSString *name = [reader objectForColumnIndex:3];
            NSString *content = [reader objectForColumnIndex:4];
            NSString *icon = [reader objectForColumnIndex:5];
        
            NSString *label = [NSString stringWithFormat:@"%@(%@)", name, publicNumberId];
            NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
            [STDataMgr safeSaveForDic:value setObject:uri forKey:@"uri"];
            [STDataMgr safeSaveForDic:value setObject:label forKey:@"label"];
            [STDataMgr safeSaveForDic:value setObject:content forKey:@"content"];
            [STDataMgr safeSaveForDic:value setObject:(icon.length > 0) ? icon : @":NULL" forKey:@"icon"];
            [resultList addObject:value];
        }
    }];
    return resultList;
}

- (NSDictionary *)qimDB_getPublicNumberCardByJId:(NSString *)jid {
    __block NSMutableDictionary *resultDic = nil;
    [[self dbInstance] inDatabase:^(QIMDataBase* _Nonnull database) {
        NSString *sql = [NSString stringWithFormat:@"SELECT XmppId,PublicNumberId,PublicNumberType,Name,DescInfo,HeaderSrc,SearchIndex,PublicNumberInfo,LastUpdateTime FROM IM_Public_Number Where XmppId= '%@';", jid];
        DataReader *reader = [database executeReader:sql withParameters:nil];
        if ([reader read]) {
            NSString *xmppId = [reader objectForColumnIndex:0];
            NSString *publicNumberId = [reader objectForColumnIndex:1];
            NSNumber *publicNumberType = [reader objectForColumnIndex:2];
            NSString *name = [reader objectForColumnIndex:3];
            NSString *descInfo = [reader objectForColumnIndex:4];
            NSString *headerSrc = [reader objectForColumnIndex:5];
            NSString *searchIndex = [reader objectForColumnIndex:6];
            NSData   *publicNumberInfoData = [reader objectForColumnIndex:7];
            NSDictionary *pInfo = [NSKeyedUnarchiver unarchiveObjectWithData:publicNumberInfoData];
            NSNumber *lastUpdateTime = [reader objectForColumnIndex:8];
            
            resultDic = [[NSMutableDictionary alloc] init];
            [STDataMgr safeSaveForDic:resultDic setObject:xmppId forKey:@"XmppId"];
            [STDataMgr safeSaveForDic:resultDic setObject:publicNumberId forKey:@"PublicNumberId"];
            [STDataMgr safeSaveForDic:resultDic setObject:publicNumberType forKey:@"PublicNumberType"];
            [STDataMgr safeSaveForDic:resultDic setObject:name forKey:@"Name"];
            [STDataMgr safeSaveForDic:resultDic setObject:descInfo forKey:@"DescInfo"];
            [STDataMgr safeSaveForDic:resultDic setObject:headerSrc forKey:@"HeaderSrc"];
            [STDataMgr safeSaveForDic:resultDic setObject:searchIndex forKey:@"SearchIndex"];
            [STDataMgr safeSaveForDic:resultDic setObject:pInfo forKey:@"PublicNumberInfo"];
            [STDataMgr safeSaveForDic:resultDic setObject:lastUpdateTime forKey:@"LastUpdateTime"];
        }
        [reader close];
    }];
    return resultDic;
}

- (void)qimDB_insetPublicNumberMsgWithMsgId:(NSString *)msgId
                              WithSessionId:(NSString *)sessionId
                                   WithFrom:(NSString *)from
                                     WithTo:(NSString *)to
                                WithContent:(NSString *)content
                               WithPlatform:(int)platform
                                WithMsgType:(int)msgType
                               WithMsgState:(int)msgState
                           WithMsgDirection:(int)msgDirection
                                WithMsgDate:(long long)msgDate
                              WithReadedTag:(int)readedTag {
    [[self dbInstance] syncUsingTransaction:^(QIMDataBase* _Nonnull database, BOOL * _Nonnull rollback) {
        
        NSString *sql = @"INSERT OR IGNORE INTO IM_Public_Number_Message(MsgId,XmppId,'From','To',Content,Type,State,Direction,ReadedTag,LastUpdateTime) VALUES(:MsgId,:XmppId,:From,:To,:Content,:Type,:State,:Direction,:ReadedTag,:LastUpdateTime);";
        
        NSMutableArray *params = [[NSMutableArray alloc] init];
        [params addObject:msgId?msgId:@":NULL"];
        [params addObject:sessionId?sessionId:@":NULL"];
        [params addObject:from?from:@":NULL"];
        [params addObject:to?to:@":NULL"];
        [params addObject:content?content:@":NULL"];
        [params addObject:@(msgType)];
        [params addObject:@(msgState)];
        [params addObject:@(msgDirection)];
        [params addObject:@(readedTag)];
        [params addObject:@(msgDate)];
        [database executeNonQuery:sql withParameters:params];
    }];
}

- (NSArray *)qimDB_getMsgListByPublicNumberId:(NSString *)publicNumberId
                                    WithLimit:(int)limit
                                   WithOffset:(int)offset
                               WithFilterType:(NSArray *)actionTypes {
    __block NSMutableArray *resultList = nil;
    [[self dbInstance] inDatabase:^(QIMDataBase* _Nonnull database) {
        NSMutableString *sql = [NSMutableString stringWithString:[NSString stringWithFormat:@"SELECT MsgId,XmppId,\"From\",\"To\",Content,Type,State,Direction,ReadedTag,LastUpdateTime From IM_Public_Number_Message Where XmppId= '%@' and Type not in (", publicNumberId]];
        for (NSNumber *type in actionTypes) {
            if ([type isEqual:actionTypes.lastObject]) {
                [sql appendFormat:@"%d) ",type.intValue];
            } else {
                [sql appendFormat:@"%d,",type.intValue];
            }
        }
        [sql appendFormat:@" Order By LastUpdateTime Desc Limit %d offset %d;",limit,offset];
        DataReader *reader = [database executeReader:sql withParameters:nil];
        while ([reader read]) {
            if (resultList == nil) {
                resultList = [[NSMutableArray alloc] init];
            }
            NSString *msgId = [reader objectForColumnIndex:0];
            NSString *xmppId = [reader objectForColumnIndex:1];
            NSString *from = [reader objectForColumnIndex:2];
            NSString *to = [reader objectForColumnIndex:3];
            NSString *content = [reader objectForColumnIndex:4];
            NSNumber *type = [reader objectForColumnIndex:5];
            NSNumber *state = [reader objectForColumnIndex:6];
            NSNumber *direction = [reader objectForColumnIndex:7];
            NSNumber *readedTag = [reader objectForColumnIndex:8];
            NSNumber *lastUpdateTime = [reader objectForColumnIndex:9];
            NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
            [STDataMgr safeSaveForDic:value setObject:msgId forKey:@"MsgId"];
            [STDataMgr safeSaveForDic:value setObject:xmppId forKey:@"XmppId"];
            [STDataMgr safeSaveForDic:value setObject:from forKey:@"From"];
            [STDataMgr safeSaveForDic:value setObject:to forKey:@"To"];
            [STDataMgr safeSaveForDic:value setObject:content forKey:@"Content"];
            [STDataMgr safeSaveForDic:value setObject:type forKey:@"Type"];
            [STDataMgr safeSaveForDic:value setObject:state forKey:@"State"];
            [STDataMgr safeSaveForDic:value setObject:direction forKey:@"Direction"];
            [STDataMgr safeSaveForDic:value setObject:readedTag forKey:@"ReadedTag"];
            [STDataMgr safeSaveForDic:value setObject:lastUpdateTime forKey:@"LastUpdateTime"];
            [resultList addObject:value];
        }
    }];
    return resultList;
}

@end
