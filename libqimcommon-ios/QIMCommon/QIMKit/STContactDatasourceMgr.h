//
//  QIMContactDatasourceManager.h
//  qunarChatIphone
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface STContactDatasourceMgr : NSObject {
    NSMutableArray * _mergeRootBranch;
    
    NSMutableDictionary * _unmergeBranchDict;
}

+(STContactDatasourceMgr *)getInstance;

-(void)expandBranchAtIndex:(NSInteger)index;

-(void)collapseBranchAtIndex:(NSInteger)index;

-(void)createUnMeregeDataSource;

-(NSArray *)QtalkDataSourceItem;

@end
