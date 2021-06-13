//
//  IMDataManager+QIMDBQuickReply.h
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
#import "IMDataManager+QIMNote.h"
#import "IMDataManager+QIMDBGroup.h"
#import "IMDataManager+QIMDBFriend.h"
#import "IMDataManager+QIMDBMessage.h"
#import "IMDataManager+QIMDBCollectionMessage.h"
#import "IMDataManager+QIMDBPublicNumber.h"
#import "IMDataManager+QIMDBUser.h"
#import "IMDataManager+QIMUserMedal.h"
#import "IMDataManager+QIMFoundList.h"

@interface STDataMgr (QIMDBQuickReply)

#pragma mark - Group

- (long)qimDB_getQuickReplyGroupVersion;

- (void)qimDB_clearQuickReplyGroup;

- (void)qimDB_bulkInsertQuickReply:(NSArray *)groupItems;

- (void)qimDB_deleteQuickReplyGroup:(NSArray *)groupItems;

- (NSInteger)qimDB_getQuickReplyGroupCount;

- (NSArray *)qimDB_getQuickReplyGroup;

#pragma mark - Content

- (long)qimDB_getQuickReplyContentVersion;

- (void)qimDB_clearQuickReplyContents;

- (void)qimDB_bulkInsertQuickReplyContents:(NSArray *)contentItems;

- (void)qimDB_deleteQuickReplyContents:(NSArray *)items;

- (NSArray *)qimDB_getQuickReplyContentWithGroupId:(long)groupId;

@end
