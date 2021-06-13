//
//  IMDataManager+QIMFoundList.h
//  QIMCommon
//
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
#import "QIMPublicRedefineHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface STDataMgr (QIMFoundList)

- (void)qimDB_insertFoundListWithAppVersion:(NSString *)version withFoundList:(NSString *)foundListStr;

- (NSString *)qimDB_getFoundListWithAppVersion:(NSString *)version;

@end

NS_ASSUME_NONNULL_END
