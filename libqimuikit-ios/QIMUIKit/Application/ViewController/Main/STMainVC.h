//
//  STMainVC.h
//  qunarChatIphone
//
//  Created by 平 薛 on 15/4/15.
//  Copyright (c) 2015年 ping.xue. All rights reserved.
//  Copyright © 2021 Startalk Ltd.

#import "QIMCommonUIFramework.h"

@interface STMainVC : UIViewController

@property (nonatomic, strong) UIView *rootView;

@property (nonatomic, strong) UISearchDisplayController *mySearchDisplayController;

@property(nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, assign) BOOL skipLogin;

- (void)selectTabAtIndex : (NSInteger)index;

- (void)setLoadingViewWithHidden:(BOOL)hidden;

+ (void)setMainVCReShow:(BOOL)showMainVc;

+ (BOOL)getMainVCReShow;

+ (BOOL)checkMainVC;

+ (instancetype)sharedInstanceWithSkipLogin:(BOOL)skipLogin;

@end
