//
//  STShareExtensionHelper.m
//  QIMCommon
//
//  Created by busylei on 2022/12/23.
//

#import "STShareExtensionHelper.h"
#import <Foundation/Foundation.h>

#define USER_DEFAULTS_SUITE_NAME =

@implementation STShareExtensionHelper

static NSString * GROUP_IDENTIFIER = @"group.com.im.startalk";
static NSString * DEFAULTS_KEY = @"ShareItems";

static STShareExtensionHelper * _sharedInstance;

NSUserDefaults * defaults;

+ (STShareExtensionHelper *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [STShareExtensionHelper new];
    });
    return  _sharedInstance;
}

- (instancetype)init{
    defaults = [[NSUserDefaults alloc] initWithSuiteName: GROUP_IDENTIFIER];
    return self;
}

- (NSArray *) shareItems{
    return [defaults arrayForKey: DEFAULTS_KEY];
}


@end
