//
//  QIMChatRobotQuestionListTableViewCell.h
//  QIMUIKit
//
//  Created by qitmac000645 on 2019/8/28.
//

#import "QIMCommonUIFramework.h"
#import "STMsgBaloonBaseCell.h"


NS_ASSUME_NONNULL_BEGIN

@protocol QIMChatRobotQuestionListCellDelegate <NSObject>

/* 发送文本消息 */
- (void) sendQIMChatRobotQusetionListTextMessageForText:(NSString *)messageContent isSendToServer:(BOOL)isSendToServer userType:(NSString *)userType;

/* 刷新该语音消息cell */
- (void) refreshQIMChatRobotListQuestionMessageCell:(STMsgBaloonBaseCell *)cell;

@end

@interface QIMChatRobotQuestionListTableViewCell : STMsgBaloonBaseCell


@property (nonatomic, weak) id<QIMChatRobotQuestionListCellDelegate,QIMMsgBaloonBaseCellDelegate> delegate;

+ (float)cellHeightForMessage:(STMsgModel *)msg chatType:(ChatType)chatType;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithChatType:(ChatType)chatType;


@end

NS_ASSUME_NONNULL_END
