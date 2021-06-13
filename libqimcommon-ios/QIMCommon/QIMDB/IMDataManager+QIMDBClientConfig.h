//
//  IMDataManager+QIMDBClientConfig.h
//  QIMCommon
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STDataMgr.h"
#import "IMDataManager+QIMSession.h"
#import "IMDataManager+QIMCalendar.h"
#import "IMDataManager+WorkFeed.h"
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

@interface STDataMgr (QIMDBClientConfig)

- (void)qimDB_clearClientConfig;

- (NSInteger)qimDB_getConfigVersion;

- (void)qimDB_deleteConfigWithConfigKey:(NSString *)configKey;

- (NSInteger)qimDB_getConfigDeleteFlagWithConfigKey:(NSString *)configKey WithSubKey:(NSString *)subKey;

- (NSString *)qimDB_getConfigInfoWithConfigKey:(NSString *)configKey WithSubKey:(NSString *)subKey WithDeleteFlag:(BOOL)deleteFlag;

- (NSArray *)qimDB_getConfigDicWithConfigKey:(NSString *)configKey WithDeleteFlag:(BOOL)deleteFlag;

- (NSArray *)qimDB_getConfigInfoArrayWithConfigKey:(NSString *)configKey WithDeleteFlag:(BOOL)deleteFlag;

- (NSArray *)qimDB_getConfigValueArrayWithConfigKey:(NSString *)configKey WithDeleteFlag:(BOOL)deleteFlag;

- (void)qimDB_bulkInsertConfigArrayWithConfigKey:(NSString *)configKey WithConfigVersion:(NSInteger)configVersion ConfigArray:(NSArray *)configArray;

- (NSMutableArray *)qimDB_getConfigArrayStarOrBlackContacts:(NSString *)pkey;

- (NSMutableArray *)qimDB_getConfigArrayFriendsNotInStarContacts;

- (NSMutableArray *)qimDB_getConfigArrayUserNotInStartContacts:(NSString *)key;

@end
