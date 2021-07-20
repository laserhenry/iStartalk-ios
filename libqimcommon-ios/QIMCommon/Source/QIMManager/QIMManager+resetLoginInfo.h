//
//  QIMManager+resetLoginInfo.h
//  qunarChatIphone
//
//  Created by 李露 on 2018/4/1.
//

#import "STManager.h"

@interface STManager (resetLoginInfo)

- (void) resetIP:(NSString *) ip port:(int) port domain:(NSString *) domain httpServer:(NSString *) http fileServer:(NSString *) fileServer;

@end
