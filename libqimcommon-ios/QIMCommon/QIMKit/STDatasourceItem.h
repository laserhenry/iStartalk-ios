//
//  QIMDatasourceItem.h
//  qunarChatIphone
//
//  Created by wangshihai on 14/12/30.
//  Copyright (c) 2014年 ping.xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STDatasourceItem : NSObject

@property(nonatomic, assign) BOOL isParentNode;

@property(nonatomic, copy) NSString * nodeName;

@property(nonatomic, copy) NSString * jid;

@property(nonatomic, strong) STDatasourceItem * parentNode;

@property(nonatomic, strong) NSMutableDictionary * childNodesDict;

@property(nonatomic, assign) BOOL isExpand;

@property(nonatomic, assign) NSInteger  nLevel;

@property (nonatomic, assign) NSInteger index;

-(void)addChildNodesItem:(STDatasourceItem *)childNodes withChildDP:(NSString *)dp;

-(NSMutableArray *)expand;

@end
