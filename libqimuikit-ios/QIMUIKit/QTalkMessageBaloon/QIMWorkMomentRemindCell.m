//
//  QIMWorkMomentRemindCell.m
//  QIMUIKit
//
//  Created by lilu on 2019/5/15.
//  Copyright © 2019 QIM. All rights reserved.
//

#import "QIMWorkMomentRemindCell.h"
#import "QIMJSONSerializer.h"
#import "STFastEntrance.h"

#define kCommonWorkMomentRemindCellWidth       IS_Ipad ? ([UIScreen mainScreen].qim_rightWidth  * 240 / 320) : ([UIScreen mainScreen].bounds.size.width * 5/7)

@interface QIMWorkMomentRemindCell () <QIMMenuImageViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, copy) NSString *postUUID;

@property (nonatomic, assign) NSInteger eventType;

@end

@implementation QIMWorkMomentRemindCell

+ (CGFloat)getCellHeightWithMessage:(STMsgModel *)message chatType:(ChatType)chatType{
    
    NSString *infoStr = message.extendInformation.length <= 0 ? message.message : message.extendInformation;
    NSDictionary *infoDic = [[QIMJSONSerializer sharedInstance] deserializeObject:infoStr error:nil];
    NSMutableString *mutableTitle = [[NSMutableString alloc] initWithString:@""];
    
    if ([infoDic isKindOfClass:[NSDictionary class]]) {
        NSString *title = [infoDic objectForKey:@"title"];
        [mutableTitle appendFormat:title];
        [mutableTitle appendString:@"\n\n"];
        NSArray *keyValues = [infoDic objectForKey:@"keyValues"];
        if ([keyValues isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in keyValues) {
                for (NSString *key in [dict allKeys]) {
                    
                    NSString *value = [dict objectForKey:key];
                    if (key.length) {
                        [mutableTitle appendFormat:[NSString stringWithFormat:@"%@:%@", key, (value.length > 0) ? value : @""]];
                        if (![dict isEqual:[keyValues lastObject]]) {
                            [mutableTitle appendFormat:@"\n"];
                        }
                    } else {
                        continue;
                    }
                }
            }
        } else {
            
        }
    } else {
        [mutableTitle appendString:infoStr];
    }
    
    CGSize descSize = [mutableTitle qim_sizeWithFontCompatible:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.60 - 20, MAXFLOAT)];
    return 75 + MAX(descSize.height, 20) + 35;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        UIView *view = [[UIView alloc]initWithFrame:self.contentView.frame];
        view.backgroundColor=[UIColor clearColor];
        self.selectedBackgroundView = view;
        
        self.frameWidth = [UIScreen mainScreen].bounds.size.width;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor qtalkTextBlackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [_titleLabel setNumberOfLines:0];
        [self.backView addSubview:_titleLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick)];
        [self.backView addGestureRecognizer:tap];
    }
    return self;
}

- (void)onClick {
    if (self.message.messageType == QIMMessageTypeWorkMomentRemind) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [STFastEntrance openWorkMomentDetailWithPOSTUUId:self.postUUID];
        });
    } else {
        
    }
}

- (NSString *)getMeetingRemindContent {
    NSString *infoStr = self.message.extendInformation.length <= 0 ? self.message.message : self.message.extendInformation;
    NSDictionary *infoDic = [[QIMJSONSerializer sharedInstance] deserializeObject:infoStr error:nil];
    NSMutableString *mutableTitle = [[NSMutableString alloc] initWithString:@""];
    
    if ([infoDic isKindOfClass:[NSDictionary class]]) {
        NSString *title = [infoDic objectForKey:@"title"];
        [mutableTitle appendFormat:title];
        [mutableTitle appendString:@"\n\n"];
        NSArray *keyValues = [infoDic objectForKey:@"keyValues"];
        if ([keyValues isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in keyValues) {
                for (NSString *key in [dict allKeys]) {
                    
                    NSString *value = [dict objectForKey:key];
                    if (key.length) {
                        [mutableTitle appendFormat:[NSString stringWithFormat:@"%@:%@ ", key, (value.length > 0) ? value : @""]];
                        if (![dict isEqual:[keyValues lastObject]]) {
                            [mutableTitle appendFormat:@"\n"];
                        }
                    } else {
                        continue;
                    }
                }
            }
        } else {
            
        }
        self.postUUID = [[infoDic objectForKey:@"params"] objectForKey:@"postUUID"];
        self.eventType = [[[infoDic objectForKey:@"params"] objectForKey:@"eventType"] integerValue];
    } else {
        [mutableTitle appendString:infoStr];
    }
    return mutableTitle;
}

- (void)refreshUI {
    
    self.selectedBackgroundView.frame = self.contentView.frame;
    CGFloat cellHeight = [QIMWorkMomentRemindCell getCellHeightWithMessage:self.message chatType:self.chatType];
    CGFloat cellWidth = kCommonWorkMomentRemindCellWidth;
    [self.backView setMessage:self.message];
    [self setBackViewWithWidth:cellWidth WithHeight:cellHeight];
    
    CGFloat titleLeft = (self.message.messageDirection == QIMMessageDirection_Sent) ? 15 : 25;
    NSString *content = [self getMeetingRemindContent];
    
    [_titleLabel setText:content.length > 0 ? content : @""];
    CGSize titleSize = [_titleLabel.text qim_sizeWithFontCompatible:_titleLabel.font constrainedToSize:CGSizeMake(cellWidth - titleLeft - 10, cellHeight - 30)];
    [_titleLabel setFrame:CGRectMake(titleLeft, 10, cellWidth - titleLeft - 10, titleSize.height)];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(titleLeft, cellHeight - 30, titleSize.width, 20)];
    NSMutableAttributedString *messageAttriStr = [[NSMutableAttributedString alloc] initWithString:@"点击查看详情>>"];
    [messageAttriStr addAttribute:NSForegroundColorAttributeName value:[UIColor qim_colorWithHex:0x009ad6 alpha:1.0] range:NSMakeRange(0, 8)];
    [messageAttriStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, 8)];
    text.attributedText = messageAttriStr;
    [self.backView addSubview:text];
    
    [super refreshUI];
}

- (NSArray *)showMenuActionTypeList {
    return @[];
}

@end
