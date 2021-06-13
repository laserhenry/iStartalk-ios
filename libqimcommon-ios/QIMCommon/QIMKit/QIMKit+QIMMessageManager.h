//
//  QIMKit+QIMMessageManager.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMMessageManager)

- (NSArray *)getSupportMsgTypeList;

// 会话Cell上显示的文字
- (void)setMsgShowText:(NSString *)showText ForMessageType:(QIMMessageType)messageType;
- (NSString *)getMsgShowTextForMessageType:(QIMMessageType)messageType;

// 消息气泡
- (void)registerMsgCellClass:(Class)cellClass ForMessageType:(QIMMessageType)messageType;
- (void)registerMsgCellClassName:(NSString *)cellClassName ForMessageType:(QIMMessageType)messageType;
- (Class)getRegisterMsgCellClassForMessageType:(QIMMessageType)messageType;
- (id)getRegisterMsgCellForMessageType:(QIMMessageType)messageType;

// 消息定制窗口
- (void)registerMsgVCClass:(Class)cellClass ForMessageType:(QIMMessageType)messageType;
- (void)registerMsgVCClassName:(NSString *)cellClassName ForMessageType:(QIMMessageType)messageType;
- (Class)getRegisterMsgVCClassForMessageType:(QIMMessageType)messageType;
- (id)getRegisterMsgVCForMessageType:(QIMMessageType)messageType;
- (void)addMsgTextBarWithImage:(NSString *)imageName WithTitle:(NSString *)title ForItemId:(NSString *)itemId;

- (void)addMsgTextBarWithTrdInfo:(NSDictionary *)trdExtendInfo;
- (NSArray *)getMsgTextBarButtonInfoList;

- (NSDictionary *)getExpandItemsForTrdextendId:(NSString *)trdextendId;

- (void)removeExpandItemsForType:(QIMTextBarExpandViewItemType)itemType;
- (NSDictionary *)getExpandItemsForType:(QIMTextBarExpandViewItemType)itemType;

- (BOOL)hasExpandItemForType:(QIMTextBarExpandViewItemType)itemType;
- (void)removeAllExpandItems;


@end
