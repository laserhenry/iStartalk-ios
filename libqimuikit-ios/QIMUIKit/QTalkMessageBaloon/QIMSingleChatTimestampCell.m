//
//  QIMSingleChatTimestampCell.m
//  DangDiRen
//
//  Created by ping.xue on 14-3-26.
//  Copyright (c) 2014年 Qunar.com. All rights reserved.
//

#import "QIMSingleChatTimestampCell.h"

@interface QIMSingleChatTimestampCell ()

@property (nonatomic, strong) UIButton *timestampButton;

@end

@implementation QIMSingleChatTimestampCell

- (UIButton *)timestampButton {
    if (!_timestampButton) {
        _timestampButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _timestampButton.frame = CGRectMake(100, 3, SCREEN_WIDTH - 200, 20);
        [_timestampButton setUserInteractionEnabled:NO];
        [_timestampButton setBackgroundImage:[[UIImage qim_imageWithColor:qim_ChatTimestampCellBgColor] stretchableImageWithLeftCapWidth:6 topCapHeight:6] forState:UIControlStateNormal];
        [_timestampButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
        _timestampButton.layer.cornerRadius = 2.0f;
        _timestampButton.layer.masksToBounds = YES;
        [_timestampButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _timestampButton.hidden = YES;
    }
    return _timestampButton;
}

+ (CGFloat)getCellHeightWithMessage:(STMsgModel *)message chatType:(ChatType)chatType {
    return 25;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.backView setMenuViewHidden:YES];
        self.backView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.timestampButton];
        self.HeadView.hidden = YES;
        self.nameLabel.hidden = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)refreshUI {
    
    long long msgDate = self.message.messageDate;
    NSString *timeStr = nil;
    if (self.message.message) {
        timeStr = self.message.message;
    } else {
        timeStr = [[NSDate qim_dateWithTimeIntervalInMilliSecondSince1970:msgDate] qim_formattedDateDescription];
    }
    if (self.message.messageType == QIMMessageType_Revoke) {
        
        timeStr = [NSString stringWithFormat:@" \"%@\"%@",[[STKit sharedInstance] getUserMarkupNameWithUserId:self.message.from], [NSBundle qim_localizedStringForKey:@"recalled_message"]];
    }
    if (timeStr) {
        CGSize size = [timeStr sizeWithFont:_timestampButton.titleLabel.font constrainedToSize:CGSizeMake(INT64_MAX, 15) lineBreakMode:NSLineBreakByCharWrapping];
        CGFloat width = size.width + 10;
        [self.timestampButton setFrame:CGRectMake((self.frameWidth - width)/2.0, 3, width, 20)];
        [self.timestampButton setHidden:NO];
        [self.timestampButton setTitle:timeStr forState:UIControlStateNormal];
    }
}

@end
