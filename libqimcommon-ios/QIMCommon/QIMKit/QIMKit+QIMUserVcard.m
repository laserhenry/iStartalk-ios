//
//  QIMKit+QIMUserVcard.m
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMUserVcard.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMUserVcard)

- (void)updateUserMarkupNameWithUserId:(NSString *)userId WithMarkupName:(NSString *)markUpName {
    [[STManager sharedInstance] updateUserMarkupNameWithUserId:userId WithMarkupName:markUpName];
}

- (NSString *)getUserMarkupNameWithUserId:(NSString *)userId {
    return [[STManager sharedInstance] getUserMarkupNameWithUserId:userId];
}

- (void)updateUserCard:(NSString *)xmppId withCache:(BOOL)cache {
    [[STManager sharedInstance] updateUserCard:xmppId withCache:cache];
}

- (void)updateUserCard:(NSArray *)xmppIds {
    [[STManager sharedInstance] updateUserCard:xmppIds];
}

- (NSString *)getUserBigHeaderImageUrlWithUserId:(NSString *)userId {
    return [[STManager sharedInstance] getUserBigHeaderImageUrlWithUserId:userId];
}

- (void)updateMyCard {
    [[STManager sharedInstance] updateMyCard];
}

- (void)updateQChatGroupMembersCardForGroupId:(NSString *)groupId {
    [[STManager sharedInstance] updateQChatGroupMembersCardForGroupId:groupId];
}

- (void)updateMyPhoto:(NSData *)photoData {
    [[STManager sharedInstance] updateMyPhoto:photoData];
}

- (NSDictionary *)getUserInfoByUserId:(NSString *)myId {
    return [[STManager sharedInstance] getUserInfoByUserId:myId];
}

- (NSDictionary *)getUserWorkInfoByUserId:(NSString *)userId {
    return [[STManager sharedInstance] getUserWorkInfoByUserId:userId];
}

- (void)getRemoteUserWorkInfoWithUserId:(NSString *)userId withCallBack:(QIMKitGetUserWorkInfoBlock)callback {

    [[STManager sharedInstance] getRemoteUserWorkInfoWithUserId:userId withCallBack:callback];
}

- (void)getPhoneNumberWithUserId:(NSString *)qtalkId withCallBack:(QIMKitGetPhoneNumberBlock)callback{
    [[STManager sharedInstance] getPhoneNumberWithUserId:qtalkId withCallBack:callback];
}

#pragma mark - 用户头像

+ (NSData *)defaultUserHeaderImage {
    return [STManager defaultUserHeaderImage];
}

+ (NSString *)defaultUserHeaderImagePath {
    return [STManager defaultUserHeaderImagePath];
}

+ (UIImage *)defaultCommonTrdInfoImage {
    return [STManager defaultCommonTrdInfoImage];
}

+ (NSString *)defaultCommonTrdInfoImagePath {
    return [STManager defaultCommonTrdInfoImagePath];
}

- (void)updateUserSignature:(NSString *)signature withCallBack:(QIMKitUpdateSignatureBlock)callback {
    
    [[STManager sharedInstance] updateUserSignature:signature withCallBack:callback];
}

#pragma mark - 跨域

- (void)searchQunarUserBySearchStr:(NSString *)searchStr withCallback:(QIMKitSearchQunarUserBlock)callback {
    [[STManager sharedInstance] searchQunarUserBySearchStr:searchStr withCallback:callback];
}

- (NSArray *)searchUserListBySearchStr:(NSString *)searchStr {
    return [[STManager sharedInstance] searchUserListBySearchStr:searchStr];
}

- (NSInteger)searchUserListTotalCountBySearchStr:(NSString *)searchStr {
    return [[STManager sharedInstance] searchUserListBySearchStr:searchStr];
}

- (NSArray *)searchUserListBySearchStr:(NSString *)searchStr WithLimit:(NSInteger)limit WithOffset:(NSInteger)offset {
    return [[STManager sharedInstance] searchUserListBySearchStr:searchStr WithLimit:limit WithOffset:offset];
}

//好友页面搜索
- (void)searchUserListBySearchStr:(NSString *)searchStr Url:(NSString *)searchURL id:(NSString *)Id limit:(NSInteger)limitNum offset:(NSInteger)offset withCallBack:(QIMKitSearchUserListCallBack)callback {
    [[STManager sharedInstance] searchUserListBySearchStr:searchStr Url:searchURL id:Id limit:limitNum offset:offset withCallBack:callback];
//    return [[QIMManager sharedInstance] searchUserListBySearchStr:searchStr Url:searchURL id:Id limit:limitNum offset:offset];
}

@end
