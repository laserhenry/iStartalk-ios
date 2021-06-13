
//
//  IMDataManager+QIMFoundList.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//

#import "IMDataManager+QIMFoundList.h"
#import "QIMDataBase.h"

@implementation STDataMgr (QIMFoundList)

- (void)qimDB_insertFoundListWithAppVersion:(NSString *)version withFoundList:(NSString *)foundListStr {
    [[self dbInstance] syncUsingTransaction:^(QIMDataBase* _Nonnull database, BOOL * _Nonnull rollback) {
        NSString *sql = @"insert or replace into IM_Found_List(version, foundList) Values(:version, :foundList)";
        NSMutableArray *parames = [[NSMutableArray alloc] init];
        [parames addObject:version];
        [parames addObject:foundListStr?foundListStr:@":NULL"];
        [database executeNonQuery:sql withParameters:parames];
        parames = nil;
    }];
}

- (NSString *)qimDB_getFoundListWithAppVersion:(NSString *)version {
    __block NSString *result = nil;
    [[self dbInstance] inDatabase:^(QIMDataBase* _Nonnull database) {
        NSString *sql = [NSString stringWithFormat:@"SELECT foundList FROM IM_Found_List WHERE version = %@", version];
        DataReader *reader = [database executeReader:sql withParameters:nil];
        if ([reader read]) {
            result = [reader objectForColumnIndex:0];
        }
        [reader close];
    }];
    return result;
}

@end
