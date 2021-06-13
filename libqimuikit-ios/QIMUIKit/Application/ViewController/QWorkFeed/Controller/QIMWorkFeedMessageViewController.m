//
//  QIMWorkFeedMessageViewController.m
//  QIMUIKit
//
//  Created by lilu on 2019/1/9.
//  Copyright © 2019 QIM. All rights reserved.
//

#import "QIMWorkFeedMessageViewController.h"
#import "QIMWorkMessageCell.h"
#import "QIMWorkNoticeMessageModel.h"
#import "QIMWorkMomentContentModel.h"
#import "QIMWorkFeedDetailViewController.h"
#import <YYModel/YYModel.h>
#import <MJRefresh/MJRefresh.h>

@interface QIMWorkFeedMessageViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *messageTableView;

@property (nonatomic, strong) NSMutableArray *noticeMsgs;

@end

@implementation QIMWorkFeedMessageViewController

- (UITableView *)messageTableView {
    if (!_messageTableView) {
        _messageTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        _messageTableView.estimatedRowHeight = 0;
        _messageTableView.estimatedSectionHeaderHeight = 0;
        _messageTableView.estimatedSectionFooterHeight = 0;
        _messageTableView.backgroundColor = [UIColor qim_colorWithHex:0xf5f5f5 alpha:1.0];
        _messageTableView.tableFooterView = [UIView new];
        _messageTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);           //top left bottom right 左右边距相同
        _messageTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _messageTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreNoticeMessages)];
        [_messageTableView.mj_footer setAutomaticallyHidden:YES];
    }
    return _messageTableView;
}

- (NSMutableArray *)noticeMsgs {
    if (!_noticeMsgs) {
        _noticeMsgs = [NSMutableArray arrayWithCapacity:3];
        NSArray *array = [[STKit sharedInstance] getWorkNoticeMessagesWithLimit:20 WithOffset:0 eventTypes:@[@(QIMWorkFeedNotifyTypeComment), @(QIMWorkFeedNotifyTypePOSTAt), @(QIMWorkFeedNotifyTypeCommentAt)] readState:0];
        for (NSDictionary *noticeMsgDict in array) {
            QIMWorkNoticeMessageModel *model = [self getNoticeMessageModelWithDict:noticeMsgDict];
            [_noticeMsgs addObject:model];
        }
    }
    return _noticeMsgs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的消息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage qimIconWithInfo:[QIMIconInfo iconInfoWithText:@"\U0000f3cd" size:20 color:[UIColor qim_colorWithHex:0x333333]]] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick:)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor qim_colorWithHex:0x333333]}];
    [self.view addSubview:self.messageTableView];
    QIMWorkNoticeMessageModel *noticeMsgModel = [self.noticeMsgs firstObject];
    if (noticeMsgModel) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [[STKit sharedInstance] updateLocalWorkNoticeMsgReadStateWithTime:noticeMsgModel.createTime];
            [[STKit sharedInstance] updateRemoteWorkNoticeMsgReadStateWithTime:noticeMsgModel.createTime];
            //设置驼圈消息已读
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kPBPresenceCategoryNotifyWorkNoticeMessage object:nil];
            });
        });
    } else {
        
    }
}

- (void)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadMoreNoticeMessages {
    NSArray *moreNoticeMsgs = [[STKit sharedInstance] getWorkNoticeMessagesWithLimit:20 WithOffset:0 eventTypes:@[@(QIMWorkFeedNotifyTypeComment), @(QIMWorkFeedNotifyTypePOSTAt), @(QIMWorkFeedNotifyTypeCommentAt)] readState:0];
    if (moreNoticeMsgs.count > 0) {
        for (NSDictionary *noticeMsgDict in moreNoticeMsgs) {
            QIMWorkNoticeMessageModel *model = [self getNoticeMessageModelWithDict:noticeMsgDict];
            [self.noticeMsgs addObject:model];
        }
        [self.messageTableView reloadData];
        [self.messageTableView.mj_footer endRefreshing];
    } else {
        [self.messageTableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (QIMWorkNoticeMessageModel *)getNoticeMessageModelWithDict:(NSDictionary *)modelDict {
    QIMWorkNoticeMessageModel *model = [QIMWorkNoticeMessageModel yy_modelWithDictionary:modelDict];
    NSLog(@"QIMWorkNoticeMessageModel *model : %@", model);
    return model;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.noticeMsgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QIMWorkNoticeMessageModel *model = [self.noticeMsgs objectAtIndex:indexPath.row];
    QIMWorkMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:model.uuid];
    if (!cell) {
        cell = [[QIMWorkMessageCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:model.uuid];
        [cell setNoticeMsgModel:model];
        cell.cellType = QIMWorkMomentCellTypeMyMessage;
        [cell setContentModel:[self getContentModelWithMomentUUId:model.postUUID]];
    }
    return cell;
}

- (QIMWorkMomentContentModel *)getContentModelWithMomentUUId:(NSString *)momentId {
    NSDictionary *momentDic = [[STKit sharedInstance] getWorkMomentWithMomentId:momentId];
    
    NSDictionary *contentModelDic = [[QIMJSONSerializer sharedInstance] deserializeObject:[momentDic objectForKey:@"content"] error:nil];
    QIMWorkMomentContentModel *contentModel = [QIMWorkMomentContentModel yy_modelWithDictionary:contentModelDic];
    return contentModel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QIMWorkNoticeMessageModel *model = [self.noticeMsgs objectAtIndex:indexPath.row];
    
    QIMWorkFeedDetailViewController *detailVc = [[QIMWorkFeedDetailViewController alloc] init];
    detailVc.momentId = model.postUUID;
    QIMVerboseLog(@"model.PostUUID : %@", model);
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QIMWorkNoticeMessageModel *model = [self.noticeMsgs objectAtIndex:indexPath.row];
    if (model.rowHeight < 115) {
        return 115;
    } else {
        return model.rowHeight;
    }
}

@end
