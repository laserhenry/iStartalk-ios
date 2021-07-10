//
//  STDefalutMessageCell.m
//  qunarChatIphone
//
//  Created by 李露 on 2018/2/2.
//  Copyright © Startalk Ltd. 2021
//

#import "STMsgBaloonBaseCell.h"
#import "STDefalutMessageCell.h"
#import "QIMAttributedLabel.h"
#import "QIMMessageParser.h"

#define kTextLabelTop       10
#define kTextLableLeft      12
#define kTextLableBottom    10
#define kTextLabelRight     10
#define kMyCellHeightCap    14
#define kMyBackViewCap      55
#define kMinTextWidth       30
#define kMinTextHeight      30

@interface STDefalutMessageCell () <QIMMenuImageViewDelegate>

@property (nonatomic, strong) QIMAttributedLabel *messageLabel;

@property (nonatomic, strong) QIMTextContainer *textContainer;

@end

@implementation STDefalutMessageCell

- (QIMAttributedLabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[QIMAttributedLabel alloc] init];
        _messageLabel.backgroundColor = [UIColor clearColor];
    }
    return _messageLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.backView addSubview:self.messageLabel];
    }
    return self;
}

- (void)refreshUI {
    self.selectedBackgroundView.frame = self.contentView.frame;
    if (!self.textContainer) {
        self.textContainer = [QIMMessageParser textContainerForMessage:self.message];
    }
    [self.messageLabel clearOwnerView];
    self.messageLabel.textContainer = self.textContainer;
    CGFloat backWidth = self.messageLabel.textContainer.textWidth + 2 * kTextLableLeft + 10;
    CGFloat backHeight = self.messageLabel.textContainer.textHeight + 20;
    [self.backView setText:self.message.message];
    self.backView.message = self.message;
    [self setBackViewWithWidth:backWidth WithHeight:backHeight];
    [super refreshUI];
}

//判断是否有文字
- (BOOL)hasTextWithArray:(NSArray *)textStroages {
    
    BOOL flag = YES;
    for (id textStorage in textStroages) {
        
        if ([textStorage isKindOfClass:[QIMImageStorage class]]) {
            
            flag = NO;
            continue;
            
        } else {
            
            flag = YES;
            return YES;
            break;
        }
    }
    return flag;
}

//判断是否包含非Emotion表情和文字
- (BOOL)hasNoEmotionOrTestWithArray:(NSArray *)textStroages {
    
    BOOL flag = NO;
    NSInteger count = 0;
    for (id textStorage in textStroages) {
        
        if ([textStorage isKindOfClass:[QIMImageStorage class]]) {
            
            QIMImageStorage *imageStorage = textStorage;
            if (imageStorage.storageType == QIMImageStorageTypeEmotion) {
                
                flag = NO;
            } else {
                
                flag = YES;
                count++;
            }
            continue;
            
        }
    }
    if (count==1) {
        return YES;
    } else {
        return NO;
    }
    return flag;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.messageLabel setFrameWithOrign:CGPointMake(kTextLableLeft + (self.message.messageDirection == QIMMessageDirection_Sent ? 0 : 10),10) Width:_textContainer.textWidth];
}

- (NSArray *)showMenuActionTypeList {
    NSMutableArray *menuList = [NSMutableArray arrayWithCapacity:4];
    switch (self.message.messageDirection) {
        case QIMMessageDirection_Received: {
            if (self.textContainer.textStorages.count > 0 && [self hasTextWithArray:self.textContainer.textStorages]) {
                
                [menuList addObject:@(MA_Copy)];
            }
            if (self.textContainer.textStorages.count > 0 && [self hasNoEmotionOrTestWithArray:self.textContainer.textStorages]) {
                
                [menuList addObject:@(MA_Collection)];
            }
            [menuList addObjectsFromArray:@[@(MA_Refer),@(MA_Repeater), @(MA_ToWithdraw), @(MA_Delete), @(MA_Forward)]];
        }
            break;
        case QIMMessageDirection_Sent: {
            if (self.textContainer.textStorages.count > 0 && [self hasTextWithArray:self.textContainer.textStorages]) {
                
                [menuList addObject:@(MA_Copy)];
            }
            if (self.textContainer.textStorages.count > 0 && [self hasNoEmotionOrTestWithArray:self.textContainer.textStorages]) {
                
                [menuList addObject:@(MA_Collection)];
            }
            [menuList addObjectsFromArray:@[@(MA_Refer), @(MA_Repeater), @(MA_ToWithdraw), @(MA_Delete), @(MA_Forward)]];
        }
            break;
        default:
            break;
    }
    if ([[[STKit sharedInstance] qimNav_getDebugers] containsObject:[STKit getLastUserName]]) {
        [menuList addObject:@(MA_CopyOriginMsg)];
    }
    if ([[STKit sharedInstance] getIsIpad]) {
//        [menuList removeObject:@(MA_Refer)];
//        [menuList removeObject:@(MA_Repeater)];
//        [menuList removeObject:@(MA_Delete)];
        [menuList removeObject:@(MA_Forward)];
//        [menuList removeObject:@(MA_Repeater)];
    }
    return menuList;
}

@end
