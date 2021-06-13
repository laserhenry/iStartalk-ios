//
//  QIMManager+KeyChain.h
//  qunarChatIphone
//
//  Created by 李露 on 2018/4/2.
//

#import "QIMManager.h"

@interface QIMManager (KeyChain)

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
