//
//  STShareExtensionHelper.h
//  Pods
//
//  Created by busylei on 2022/12/23.
//

#ifndef STShareExtensionHelper_h
#define STShareExtensionHelper_h

@interface STShareExtensionHelper : NSObject

+ (STShareExtensionHelper *)sharedInstance;

- (NSArray *) shareItems;

@end

#endif /* STShareExtensionHelper_h */
