//
//  QIMRedPackCell.m
//  qunarChatIphone
//
//  Created by chenjie on 15/12/24.
//
//

#define kQIMRedPackCellWidth   ([UIScreen mainScreen].bounds.size.width * 5 / 7)
#define kScale              ([UIScreen mainScreen].bounds.size.width / 320)

#import "STMsgBaloonBaseCell.h"
#import "QIMRedPackCell.h"
#import "QIMJSONSerializer.h"
#import "QIMIconInfo.h"

@interface QIMRedPackCell(){
    UILabel         * _titleLabel;
    UILabel         * _tipLabel;
    UIImageView     * _logoImageView;
    UILabel         * _statementLabel;
}

@end

@implementation QIMRedPackCell

+ (CGFloat)getCellHeightWithMessage:(STMsgModel *)message  chatType:(ChatType)chatType{
    return  [QIMRedPackCell redPackCellWidth] * 4 / 9 + ((chatType == ChatType_GroupChat) && (message.messageDirection == QIMMessageDirection_Received) ? 25 : 0) + 10;
}

+ (CGFloat)redPackCellWidth{
    if ([[STKit sharedInstance] getIsIpad]) {
        return ([[QIMWindowManager shareInstance] getDetailWidth] * 2 / 5);
    } else{
        return kQIMRedPackCellWidth;
    }
}

+ (CGFloat)scale{
    if ([[STKit sharedInstance] getIsIpad]) {
        return 1;
    }else{
        return kScale;
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.backView setMenuActionTypeList:@[]];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:13 * [QIMRedPackCell scale]];
        _titleLabel.text = @"恭喜发财！大吉大利";
        [self.contentView addSubview:_titleLabel];
        
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.text = @"领取红包";
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = [UIFont systemFontOfSize:11 *  [QIMRedPackCell scale]];
        [self.contentView addSubview:_tipLabel];
        
        _statementLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statementLabel.backgroundColor = [UIColor clearColor];
        _statementLabel.text = @"QChat红包";
        _statementLabel.textColor = [UIColor qtalkTextLightColor];
        _statementLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_statementLabel];
        
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _logoImageView.image = [UIImage qimIconWithInfo:[QIMIconInfo iconInfoWithText:@"\U0000f0e4" size:36 color:[UIColor whiteColor]]];
        [self.contentView addSubview:_logoImageView];
                
    }
    return self;
}

-(void)refreshUI{
    
    NSString * infoStr = self.message.extendInformation.length <= 0 ? self.message.message : self.message.extendInformation;
    if (infoStr.length > 0) {
        NSDictionary * infoDic = [[QIMJSONSerializer sharedInstance] deserializeObject:infoStr error:nil];
        [_titleLabel setText:infoDic[@"typestr"]];
        NSString * type = infoDic[@"type"];
        if (type == nil) {
            if ([STKit getQIMProjectType] == QIMProjectTypeQChat) {
                [_statementLabel setText:@"QChat红包"];
            }else{
                [_statementLabel setText:@"QTalk红包"];
            }
        }else{
            [_statementLabel setText:type];
        }
    }
    
    [self setBackViewWithWidth:[QIMRedPackCell redPackCellWidth] WithHeight:[QIMRedPackCell redPackCellWidth] * 4 / 9 - 10];
    [super refreshUI];
    switch (self.message.messageDirection) {
        case QIMMessageDirection_Received:
        {
            UIImage *image = [UIImage qim_imageNamedFromQIMUIKitBundle:@"redPackLeftBalloon"];
            CGFloat width = image.size.width / 2.0;
            CGFloat height = image.size.height / 2.0;
            [self.backView setImage:[image stretchableImageWithLeftCapWidth:width topCapHeight: height]];
            
        }
            break;
        case QIMMessageDirection_Sent:
        {
            UIImage *image = [UIImage qim_imageNamedFromQIMUIKitBundle:@"redPackRightBalloon"];
            CGFloat width = image.size.width / 2.0;
            CGFloat height = image.size.height / 2.0;
            [self.backView setImage:[image stretchableImageWithLeftCapWidth:width topCapHeight: height]];
        }
            break;
        default:
            break;
    }
    
    _logoImageView.frame = CGRectMake(self.backView.left + (15 + (self.message.messageDirection == QIMMessageDirection_Received ? 5 : 0)) *  [QIMRedPackCell scale], self.backView.top + 13 *  [QIMRedPackCell scale], 40 *  [QIMRedPackCell scale], 45 *  [QIMRedPackCell scale]);
    _titleLabel.frame = CGRectMake(_logoImageView.right + 5 *  [QIMRedPackCell scale], _logoImageView.top - 2 * [QIMRedPackCell scale] , [QIMRedPackCell redPackCellWidth] - 70 - 20, 25 *  [QIMRedPackCell scale]);
    _tipLabel.frame = CGRectMake(_logoImageView.right + 5 *  [QIMRedPackCell scale], _titleLabel.bottom + 5 * [QIMRedPackCell scale], [QIMRedPackCell redPackCellWidth] - 70 - 20, 15);
    
    _statementLabel.frame = CGRectMake(_logoImageView.left, self.backView.bottom - 23, [QIMRedPackCell redPackCellWidth] -30, 15);
}

- (NSArray *)showMenuActionTypeList {
    return @[];
}

@end
