//
//  QIMKit+QIMGroup.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//

#import "QIMKit+QIMGroup.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMGroup)

- (void)updateLastGroupMsgTime {
    [[STManager sharedInstance] updateLastGroupMsgTime];
}

- (QIMMessageDirection)getGroupMsgDirectionWithSendJid:(NSString *)sendJid {
    return [[STManager sharedInstance] getGroupMsgDirectionWithSendJid:sendJid];
}

- (NSArray *)getGroupList {
    return [[STManager sharedInstance] getGroupList];
}

- (NSString *)getGroupBigHeaderImageUrlWithGroupId:(NSString *)groupId {
    return [[STManager sharedInstance] getGroupBigHeaderImageUrlWithGroupId:groupId];
}

- (NSArray *)getMyGroupList {
    return [[STManager sharedInstance] getMyGroupList];
}

#pragma mark - 群名片

- (NSDictionary *)getUserInfoByGroupName:(NSString *)groupName {
    return [[STManager sharedInstance] getUserInfoByGroupName:groupName];
}

- (NSDictionary *)getMemoryGroupCardByGroupId:(NSString *)groupId {
    return [[STManager sharedInstance] getMemoryGroupCardByGroupId:groupId];
}

- (NSDictionary *)getGroupCardByGroupId:(NSString *)groupId {
    return [[STManager sharedInstance] getGroupCardByGroupId:groupId];
}

- (void)updateGroupCardByGroupId:(NSString *)groupId withCache:(BOOL)cache {
    [[STManager sharedInstance] updateGroupCardByGroupId:groupId withCache:cache];
}

- (void)updateGroupCardByGroupId:(NSString *)groupId {
    [[STManager sharedInstance] updateGroupCardByGroupId:groupId];
}

- (void)updateGroupCard:(NSArray *)groupIds {
    [[STManager sharedInstance] updateGroupCard:groupIds];
}

- (void)setMucVcardForGroupId:(NSString *)groupId
                 WithNickName:(NSString *)nickName
                    WithTitle:(NSString *)title
                     WithDesc:(NSString *)desc
                WithHeaderSrc:(NSString *)headerSrc
                 withCallBack:(QIMKitSetMucVCardBlock)callback {
    [[STManager sharedInstance] setMucVcardForGroupId:groupId WithNickName:nickName WithTitle:title WithDesc:desc WithHeaderSrc:headerSrc withCallBack:callback];
}

- (BOOL)updateGroupTopic:(NSString *)topic WithGroupId:(NSString *)groupId {
    return [[STManager sharedInstance] updateGroupTopic:topic WithGroupId:groupId];
}

#pragma mark - 群成员

- (NSArray *)syncgroupMember:(NSString *)groupId {
    return [[STManager sharedInstance] syncgroupMember:groupId];
}

- (NSArray *)getGroupMembersByGroupId:(NSString *)groupId {
    return [[STManager sharedInstance] getGroupMembersByGroupId:groupId];
}

- (NSString *)getGroupTopicByGroupId:(NSString *)groupId {
    return [[STManager sharedInstance] getGroupTopicByGroupId:groupId];
}

- (BOOL)isGroupMemberByGroupId:(NSString *)groupId {
    return [[STManager sharedInstance] isGroupMemberByGroupId:groupId];
}

- (BOOL)isGroupMemberByUserId:(NSString *)userId ByGroupId:(NSString *)groupId {
    return [[STManager sharedInstance] isGroupMemberByUserId:userId ByGroupId:groupId];
}

- (BOOL)isGroupOwner:(NSString *)groupId {
    return [[STManager sharedInstance] isGroupOwner:groupId];
}

- (QIMGroupIdentity)GroupIdentityForUser:(NSString *)userId byGroup:(NSString *)groupId {
    return [[STManager sharedInstance] GroupIdentityForUser:userId byGroup:groupId];
}

#pragma mark - 群头像

+ (UIImage *)defaultGroupHeaderImage {
    return [STManager defaultGroupHeaderImage];
}

#pragma mark - 群消息设置

- (BOOL)groupPushState:(NSString *)groupId {
    return [[STManager sharedInstance] groupPushState:groupId];
}

- (void)updatePushState:(NSString *)groupId withOn:(BOOL)on withCallback:(QIMKitUpdateRemoteClientConfig)callback {
    [[STManager sharedInstance] updatePushState:groupId withOn:on withCallback:callback];
}

- (NSDictionary *) defaultGroupSetting {
    return [[STManager sharedInstance] defaultGroupSetting];
}

#pragma mark - 创建群 & 邀请人入群

- (void)createGroupByGroupName:(NSString *)groupName
                WithMyNickName:(NSString *)nickName
              WithInviteMember:(NSArray *)members
                   WithSetting:(NSDictionary *)settingDic
                      WithDesc:(NSString *)desc
             WithGroupNickName:(NSString *)groupNickName
                  WithComplate:(void (^)(BOOL,NSString *))complate {
    [[STManager sharedInstance] createGroupByGroupName:groupName WithMyNickName:nickName WithInviteMember:members WithSetting:settingDic WithDesc:desc WithGroupNickName:groupNickName WithComplate:complate];
}

-(void)joinGroupWithBuddies:(NSString *)groupID  groupName:(NSString *)groupName WithInviteMember:(NSArray *)members withCallback:(dispatch_block_t) block {
    [[STManager sharedInstance] joinGroupWithBuddies:groupID groupName:groupName WithInviteMember:members withCallback:block];
}

- (BOOL)removeGroupMemberWithName:(NSString *)name WithJid:(NSString *)memberJid ForGroupId:(NSString *)groupId {
    return [[STManager sharedInstance] removeGroupMemberWithName:name WithJid:memberJid ForGroupId:groupId];
}

- (BOOL)setGroupAdminWithGroupId:(NSString *)groupId withIsAdmin:(BOOL)isAdmin WithAdminNickName:(NSString *)nickName ForJid:(NSString *)memberJid {
    return [[STManager sharedInstance] setGroupAdminWithGroupId:groupId withIsAdmin:isAdmin WithAdminNickName:nickName ForJid:memberJid];
}

- (BOOL)inviteMember:(NSArray *)members ToGroupId:(NSString *)groupId {
    return [[STManager sharedInstance] inviteMember:members ToGroupId:groupId];
}

- (BOOL)joinGroupId:(NSString *)groupId ByName:(NSString *)name isInitiative:(BOOL)initiative {
    return [[STManager sharedInstance] joinGroupId:groupId ByName:name isInitiative:initiative];
}

- (BOOL)joinGroupId:(NSString *)groupId ByName:(NSString *)name WithPassword:(NSString *)password {
    return [[STManager sharedInstance] joinGroupId:groupId ByName:name WithPassword:password];
}

- (BOOL)quitGroupId:(NSString *)groupId {
    return [[STManager sharedInstance] quitGroupId:groupId];
}

- (BOOL)destructionGroup:(NSString *)groupId {
    return [[STManager sharedInstance] destructionGroup:groupId];
}

- (void)updateChatRoomList {
    [[STManager sharedInstance] updateChatRoomList];
}

- (void)quickJoinAllGroup {
    [[STManager sharedInstance] quickJoinAllGroup];
}

- (void)joinGroupList {
    [[STManager sharedInstance] joinGroupList];
}

- (void)getIncrementMucList:(NSTimeInterval)lastTime {
    [[STManager sharedInstance] getIncrementMucList:lastTime];
}


#pragma mark - SearchGroup

- (NSInteger)searchGroupTotalCountBySearchStr:(NSString *)searchStr {
    return [[STManager sharedInstance] searchGroupTotalCountBySearchStr:searchStr];
}

- (NSArray *)searchGroupBySearchStr:(NSString *)searchStr WithLimit:(NSInteger)limit WithOffset:(NSInteger)offset {
    return [[STManager sharedInstance] searchGroupBySearchStr:searchStr WithLimit:limit WithOffset:offset];
}

- (NSArray *)searchGroupUserBySearchStr:(NSString *) searchStr inGroup:(NSString *) groupId {
    return [[STManager sharedInstance] searchGroupUserBySearchStr:searchStr inGroup:groupId];
}

- (NSArray *)searchUserBySearchStr:(NSString *)searchStr notInGroup:(NSString *)groupId {
    return [[STManager sharedInstance] searchUserBySearchStr:searchStr notInGroup:groupId];
}

@end
