//
//  QIMKit+QIMKeyChain.h
//  qunarChatIphone
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMKeyChain)

/**
 SessionList数据写入KeyChain
 */
+ (void)updateSessionListToKeyChain;

/**
 GroupList数据写入KeyChain
 */
+ (void)updateGroupListToKeyChain;

/**
 FriendList数据写入KeyChain
 */
+ (void)updateFriendListToKeyChain;

/**
 RequestFileURL数据写入KeyChain
 */
+ (void)updateRequestFileURL;

/**
 RequestURL数据写入KeyChain
 */
+ (void)updateRequestURL;


/**
 NewHttpUrl数据写入KeyChain
 */
+ (void)updateNewHttpRequestURL;

/**
 Domain数据写入KeyChain
 */
+ (void)updateRequestDomain;

@end
