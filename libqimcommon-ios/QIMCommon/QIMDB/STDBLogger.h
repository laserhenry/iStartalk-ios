//
//  QIMDBLogger.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "DDAbstractDatabaseLogger.h"

@class DatabaseOperator;

@interface STDBLogger : DDAbstractDatabaseLogger <DDLogger>
{
    @private
    NSString *logDirectory;
    NSMutableArray *pendingLogEntries;
    DatabaseOperator *dbOperator;
}

- (id)initWithLogDirectory:(NSString *)logDirectory WithDBOperator:(DatabaseOperator *)dbOperator;

@end
