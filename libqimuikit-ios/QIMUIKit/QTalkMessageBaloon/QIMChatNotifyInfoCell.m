//
//  QIMChatNotifyInfoCell.m
//  qunarChatIphone
//
//  Created by admin on 16/2/26.
//
//

#import "STMsgBaloonBaseCell.h"
#import "QIMChatNotifyInfoCell.h"
//#import "NSAttributedString+Attributes.h"
#import "QIMWebView.h"
#import "QIMAttributedLabel.h"
#import "QIMJSONSerializer.h"
#import "QIMMessageParser.h"
#import "QIMMessageCellCache.h"
#import "QIMTextContainer.h"
#import "MDHTMLLabel.h"
#import "../../../RTLabel.h"


#define kCellWidth                 IS_Ipad ? ([UIScreen mainScreen].qim_rightWidth  * 240 / 320) : ([UIScreen mainScreen].bounds.size.width * 4/5)

static double _global_message_cell_width = 0;

@interface QIMChatNotifyInfoCell() <RTLabelDelegate>

@property (nonatomic, strong) RTLabel * htmlLabel;
//@property (nonatomic, strong) MDHTMLLabel   *htmlLabel;

@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation QIMChatNotifyInfoCell
+ (CGFloat)getCellHeightWithMessage:(STMsgModel *)message chatType:(ChatType)chatType {
    
    RTLabel * label = [[RTLabel alloc] initWithFrame:CGRectMake(0, 0, kCellWidth, 20)];
    label.text = message.message;
    label.font = [UIFont systemFontOfSize:12];
//    [label sizeToFit];
    return [label optimumSize].height + 20;
    //去特么的第三方，算的高度是错的
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.backView setBubbleBgColor:[UIColor clearColor]];
        [self.backView setMenuViewHidden:YES];
        self.backView = nil;

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        [self.bgImageView setImage:[[UIImage qim_imageWithColor:0xDBDBDB] stretchableImageWithLeftCapWidth:6 topCapHeight:6]];
        self.bgImageView.backgroundColor = [UIColor colorWithRGBHex:0xD3D3D3];
        self.bgImageView.layer.masksToBounds = YES;
        self.bgImageView.layer.cornerRadius = 2.0f;
        [self.bgImageView setUserInteractionEnabled:YES];
        [self.contentView addSubview:self.bgImageView];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)refreshUI {
    if (self.htmlLabel) {
        [self.htmlLabel removeFromSuperview];
        self.htmlLabel.delegate = nil;
        self.htmlLabel = nil;
    }
    self.htmlLabel = [[RTLabel alloc] initWithFrame:CGRectMake(0, 0, kCellWidth, 20)];
    self.htmlLabel.backgroundColor = [UIColor clearColor];
    self.htmlLabel.textColor = [UIColor qim_colorWithHex:0x666666 alpha:1];
    [self.bgImageView addSubview:self.htmlLabel];
    
    self.nameLabel.hidden = YES;
    self.HeadView.hidden = YES;
    
    self.htmlLabel.delegate = self;
//    self.htmlLabel.numberOfLines = 0;
    self.htmlLabel.font = [UIFont systemFontOfSize:12];
    self.htmlLabel.textAlignment = RTTextAlignmentCenter;
//    self.htmlLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    self.htmlLabel.adjustsFontSizeToFitWidth = YES;
    
    self.htmlLabel.linkAttributes = @{@"color":@"#0000FF"};
//
    self.htmlLabel.selectedLinkAttributes = @{@"color":@"#0000FF"};
    if ([STKit getQIMProjectType] == QIMProjectTypeQChat) {
        [self.htmlLabel setText:self.message.message];
    } else {
        [self.htmlLabel setText:self.message.message];
    }
//    CGFloat height = [MDHTMLLabel sizeThatFitsHTMLString:self.message.message withFont:[UIFont systemFontOfSize:12] constraints:CGSizeZero limitedToNumberOfLines:0];
    CGSize titleSize = [self.htmlLabel optimumSize];
    CGFloat titleWidth = titleSize.width;
    CGFloat titleHeight = titleSize.height;
    
    self.bgImageView.frame = CGRectMake((self.frameWidth - titleWidth - 10) / 2.0, 5, titleWidth + 10, titleHeight + 10);
    self.htmlLabel.frame = CGRectMake(5, 5, titleWidth, titleHeight);
    
    NSDictionary *views = @{@"htmlLabel": self.htmlLabel};
    
    NSDictionary *metrics = @{@"padding": @(5)};
    
    [self.bgImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(5)-[htmlLabel]-(5)-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    [self.bgImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(5)-[htmlLabel]-(5)-|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
}
//- (void)HTMLLabel:(MDHTMLLabel *)label didSelectLinkWithURL:(NSURL *)URL {
//    QIMVerboseLog(@"Did select link with URL: %@", URL.absoluteString);
//    [QIMFastEntrance openWebViewForUrl:URL.absoluteString showNavBar:YES];
//}
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url{
    QIMVerboseLog(@"Did select link with URL: %@", url.absoluteString);
    [STFastEntrance openWebViewForUrl:url.absoluteString showNavBar:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

@end

@interface TransferInfoCell()

@end

@implementation TransferInfoCell{
    UIImageView *_bgImageView;
    QIMAttributedLabel   * _textLabel;
}

+ (CGFloat)getCellHeightWithMessage:(STMsgModel *)message chatType:(ChatType)chatType{
     QIMTextContainer *textContaner = [[QIMMessageCellCache sharedInstance] getObjectForKey:message.messageId];
    if (textContaner == nil) {
        NSString *content = message.message;
        switch (message.messageType) {
            case QIMMessageType_TransChatToCustomer:
            {
                NSDictionary *transDic = [[QIMJSONSerializer sharedInstance] deserializeObject:message.message error:nil];
                if (transDic) {
                    NSString *realtoId = [transDic objectForKey:@"realtoId"];
//                    NSString *toId = [transDic objectForKey:@"toId"];
//                    NSString *reason = [transDic objectForKey:@"TransReson"];
                    content = [NSString stringWithFormat:@"将要转移会话给%@",realtoId];
                }
            }
                break;
            case QIMMessageType_TransChatToCustomerService:
            {
                
            }
                break;
            case QIMMessageType_TransChatToCustomer_Feedback:
            {
//                NSDictionary *transDic = [[CJSONDeserializer deserializer] deserializeAsDictionary:[message.message dataUsingEncoding:NSUTF8StringEncoding] error:nil];
//                if (transDic) {
//                    NSString *realtoId = [transDic objectForKey:@"realtoId"];
//                    NSString *toId = [transDic objectForKey:@"toId"];
//                    NSString *reason = [transDic objectForKey:@"TransReson"];
//                    content = [NSString stringWithFormat:@"将要转移会话给%@",realtoId];
//                }
                content = @"收到用户转移反馈成功。";
            }
                break;
            case QIMMessageType_TransChatToCustomerService_Feedback:
            {
//                NSDictionary *transDic = [[CJSONDeserializer deserializer] deserializeAsDictionary:[message.message dataUsingEncoding:NSUTF8StringEncoding] error:nil];
//                if (transDic) {
//                    NSString *realtoId = [transDic objectForKey:@"realtoId"];
//                    NSString *toId = [transDic objectForKey:@"toId"];
//                    NSString *reason = [transDic objectForKey:@"TransReson"];
//                    content = [NSString stringWithFormat:@"将要转移会话给%@",realtoId];
//                }
                content = @"收到同事转移反馈成功。";
            }
                break;
            default:
                break;
        }
        STMsgModel *msg = [STMsgModel new];
        [msg setMessage:content];
        [msg setMessageId:message.messageId];
        [msg setMessageType:message.messageType];
        textContaner = [QIMMessageParser textContainerForMessage:msg];
    }
    return [textContaner getHeightWithFramesetter:nil width:textContaner.textWidth] + 20;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.backView setMenuViewHidden:YES];
        self.backView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_bgImageView setImage:[[UIImage qim_imageWithColor:qim_ChatTimestampCellBgColor] stretchableImageWithLeftCapWidth:6 topCapHeight:6]];
        [_bgImageView setUserInteractionEnabled:YES];
        [self.contentView addSubview:_bgImageView];
        
        _textLabel = [[QIMAttributedLabel alloc] init];
        _textLabel.backgroundColor = [UIColor clearColor];
        [_bgImageView addSubview:_textLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)refreshUI{
    _textLabel.textContainer = [QIMMessageParser textContainerForMessage:self.message];
    [_textLabel setFrameWithOrign:CGPointMake(5,5) Width:self.contentView.width];
    
    [_bgImageView setFrame:CGRectMake((self.frameWidth - _textLabel.textContainer.textWidth  - 10) / 2.0, 5, _textLabel.textContainer.textWidth + 10, _textLabel.textContainer.textHeight + 10)];
    self.HeadView.hidden = YES;
    self.nameLabel.hidden = YES;
}

@end

