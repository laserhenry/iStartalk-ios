//
//  IMDataManager+QIMCalendar.h
//  QIMCommon
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STDataMgr.h"
#import "IMDataManager+QIMSession.h"
#import "IMDataManager+WorkFeed.h"
#import "IMDataManager+QIMDBClientConfig.h"
#import "IMDataManager+QIMDBQuickReply.h"
#import "IMDataManager+QIMNote.h"
#import "IMDataManager+QIMDBGroup.h"
#import "IMDataManager+QIMDBFriend.h"
#import "IMDataManager+QIMDBMessage.h"
#import "IMDataManager+QIMDBCollectionMessage.h"
#import "IMDataManager+QIMDBPublicNumber.h"
#import "IMDataManager+QIMDBUser.h"
#import "IMDataManager+QIMUserMedal.h"
#import "IMDataManager+QIMFoundList.h"

@interface STDataMgr (QIMCalendar)

- (NSArray *)qimDB_SelectTripByYearMonth:(NSString *)date;

- (void)qimDB_bulkInsertTrips:(NSArray *)trips;

- (NSArray *)qimDB_getLocalArea;

- (void)qimDB_bulkInsertArea:(NSArray *)areaList;

@end
