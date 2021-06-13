//
//  QIMMyFavoitesManager.h
//  qunarChatIphone
//
//  Created by Qunar-Lu on 16/6/27.
//
//

#import "QIMCommonUIFramework.h"

@interface QIMMyFavoitesManager : NSObject

+ (instancetype) sharedMyFavoritesManager;

- (void)setMyFavoritesArrayWithMsg:(STMsgModel *)message;

- (NSMutableArray *)myFavoritesArray;

@end
