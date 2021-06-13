//

//  QIMChatVC.m

//  qunarChatIphone

//

//  Created by wangshihai on 14/12/2.

//  Copyright (c) 2014年 ping.xue. All rights reserved.

//

#import "QIMPublicNumberRobotVC.h"
#import "QIMUUIDTools.h"
#import "QIMEmotionManager.h"
#import "QIMIconInfo.h"
#import "STDataContraller.h"
#import "QIMJSONSerializer.h"
#import "QIMTapGestureRecognizer.h"
#import "QIMSingleChatCell.h"
#import "QIMGroupChatCell.h"
#import "QIMSingleChatVoiceCell.h"
#import "QIMMenuImageView.h"
#import "QIMVoiceRecordingView.h"
#import "QIMVoicePathManage.h"
#import "QIMVoiceTimeRemindView.h"
#import "QIMChatBgManager.h"
#import <AVFoundation/AVFoundation.h>
#import "QIMMessageRefreshHeader.h"
#import "QIMRemoteAudioPlayer.h"
#import "QIMDisplayImage.h"
#import "QIMPhotoBrowserNavController.h"
#import "QIMContactSelectionViewController.h"
#import "QIMChatBGImageSelectController.h"
#import "QIMMessageBrowserVC.h"
#import "QIMFileManagerViewController.h"
#import "QIMPreviewMsgVC.h"
#import "QIMEmotionSpirits.h"
#import "QIMZBarViewController.h"
#import "QIMPublicNumberCardVC.h"
#import "QRCodeGenerator.h"
#import "STJumpURLHandle.h"
#import "QIMMWPhotoBrowser.h"
#import "QIMWebView.h"
#import "QIMPNActionRichTextCell.h"
#import "QIMPNRichTextCell.h"

#import "QIMWebView.h"

#import "QIMZBarViewController.h"

#import "QIMPublicNumberNoticeCell.h"
#import "QIMPublicNumberOrderMsgCell.h"
#import "QIMOpenPlatformCell.h"
#import "QIMChatVC.h"
#import "QIMTextBar.h"
#import "QIMMyFavoitesManager.h"

#import "QIMMessageParser.h"
#import "QIMTextContainer.h"
#import "QIMNavBackBtn.h"
#if __has_include("QIMIPadWindowManager.h")
#import "QIMIPadWindowManager.h"
#endif
#define kPageCount 20
#define kReSendMsgAlertViewTag 10000

@interface QDLoadingView : UIView
@property (nonatomic, strong) NSString *infoStr;
@end

@implementation QDLoadingView{
    UIView *_infoBackView;
    UILabel *_infoLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _infoBackView = [[UIView alloc] initWithFrame:CGRectZero];
        [_infoBackView setBackgroundColor:[UIColor qim_colorWithHex:0x0 alpha:0.65]];
        [_infoBackView.layer setCornerRadius:5];
        [_infoBackView setClipsToBounds:YES];
        [self addSubview:_infoBackView];
        
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_infoLabel setBackgroundColor:[UIColor clearColor]];
        [_infoLabel setFont:[UIFont systemFontOfSize:14]];
        [_infoLabel setTextColor:[UIColor whiteColor]];
        [_infoLabel setNumberOfLines:0];
        [_infoBackView addSubview:_infoLabel];
        
        self.alpha = 0;
    }
    return self;
}

- (void)setInfoStr:(NSString *)infoStr{
    
    _infoStr = infoStr;
    
    CGSize size = [_infoStr qim_sizeWithFontCompatible:_infoLabel.font constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, INT16_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    [_infoLabel setText:_infoStr];
    [_infoLabel setFrame:CGRectMake(10, 10, size.width, size.height)];
    
    CGRect backFrame;
    backFrame.size.width = size.width + 20;
    backFrame.size.height = size.height + 20;
    backFrame.origin.x = (self.width - backFrame.size.width) / 2.0;
    backFrame.origin.y = self.height - backFrame.size.height - 30;
    [_infoBackView setFrame:backFrame];
    
}

- (void)showLoadingView{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
    
}

@end

@interface ActionButton : UIButton
@property (nonatomic, strong) NSDictionary *actionContent;
@property (nonatomic, weak)   UIView *subActionView;
@property (nonatomic, weak)   UIView *owerView;
@end
@implementation ActionButton
- (void)dealloc{
    [self setActionContent:nil];
}

@end

@interface QIMPublicNumberRobotVC ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,QIMSingleChatCellDelegate,QIMSingleChatVoiceCellDelegate,NSXMLParserDelegate,QIMMWPhotoBrowserDelegate,QIMRemoteAudioPlayerDelegate,QIMMsgBaloonBaseCellDelegate,QIMChatBGImageSelectControllerDelegate,QIMPNRichTextCellDelegate,QIMPNActionRichTextCellDelegate,PNNoticeCellDelegate,PNOrderMsgCellDelegate,QIMOpenPlatformCellDelegate, QIMTextBarDelegate>
{
    
    bool _isReloading;
    NSMutableArray *_dataSounce;
    BOOL _isOnline;
    NSMutableDictionary *_cellSizeDic;
    NSString *_currentPlayVoiceMsgId;
    float _currentDownloadProcess;
    
    UIImageView *_headerView;
    CGRect _rootViewFrame;
    CGRect _tableViewFrame;
    
    BOOL _notIsFirstChangeTableViewFrame;
    BOOL _playStop;
    
    QIMRemoteAudioPlayer *_remoteAudioPlayer;
    UIView      * notificationView;
    UILabel     * commentCountLabel;
    UIImageView  * backImageView;
    QIMTapGestureRecognizer *_tap;
    NSMutableArray * _tempArray;
    
    NSMutableDictionary * _photos;
    UIView          * _progressView;
    
    UIImageView         * _chatBGImageView;
    
    UILabel         *_titleLabel;
    
   STMsgModel * _resendMsg;
    
    UIView *_actionBottomView;
    UIView *_textBarBottomView;
    BOOL _isActionOrTextBar;
    NSDictionary *_publicNumberCard;
    NSMutableArray *_actionList;
    UIView *_currentShowSubActionView;
    
    NSMutableDictionary *_tempClientCookieDic;
    
    BOOL _replayable;
    
    QDLoadingView *_qdLoadingView;
    int _qdSeconds;
    
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) QIMTextBar *textBar;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) QIMVoiceRecordingView *voiceRecordingView;
@property (nonatomic, strong) QIMVoiceTimeRemindView *voiceTimeRemindView;
@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIButton *cardButton;

@end

@implementation QIMPublicNumberRobotVC

#pragma mark - setter and getter

- (QIMTextBar *)textBar {
    
    if (!_textBar) {
        
        _textBar = [QIMTextBar sharedIMTextBarWithBounds:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) WithExpandViewType:QIMTextBarExpandViewTypePublicNumber];
        _textBar.associateTableView = self.tableView;
        [_textBar setDelegate:self];
        [_textBar setAllowSwitchBar:NO];
        [_textBar setAllowVoice:YES];
        [_textBar setAllowFace:YES];
        [_textBar setAllowMore:YES];
        [_textBar setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
//        [_textBar setPlaceHolder:@"文本信息"];
        __weak QIMTextBar *weakTextBar = _textBar;
        
        [_textBar setSelectedEmotion:^(NSString *faceStr) {
            if ([faceStr length] > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *text = [[QIMEmotionManager sharedInstance] getEmotionTipNameForShortCut:faceStr withPackageId:weakTextBar.currentPKId];
                    text = [NSString stringWithFormat:@"[%@]", text];
                    [weakTextBar insertEmojiTextWithTipsName:text shortCut:faceStr];
                });
            }
        }];
        
        [_textBar.layer setBorderColor:[UIColor qim_colorWithHex:0xadadad alpha:1].CGColor];
        [_textBar setIsRefer:NO];
        NSDictionary *notSendDic = [[STKit sharedInstance] getNotSendTextByJid:self.robotJId];
        [_textBar setQIMAttributedTextWithItems:notSendDic[@"inputItems"]];
        [_textBar.layer setBorderColor:[UIColor qim_colorWithHex:0xadadad alpha:1].CGColor];
        [_textBar setTextViewBackgroundImage:[[UIImage qim_imageNamedFromQIMUIKitBundle:@"chat_bottom_textfield"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        [self updateBottomView];
    }
    return _textBar;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 320, 20)];
        _titleLabel.text = self.title;
        _titleLabel.textColor = [UIColor qtalkTextBlackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _titleLabel;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - (_replayable?49:0) - [[QIMDeviceManager sharedInstance] getHOME_INDICATOR_HEIGHT]) style:UITableViewStylePlain];
        [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableViewFrame = _tableView.frame;
        [_tableView setBackgroundColor:[UIColor qtalkChatBgColor]];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        [_tableView setTableHeaderView:headerView];
        
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        [_tableView setTableFooterView:footView];
    }
    return _tableView;
}

- (QIMVoiceRecordingView *)voiceRecordingView {
    
    if (!_voiceRecordingView) {
        
        _voiceRecordingView = [[QIMVoiceRecordingView alloc] initWithFrame:CGRectMake(self.view.width/2-75, self.navigationController.navigationBar.height+150, 150, 150)];
        _voiceRecordingView.hidden = YES;
        _voiceRecordingView.userInteractionEnabled = NO;
    }
    return _voiceRecordingView;
}

- (QIMVoiceTimeRemindView *)voiceTimeRemindView {
    
    if (!_voiceTimeRemindView) {
        
        _voiceTimeRemindView = [[QIMVoiceTimeRemindView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-75, self.navigationController.navigationBar.height+150, 150, 150)];
        _voiceTimeRemindView.hidden = YES;
        _voiceTimeRemindView.userInteractionEnabled = NO;
    }
    return _voiceTimeRemindView;
}

- (UIView *)titleView {
    
    if (!_titleView) {
        
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        _titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _titleView.autoresizesSubviews = YES;
        _titleView.backgroundColor = [UIColor clearColor];
        [_titleView addSubview:self.titleLabel];
    }
    return _titleView;
}

- (UIButton *)cardButton {
    
    if (!_cardButton) {
        
        _cardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cardButton.frame = CGRectMake(10, 0, 44, 44);
        [_cardButton setImage:[UIImage qimIconWithInfo:[QIMIconInfo iconInfoWithText:@"\U0000f0eb" size:24 color:[UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1/1.0]]] forState:UIControlStateNormal];
        [_cardButton addTarget:self action:@selector(onCardClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cardButton;
}

- (void)initUI {
    
    
    self.view.backgroundColor = [UIColor qtalkChatBgColor];
    _rootViewFrame = self.view.frame;
    UIView *rightItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightItemView addSubview:self.cardButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemView];
    self.navigationItem.titleView = self.titleView;
    
    [self.view addSubview:self.tableView];
    
    
    if (_replayable) {
        [self.view addSubview:self.textBar];
        [self.textBar keyBoardDown];
    }
    [self loadData];

    if (_actionList.count > 0) {
        [self initActionBottomView];
    }
    [self refreshChatBGImageView];
    
    [self.view addSubview:_voiceRecordingView];
    [self.view addSubview:_voiceTimeRemindView];
    
#if (kHasVoice)
    
    _remoteAudioPlayer = [[QIMRemoteAudioPlayer alloc] init];
    
    [_remoteAudioPlayer setDelegate:self];
    
#endif
    
    [[STKit sharedInstance] clearNotReadMsgByJid:self.robotJId];
    
    //添加整个view的点击事件，当点击页面空白地方时，输入框收回
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    gesture.delegate = self;
    gesture.numberOfTapsRequired = 1;
    gesture.numberOfTouchesRequired = 1;
    [self.tableView addGestureRecognizer:gesture];
    
    self.tableView.mj_header = [QIMMessageRefreshHeader messsageHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewPublicNumberMsgList)];
    [self.tableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
}

- (void)tapHandler:(UITapGestureRecognizer *)tap {
    [self.textBar keyBoardDown];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tempClientCookieDic = [NSMutableDictionary dictionary];
    _publicNumberCard = [[STKit sharedInstance] getPublicNumberCardByJid:self.robotJId];
    NSDictionary *publicNumberInfo = [_publicNumberCard objectForKey:@"PublicNumberInfo"];
    _replayable = [[publicNumberInfo allKeys] containsObject:@"replayable"] ?     [[publicNumberInfo objectForKey:@"replayable"] boolValue] : YES;
    
    _actionList = [[_publicNumberCard objectForKey:@"PublicNumberInfo"] objectForKey:@"actionlist"];
    _photos = [[NSMutableDictionary alloc] init];
    [[STKit sharedInstance] setCurrentSessionUserId:self.robotJId];

    _cellSizeDic = [[NSMutableDictionary alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(expandViewItemHandleNotificationHandle:) name:kExpandViewItemHandleNotification object:nil];
    //消息发送成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(msgDidSendNotificationHandle:) name:kXmppStreamDidSendMessage object:nil];
    //消息发送失败
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(msgSendFailedNotificationHandle:) name:kXmppStreamSendMessageFailed object:nil];
    //重发消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(msgReSendNotificationHandle:) name:kXmppStreamReSendMessage object:nil];
    //消息被撤回
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(revokeMsgNotificationHandle:) name:kRevokeMsg object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMessageList:) name:kNotificationMessageUpdate object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTyping:) name:kTyping object:nil];
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(refreshTableView) name:@"refreshTableView" object:nil];

    [self initUI];
}

- (void)cancelTyping{
    [_titleLabel setText:self.title];
}

- (void)onTyping:(NSNotification *)notify{
//    if ([notify.object isEqualToString:self.robotId]) {
//        [_titleLabel setText:@"对方正在输入..."];
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cancelTyping) object:nil];
//        [self performSelector:@selector(cancelTyping) withObject:nil afterDelay:5];
//    }
}

-(void)loadData
{
    _dataSounce = [[NSMutableArray alloc] initWithArray:[[STKit sharedInstance] getPublicNumberMsgListById:self.robotJId WithLimit:kPageCount WithOffset:0]];
    [_tableView reloadData];
//    [self scrollToBottom_tableView];
    [self addImageToImageList];
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

- (void)onCardClick{
    QIMPublicNumberCardVC *cardVC = [[QIMPublicNumberCardVC alloc] init];
    [cardVC setPublicNumberId:self.publicNumberId];
    [cardVC setJid:self.robotJId];
    if ([[STKit sharedInstance] getPublicNumberCardByJid:self.robotJId]) {
        [cardVC setNotConcern:NO];
    } else {
        [cardVC setNotConcern:YES];
    }
    [self.navigationController pushViewController:cardVC animated:YES];
}

- (void)setBackBtn {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    QIMNavBackBtn *backBtn = [QIMNavBackBtn sharedInstance];
    [backBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //将宽度设为负值
    spaceItem.width = -15;
    //将两个BarButtonItem都返回给N
    self.navigationItem.leftBarButtonItems = @[spaceItem,backBarBtn];
}

- (void)leftBarBtnClicked:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    if ([[STKit sharedInstance] getIsIpad] == NO) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
#if __has_include("QIMIPadWindowManager.h")
        [[QIMIPadWindowManager sharedInstance] showOriginLaunchDetailVC];
#endif
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setBackBtn];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_remoteAudioPlayer stop];
    _currentPlayVoiceMsgId = nil;
}

- (void)selfPopedViewController{
    [super selfPopedViewController];
    [[STKit sharedInstance] setNotSendText:[self.textBar getSendAttributedText] inputItems:[self.textBar getAttributedTextItems] ForJid:self.robotJId];
    [[STKit sharedInstance] setCurrentSessionUserId:nil];
    [[STKit sharedInstance] clearNotReadMsgByJid:self.robotJId];
}

- (void)goBack:(id)sender{
    [[STKit sharedInstance] setCurrentSessionUserId:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[STKit sharedInstance] clearNotReadMsgByJid:self.robotJId];
}

- (void)updateBottomView{
    if (_isActionOrTextBar) {
        _actionBottomView.hidden = NO;
        [self.view bringSubviewToFront:_actionBottomView];
        self.textBar.hidden = YES;
        [UIView animateWithDuration:0.2 animations:^{
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                [_actionBottomView setFrame:CGRectMake(0,self.view.frame.size.height - 49 - [[QIMDeviceManager sharedInstance] getHOME_INDICATOR_HEIGHT], self.view.frame.size.width, 49)];
            }];
        }];
    } else {
        self.textBar.hidden = NO;
        [self.view bringSubviewToFront:self.textBar];
        _actionBottomView.hidden = YES;
        [UIView animateWithDuration:0.2 animations:^{
            [_actionBottomView setFrame:CGRectMake(0,self.view.frame.size.height - [[QIMDeviceManager sharedInstance] getHOME_INDICATOR_HEIGHT], self.view.frame.size.width, 49)];
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)onShowTextBarClick:(UIButton *)sender{
    _isActionOrTextBar = NO;
    [self updateBottomView];
}

- (void)showActionBottomView{
    _isActionOrTextBar = YES;
    [self updateBottomView];
}

- (void)onActionClick:(ActionButton *)sender{
    NSString *action = [sender.actionContent objectForKey:@"action"];
    NSString *value = [sender.actionContent objectForKey:@"value"];
    if ([action isEqualToString:@"openurl"]) {
        QIMWebView *webView = [[QIMWebView alloc] init];
        [webView setUrl:value];
        [self.navigationController pushViewController:webView animated:YES];
    } else if ([action isEqualToString:@"sendmsg"]) {
        if ([value isKindOfClass:[NSString class]] == NO) {
            value = [[QIMJSONSerializer sharedInstance] serializeObject:value];
        }
        [self sendMessage:value WithInfo:nil ForMsgType:PublicNumberMsgType_Action];
    } else if ([action isEqualToString:@"qrcode"]) {
        
        [STFastEntrance openQRCodeVC];
    } else if ([action isEqualToString:@"barcode"]) {
        
        QIMZBarViewController*vc=[[QIMZBarViewController alloc] initWithBlock:^(NSString *str, BOOL isScceed) {
            if (isScceed) {
                id value = [sender.actionContent objectForKey:@"value"];
                if ([value isKindOfClass:[NSString class]]) {
                    value = [[QIMJSONSerializer sharedInstance] deserializeObject:value error:nil];
                }
                if ([value isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:value];
                    [dic setObject:str forKey:@"content"];
                    NSString *json = [[QIMJSONSerializer sharedInstance] serializeObject:dic];
                    [self sendMessage:json WithInfo:nil ForMsgType:PublicNumberMsgType_Action];
                    
                }
            }
        }];
        [vc setCodeType:CodeType_BarCode];
        [self presentViewController:vc animated:YES completion:nil];
    } else if ([action isEqualToString:@"postbackcookie"]){
        NSDictionary *dic = (NSDictionary *)value;
        if ([value isKindOfClass:[NSString class]]) {
            dic = [[QIMJSONSerializer sharedInstance] deserializeObject:value error:nil];
        }
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSString *key = [dic objectForKey:@"key"];
            id value = [_tempClientCookieDic objectForKey:key];
            if (value) {
                NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                [resultDic setObject:value forKey:@"value"];
                NSString *json = [[QIMJSONSerializer sharedInstance] serializeObject:resultDic];
                [[STKit sharedInstance] sendMessage:json ToPublicNumberId:self.robotJId WithMsgId:[QIMUUIDTools UUID] WithMsgType:PublicNumberMsgType_PostBackCookie];
            } else {
                NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                [resultDic setObject:@(404) forKey:@"errcode"];
                NSString *json = [[QIMJSONSerializer sharedInstance] serializeObject:resultDic];
                [[STKit sharedInstance] sendMessage:json ToPublicNumberId:self.robotJId WithMsgId:[QIMUUIDTools UUID] WithMsgType:PublicNumberMsgType_PostBackCookie];
            }
        } else {
            NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            [resultDic setObject:@(500) forKey:@"errcode"];
            [resultDic setObject:@"消息体格式错喔" forKey:@"errmsg"];
            [resultDic setObject:[NSString stringWithFormat:@"%@",value] forKey:@"content"];
            NSString *json = [[QIMJSONSerializer sharedInstance] serializeObject:resultDic];
            [[STKit sharedInstance] sendMessage:json ToPublicNumberId:self.robotJId WithMsgId:[QIMUUIDTools UUID] WithMsgType:PublicNumberMsgType_PostBackCookie];
        }
    }
    [self hidenSubActionView];
}

- (void)onShowSubActionClick:(ActionButton *)sender{
    if (![_currentShowSubActionView isEqual:sender.subActionView]) {
        [self hidenSubActionView];
        _currentShowSubActionView = sender.subActionView;
        [UIView animateWithDuration:0.3 animations:^{
            [sender.subActionView setTop:_actionBottomView.top - sender.subActionView.height];
        }];
    } else {
        [self hidenSubActionView];
    }
}

- (void)hidenSubActionView{
    [UIView animateWithDuration:0.3 animations:^{
        [_currentShowSubActionView setTop:_actionBottomView.bottom];
    }];
    _currentShowSubActionView = nil;
}

- (void)initActionBottomView{
    
    _actionBottomView = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height - 49 - [[QIMDeviceManager sharedInstance] getHOME_INDICATOR_HEIGHT], self.view.frame.size.width, 49)];
    [_actionBottomView setBackgroundColor:[UIColor qim_colorWithHex:0xf9f9f9 alpha:1]];
    [self.view addSubview:_actionBottomView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _actionBottomView.width, 0.5)];
    [lineView setBackgroundColor:[UIColor qtalkSplitLineColor]];
    [_actionBottomView addSubview:lineView];
    
    UIButton *showTextBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [showTextBarBtn setBackgroundImage:[UIImage qim_imageNamedFromQIMUIKitBundle:@"Mode_listtotext"] forState:UIControlStateNormal];
    [showTextBarBtn setBackgroundImage:[UIImage qim_imageNamedFromQIMUIKitBundle:@"Mode_listtotextHL"] forState:UIControlStateHighlighted];
    [showTextBarBtn addTarget:self action:@selector(onShowTextBarClick:) forControlEvents:UIControlEventTouchUpInside];
    [_actionBottomView addSubview:showTextBarBtn];
    
    CGFloat width = (_actionBottomView.width - 44) / _actionList.count;
    CGFloat startX = 44;
    for (NSDictionary *actionDic in _actionList) {
        NSString *mainaction = [actionDic objectForKey:@"mainaction"];
        NSDictionary *actioncontent = [actionDic objectForKey:@"actioncontent"];
        NSArray *subActions = [actionDic objectForKey:@"subactions"];
        ActionButton *mainButton = [[ActionButton alloc] initWithFrame:CGRectMake(startX, 0, width, 44)];
        [mainButton setActionContent:actioncontent]; 
        [mainButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [mainButton.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [mainButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [mainButton setTitleColor:[UIColor qtalkTextBlackColor] forState:UIControlStateNormal];
        [mainButton setTitle:mainaction forState:UIControlStateNormal];
        [mainButton setBackgroundImage:[UIImage qim_imageFromColor:[UIColor qtalkTableDefaultColor]] forState:UIControlStateHighlighted];
        if (subActions.count > 0) {
            [mainButton setImage:[UIImage qim_imageNamedFromQIMUIKitBundle:@"Mode_textmenuicon"] forState:UIControlStateNormal];
            UIView *subActionView = [[UIView alloc] initWithFrame:CGRectMake(startX, _actionBottomView.bottom, width, 0)];
            [self.view insertSubview:subActionView aboveSubview:_tableView];
            [mainButton setSubActionView:subActionView];
            
            CGFloat bianWidth = (subActionView.width-18)/2.0;
            UIImageView *leftBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bianWidth, 0)];
            [leftBgView setImage:[[UIImage qim_imageNamedFromQIMUIKitBundle:@"Mode_more_frame_left"] stretchableImageWithLeftCapWidth:15 topCapHeight:32]];
            [subActionView addSubview:leftBgView];
            
            UIImageView *rightBgView = [[UIImageView alloc] initWithFrame:CGRectMake(subActionView.width-bianWidth, 0, bianWidth, 0)];
            [rightBgView setImage:[[UIImage qim_imageNamedFromQIMUIKitBundle:@"Mode_more_frame_right"] stretchableImageWithLeftCapWidth:15 topCapHeight:32]];
            [subActionView addSubview:rightBgView];
            
            UIImageView *middleView = [[UIImageView alloc] initWithFrame:CGRectMake(bianWidth, 0, 18, 0)];;
            [middleView setImage:[[UIImage qim_imageNamedFromQIMUIKitBundle:@"Mode_more_frame_middle"] stretchableImageWithLeftCapWidth:9 topCapHeight:32]];
            [subActionView addSubview:middleView];
            
            CGFloat cap = 10;
            CGFloat startY = cap;
            for (NSDictionary *subActionDic in subActions) {
                NSString *subaction = [subActionDic objectForKey:@"subaction"];
                NSDictionary *actioncontent = [subActionDic objectForKey:@"actioncontent"];
                ActionButton *button = [[ActionButton alloc] initWithFrame:CGRectMake(0, startY, width, 32)];
                [button setActionContent:actioncontent];
                [button setOwerView:subActionView];
                [button setBackgroundImage:[[UIImage qim_imageNamedFromQIMUIKitBundle:@"Mode_more_frame_Choose"] stretchableImageWithLeftCapWidth:40 topCapHeight:16] forState:UIControlStateHighlighted];
                [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [button setTitleColor:[UIColor qtalkTextBlackColor] forState:UIControlStateNormal];
                [button setTitle:subaction forState:UIControlStateNormal];
                [button addTarget:self action:@selector(onActionClick:) forControlEvents:UIControlEventTouchUpInside];
                [subActionView addSubview:button];
                startY += 32 + 2;
                if (![[subActions lastObject] isEqual:subActionDic]) {
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, startY, subActionView.width - 30,0.5)];
                    [lineView setBackgroundColor:[UIColor qtalkSplitLineColor]];
                    [subActionView addSubview:lineView];
                }
                startY += 2;
            }
            [leftBgView setHeight:startY+cap+10];
            [rightBgView setHeight:startY+cap+10];
            [middleView setHeight:startY+cap+10];
            [subActionView setHeight:startY+cap+10];
            [mainButton addTarget:self action:@selector(onShowSubActionClick:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [mainButton addTarget:self action:@selector(onActionClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        [_actionBottomView addSubview:mainButton];
        startX += width;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(startX, 0, 0.5, _actionBottomView.height)];
        [lineView setBackgroundColor:[UIColor qtalkSplitLineColor]];
        [_actionBottomView addSubview:lineView];
    }
    
    _isActionOrTextBar = YES;
}

- (void)refreshChatBGImageView {
    
    if (!_chatBGImageView) {
        
        _chatBGImageView = [[UIImageView alloc] initWithFrame:_tableView.bounds];
        _chatBGImageView.contentMode = UIViewContentModeScaleAspectFill;
        _chatBGImageView.clipsToBounds = YES;
    }
    
    if ([[STKit sharedInstance] waterMarkState] == YES) {
        [[QIMChatBgManager sharedInstance] getChatBgById:[STKit getLastUserName] ByName:[[STKit sharedInstance] getMyNickName] WithReset:NO Complete:^(UIImage * _Nonnull bgImage) {
            _chatBGImageView.image = bgImage;
            _tableView.backgroundView = _chatBGImageView;
        }];
    }
}

- (void)dealloc {
    
#if kHasVoice
    _remoteAudioPlayer = nil;
#endif
    
    _currentPlayVoiceMsgId = nil;
    _cellSizeDic = nil;
    _dataSounce = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidUnload {
    _tableView = nil;
    [super viewDidUnload];
}

#if kHasVoice

#pragma mark - Audio Method

- (BOOL)playingVoiceWithMsgId:(NSString *)msgId{
    return [msgId isEqualToString:_currentPlayVoiceMsgId];
}

- (void)playVoiceWithMsgId:(NSString *)msgId WithFilePath:(NSString *)filePath{
    _currentPlayVoiceMsgId = msgId;
    if (_currentPlayVoiceMsgId) {
        // 开始播放
        if ([filePath qim_hasPrefixHttpHeader]) {
            [_remoteAudioPlayer prepareForURL:filePath playAfterReady:YES];
        } else {
            [_remoteAudioPlayer prepareForFilePath:filePath playAfterReady:YES];
        }
    } else {
        // 结束播放
        [_remoteAudioPlayer stop];
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [_tableView reloadData];
    }
}

//add by dan.zheng 15/4/29
- (void)playVoiceWithMsgId:(NSString *)msgId WithFileName:(NSString *)fileName andVoiceUrl:(NSString *)voiceUrl{
    _currentPlayVoiceMsgId = msgId;
     if (_currentPlayVoiceMsgId) {
        [_remoteAudioPlayer prepareForFileName:fileName andVoiceUrl:voiceUrl playAfterReady:YES];
    } else {
        [_remoteAudioPlayer stop];
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }
    [_tableView reloadData];
}

- (void)remoteAudioPlayerReady:(QIMRemoteAudioPlayer *)player{
    
}

- (void)remoteAudioPlayerErrorOccured:(QIMRemoteAudioPlayer *)player withErrorCode:(QIMRemoteAudioPlayerErrorCode)errorCode{
    
}

- (void)remoteAudioPlayerDidStartPlaying:(QIMRemoteAudioPlayer *)player{
     [self updateCurrentPlayVoiceTime];
}



- (void)remoteAudioPlayerDidFinishPlaying:(QIMRemoteAudioPlayer *)player{
     _currentPlayVoiceMsgId = nil;
     [_tableView reloadData];
}

- (void)updateCurrentPlayVoiceTime{
    if (_currentPlayVoiceMsgId) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyPlayVoiceTime object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:_remoteAudioPlayer.currentTime],kNotifyPlayVoiceTimeTime,_currentPlayVoiceMsgId,kNotifyPlayVoiceTimeMsgId, nil]];
        [self performSelector:@selector(updateCurrentPlayVoiceTime) withObject:nil afterDelay:1];
    }
}

- (int)playCurrentTime{
    return _remoteAudioPlayer.currentTime;
}

- (void)downloadProgress:(float)newProgress{
    if (_currentPlayVoiceMsgId) {
        _currentDownloadProcess = newProgress;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyDownloadProgress object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:_currentDownloadProcess],kNotifyDownloadProgressProgress,_currentPlayVoiceMsgId,kNotifyDownloadProgressMsgId, nil]];
    } else {
        _currentDownloadProcess = 1;
    }
}

- (double)getCurrentDownloadProgress{
    return _currentDownloadProcess;
}

#endif

#pragma mark - notification

- (void)expandViewItemHandleNotificationHandle:(NSNotification *)notify
{
}

- (void)msgDidSendNotificationHandle:(NSNotification *)notify
{
    NSString * msgID = [notify.object objectForKey:@"messageId"];
    
    //消息发送成功，更新消息状态，刷新tableView
    for (STMsgModel * msg in _dataSounce) {
        //找到对应的msg，目前还不知道msgID
        if ([[msg messageId] isEqualToString:msgID]) {
            if (msg.messageSendState < QIMMessageSendState_Success) {
                msg.messageSendState = QIMMessageSendState_Success;
            }
            break;
        }
    }
}

- (void) msgSendFailedNotificationHandle:(NSNotification *)notify
{
    NSString * msgID = [notify.object objectForKey:@"messageId"];
    //消息发送失败，更新消息状态，刷新tableView
    for (STMsgModel * msg in _dataSounce) {
        //找到对应的msg，目前还不知道msgID
        if ([[msg messageId] isEqualToString:msgID]) {
            if (msg.messageSendState < QIMMessageSendState_Faild) {
                msg.messageSendState = QIMMessageSendState_Faild;
            }
            break;
        }
    }
}

- (void)removeFailedMsg {
    STMsgModel * message = _resendMsg;
    for (STMsgModel * msg in _dataSounce) {
        if ([msg isEqual:message]) {
            NSInteger index = [_dataSounce indexOfObject:msg];
            [_dataSounce removeObject:msg];
            [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            [[STKit sharedInstance] deleteMsg:message ByJid:self.robotJId];
            break;
        }
    }
}

- (void)reSendMsg {
   STMsgModel * message = _resendMsg;
    [self removeFailedMsg];
    if (message.messageType == QIMMessageType_LocalShare) {
        [self sendMessage:message.message WithInfo:message.extendInformation ForMsgType:message.messageType];
    } else if (message.messageType == QIMMessageType_Voice){

        NSDictionary *infoDic = [[QIMJSONSerializer sharedInstance] deserializeObject:message.message error:nil];
        NSString *fileName = [infoDic objectForKey:@"FileName"];
        NSNumber *Seconds = [infoDic objectForKey:@"Seconds"];
        NSString *filePath = [QIMVoicePathManage getPathByFileName:fileName ofType:@"amr"];


        [self sendVoiceWithDuration:[Seconds intValue] WithFileName:fileName AndFilePath:filePath];
    } else if (message.messageType == QIMMessageType_Text){
        if ([self isImageMessage:message.message]) {
            
            QIMTextContainer *textContainer = [QIMMessageParser textContainerForMessage:message];
            QIMImageStorage *imageStorage = textContainer.textStorages.lastObject;
            NSString *imagePath = imageStorage.imageURL.absoluteString;
            if ([imagePath containsString:@"LocalFileName"]) {
                imagePath = [[imagePath componentsSeparatedByString:@"LocalFileName="] lastObject];
                [self qim_textbarSendImageWithImagePath:imagePath];
            } else {
                //图片上传成功，发消息失败
                [[STKit sharedInstance] sendMessage:message ToUserId:message.to];
            }
        }else{
            
            message = [[STKit sharedInstance] createMessageWithMsg:message.message extenddInfo:message.extendInformation userId:self.robotJId userType:ChatType_SingleChat msgType:message.messageType forMsgId:_resendMsg.messageId];
            
            [_dataSounce addObject:message];
            [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_dataSounce.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
            
            message = [[STKit sharedInstance] sendMessage:message ToUserId:self.robotJId];
            [self scrollToBottomWithCheck:YES];
        }
    } else if (message.messageType == QIMMessageType_CardShare){
        [self sendMessage:message.message WithInfo:message.extendInformation ForMsgType:message.messageType];
    } else if (message.messageType == QIMMessageType_SmallVideo){
        NSDictionary *infoDic = [[QIMJSONSerializer sharedInstance] deserializeObject:message.message error:nil];
        NSString *filePath = [[[STKit sharedInstance] getDownloadFilePath] stringByAppendingPathComponent:[infoDic objectForKey:@"ThumbName"]?[infoDic objectForKey:@"ThumbName"]:@""];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        
        NSString * videoPath = [[[STKit sharedInstance] getDownloadFilePath] stringByAppendingFormat:@"/%@", [infoDic objectForKey:@"FileName"]];
        
        [self sendVideoPath:videoPath WithThumbImage:image WithFileSizeStr:[infoDic objectForKey:@"FileSize"] WithVideoDuration:[[infoDic objectForKey:@"Duration"] floatValue] forMsgId:_resendMsg.messageId];
    }
    _resendMsg = nil;
}


- (void) msgReSendNotificationHandle : (NSNotification *)notify
{
    
    _resendMsg = notify.object;
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"重发该消息？" message:nil delegate:self cancelButtonTitle:[NSBundle qim_localizedStringForKey:@"Cancel"] otherButtonTitles:[NSBundle qim_localizedStringForKey:@"Delete"],[NSBundle qim_localizedStringForKey:@"Resend"], nil];
    
    alertView.tag = kReSendMsgAlertViewTag;
    alertView.delegate = self;
    [alertView show];
    return;
}

- (void)revokeMsgNotificationHandle:(NSNotification *)notify
{
//    NSString * jid = notify.object;
    NSString * msgID = [notify.userInfo objectForKey:@"MsgId"];
//    NSString * content = [notify.userInfo objectForKey:@"Content"];
    for (STMsgModel * msg in _dataSounce) {
        if ([msg.messageId isEqualToString:msgID]) {
            NSInteger index = [_dataSounce indexOfObject:msg];
            [(STMsgModel *)msg setMessageType:QIMMessageType_Revoke];
            [_dataSounce replaceObjectAtIndex:index withObject:msg];
            [[STKit sharedInstance] updateMsg:msg ByJid:self.robotJId];
            [_tableView reloadData];
            break;
        }
    }
}

- (BOOL)isImageMessage:(NSString *)msg{
    
    NSString *regulaStr = @"\\[obj type=\"(.*?)\" value=\"(.*?)\"(.*?)\\]";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:msg options:0 range:NSMakeRange(0, [msg length])];
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSRange firstRange  =  [match rangeAtIndex:1];
        NSString *type = [msg substringWithRange:firstRange];
        if ([type isEqualToString:@"image"]) {
            return YES;
        }
    }
    return NO;
}

- (void)updateHistoryMessageList:(NSNotification *)notify{
    
}


//
// 二人消息 是在这里收到的

- (void)updateMessageList:(NSNotification *)notify {
    if ([self.robotJId isEqualToString:notify.object]) {
        STMsgModel *msg = [notify.userInfo objectForKey:@"message"];
        
        if (msg) {
            if (msg.messageType == PublicNumberMsgType_ClientCookie) {
                NSDictionary *dic = [[QIMJSONSerializer sharedInstance] deserializeObject:msg.message error:nil];
                NSString *key = [dic objectForKey:@"key"];
                id value = [dic objectForKey:@"value"];
                if (key && value) {
                    [_tempClientCookieDic setObject:value forKey:key];
                }
            } else if (msg.messageType == PublicNumberMsgType_PostBackCookie) {
                NSDictionary *dic = [[QIMJSONSerializer sharedInstance] deserializeObject:msg.message error:nil];
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    NSString *key = [dic objectForKey:@"key"];
                    id value = [_tempClientCookieDic objectForKey:key];
                    if (value) {
                        NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                        [resultDic setObject:value forKey:@"value"];
                        NSString *json = [[QIMJSONSerializer sharedInstance] serializeObject:resultDic];
                        [[STKit sharedInstance] sendMessage:json ToPublicNumberId:self.robotJId WithMsgId:[QIMUUIDTools UUID] WithMsgType:PublicNumberMsgType_PostBackCookie];
                    } else {
                        NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                        [resultDic setObject:@(404) forKey:@"errcode"];
                        NSString *json = [[QIMJSONSerializer sharedInstance] serializeObject:resultDic];
                        [[STKit sharedInstance] sendMessage:json ToPublicNumberId:self.robotJId WithMsgId:[QIMUUIDTools UUID] WithMsgType:PublicNumberMsgType_PostBackCookie];
                    }
                } else {
                    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                    [resultDic setObject:@(500) forKey:@"errcode"];
                    [resultDic setObject:@"消息体格式错喔" forKey:@"errmsg"];
                    [resultDic setObject:[NSString stringWithFormat:@"%@",msg.message] forKey:@"content"];
                    NSString *json = [[QIMJSONSerializer sharedInstance] serializeObject:resultDic];
                    [[STKit sharedInstance] sendMessage:json ToPublicNumberId:self.robotJId WithMsgId:[QIMUUIDTools UUID] WithMsgType:PublicNumberMsgType_PostBackCookie];
                }
                
            } else if (msg.messageType == PublicNumberMsgType_Action) {
                
            } else if (msg.messageType == QIMMessageType_ConsultResult) {
                NSDictionary *resultContent = [[QIMJSONSerializer sharedInstance] deserializeObject:msg.message error:nil];
                NSString *name = [resultContent objectForKey:@"nickname"];
                NSString *dealid = [resultContent objectForKey:@"dealid"];
                NSString *sessionId = [resultContent objectForKey:@"sessionid"];
                if ([sessionId rangeOfString:@"@"].location == NSNotFound) {
                    sessionId = [sessionId stringByAppendingFormat:@"@%@",[[STKit sharedInstance] getDomain]];
                }
                BOOL result = [[resultContent objectForKey:@"result"] boolValue];
                NSString *errorinfo = [resultContent objectForKey:@"errorinfo"];
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateQDLoadingView) object:nil];
                _qdSeconds = 0;
                [_qdLoadingView setInfoStr:errorinfo];
                [self performSelector:@selector(hiddenQDLoadingView) withObject:nil afterDelay:1.5];
                if (result) {
                    [[STKit sharedInstance] setDealId:dealid ForState:QDDealState_True];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateOpenPlatormMsg" object:dealid];
                    [self openSingleChatVC:sessionId WithName:name];
                } else {
                    [[STKit sharedInstance] setDealId:dealid ForState:QDDealState_Faild];
                    [self performSelector:@selector(updateQDLoadingView) withObject:nil afterDelay:1];
                }
                [_tableView reloadData];
            } else {
                [_dataSounce addObject:msg];
                [_tableView reloadData];
                // [self insertMessage:msg];
                [self addImageToImageList];
                [self scrollToBottomWithCheck:YES];
            }
        }
    }
}

- (void)openSingleChatVC:(NSString *)userId WithName:(NSString *)name{
    [STFastEntrance openSingleChatVCByUserId:userId];
}

- (void)scrollToBottomWithCheck:(BOOL)flag{
    
    CGFloat h1 = _tableView.contentOffset.y + _tableView.frame.size.height;
    
    CGFloat h2 =  _tableView.contentSize.height - 250;
    
    CGFloat tempOffY = (_tableView.contentSize.height - _tableView.frame.size.height);
    
    if ( ( !flag || h1 > h2) && tempOffY > 0) {
        
        [_tableView setContentOffset:CGPointMake(0, tempOffY) animated:YES];
        
        [self hidePopView];
    }
    else{
        //现实气泡
        if (_tableView.contentSize.height > _tableView.frame.size.height)
        {
            
            [self showPopView];
        } 
    }
}

#pragma mark - text bar delegate

#pragma mark - 视频

- (void)sendVideoPath:(NSString *)videoPath WithThumbImage:(UIImage *)thumbImage WithFileSizeStr:(NSString *)fileSizeStr WithVideoDuration:(float)duration {
    [self sendVideoPath:videoPath WithThumbImage:thumbImage WithFileSizeStr:fileSizeStr WithVideoDuration:duration forMsgId:nil];
}

- (void)sendVideoPath:(NSString *)videoPath
       WithThumbImage:(UIImage *)thumbImage
      WithFileSizeStr:(NSString *)fileSizeStr
    WithVideoDuration:(float)duration
             forMsgId:(NSString *)mId {
    NSString *msgId = mId.length ? mId : [QIMUUIDTools UUID];
    CGSize size = thumbImage.size;
    NSData *thumbData = UIImageJPEGRepresentation(thumbImage, 0.8);
    NSString *pathExtension = [[videoPath lastPathComponent] pathExtension];
    NSString *fileName = [[videoPath lastPathComponent] stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@",pathExtension] withString:@"_thumb.jpg"];
    NSString *thumbFilePath = [videoPath stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@",pathExtension] withString:@"_thumb.jpg"];
    [thumbData writeToFile:thumbFilePath atomically:YES];
}

- (void)sendMessage:(NSString *)message WithInfo:(NSString *)info ForMsgType:(int)msgType{
    if (msgType != PublicNumberMsgType_Action) {
       STMsgModel * msg = [[STKit sharedInstance] createPublicNumberMessageWithMsg:message extenddInfo:info publicNumberId:[NSString stringWithFormat:@"%@@%@",self.robotJId,[[STKit sharedInstance] getDomain]] msgType:msgType];
        [_dataSounce addObject:msg];
        [_tableView reloadData];
        [self scrollToBottomWithCheck:YES];
        [self addImageToImageList];
        msg = [[STKit sharedInstance] sendMessage:message ToPublicNumberId:self.robotJId WithMsgId:msg.messageId WithMsgType:msgType];
    } else {
        [[STKit sharedInstance] sendMessage:message ToPublicNumberId:self.robotJId WithMsgId:[QIMUUIDTools UUID] WithMsgType:msgType];
    }
    
}

- (void)sendTyping{
}

- (void)sendText:(NSString *)text{
    
    NSString *regulaStr = @"\\[[^\\[\\]]*\\]";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSArray *arrayOfAllMatches = [regex matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    NSString * tempText = nil;
    NSString * matchText = text;
    for (IMTextBarInputItem * item in _textBar.inputItems) {
        if (item.type == IMTextBarInputItemTypeEmotion) {
            tempText = item.dispalyStr;
            QIMVerboseLog(@"----- %@",tempText);
            if ([tempText hasPrefix:@"["] && tempText.length > 1) {
                tempText = [tempText substringFromIndex:1];
            }
            if ([tempText hasSuffix:@"]"] && tempText.length > 1) {
                tempText = [tempText substringToIndex:tempText.length - 1];
            }
            NSString *shortCut = [[QIMEmotionManager sharedInstance] getEmotionShortCutForTipName:tempText withPackageId:item.emotionPKId];
            if (shortCut) {
                text = [text stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"[%@]",tempText] withString:[NSString stringWithFormat:@"[obj type=\"%@\" value=\"%@\" width=%@ height=0 ]", @"emoticon",[NSString stringWithFormat:@"[%@]",shortCut],item.emotionPKId]];
            }
        }
    }
    
    if ([text length] > 0) {
       STMsgModel *msg = nil;
        
        text = [[QIMEmotionManager sharedInstance]  decodeHtmlUrlForText:text];
        
        msg = [[STKit sharedInstance] createPublicNumberMessageWithMsg:text extenddInfo:nil publicNumberId:self.robotJId msgType:PublicNumberMsgType_Text];
        [_dataSounce addObject:msg];
        [_tableView reloadData];
        [self scrollToBottomWithCheck:YES];
        [self addImageToImageList];
        msg = [[STKit sharedInstance] sendMessage:msg.message ToPublicNumberId:self.robotJId WithMsgId:msg.messageId WithMsgType:msg.messageType];
    }
}
 

- (void)emptyText:(NSString *)text{
}

- (void)sendImageUrl:(NSString *)imageUrl {
    
    [[self view] setFrame:_rootViewFrame];
    
    if ([imageUrl length] > 0) {
     
    }
}

- (void)sendImageData:(NSData *)imageData{
    if (imageData) {
        [self getStringFromAttributedString:imageData];
    }
}

- (void)setKeyBoardHeight:(CGFloat)height WithScrollToBottom:(BOOL)flag{
    
    CGFloat animaDuration = 0.2;
    
    CGRect frame = _tableViewFrame;
    frame.origin.y -= height;
    [UIView animateWithDuration:animaDuration animations:^{
        [_tableView setFrame:frame];
        if (_tableView.contentSize.height - _tableView.tableHeaderView.frame.size.height + 10 < _tableView.frame.size.height && height > 0) {
            if (_tableView.contentSize.height  - _tableView.tableHeaderView.frame.size.height + 10 < _tableViewFrame.size.height -  height) {
                UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, height + 10)];
                [_tableView setTableHeaderView:headerView];
            } else {
                UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, _tableView.frame.size.height - (_tableView.contentSize.height - _tableView.tableHeaderView.frame.size.height + 10 ) + 10)];
                [_tableView setTableHeaderView:headerView];
            }
        } else {
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
            [_tableView setTableHeaderView:headerView];
            if (flag) {
                [self scrollToBottomWithCheck:NO];
            }
        }
    }];
}

#pragma mark - table view data sounce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [[QIMEmotionSpirits sharedInstance] setDataCount:(int)_dataSounce.count];
    return _dataSounce.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= _dataSounce.count) {
        return 0;
    }
    id temp = [_dataSounce objectAtIndex:indexPath.row];
    
    if ([temp isKindOfClass:[NSString class]]) {
        return [[[STKit sharedInstance] getRegisterMsgCellClassForMessageType:QIMMessageType_Time] getCellHeightWithMessage:temp chatType:ChatType_SingleChat];
    } else {
        
       STMsgModel *message = temp;
        switch ((int)message.messageType) {
            case QIMMessageType_Text:
            case QIMMessageType_Image:
            {
                QIMTextContainer *textContaner = [QIMMessageParser textContainerForMessage:message];
                return [textContaner getHeightWithFramesetter:nil width:textContaner.textWidth] + 30;
            }
                break;
            case PublicNumberMsgType_RichText:
            {
                return [QIMPNRichTextCell getCellHeightByContent:message.message];
            }
                break;
            case PublicNumberMsgType_ActionRichText:
            {
                return [QIMPNActionRichTextCell getCellHeightByContent:message.message];
            }
                break;
            case PublicNumberMsgType_Notice:
            {
                return [QIMPublicNumberNoticeCell getCellHeightByContent:message.message];
            }
                break;
            case PublicNumberMsgType_OrderNotify:
            {
                return [QIMPublicNumberOrderMsgCell getCellHeightByContent:message.message];
            }
                break;
            case QIMMessageType_Consult:
            {
                return [QIMOpenPlatformCell getCellHeightWithMessage:message];
            }
                break;
            default:
            {
                Class someClass = [[STKit sharedInstance] getRegisterMsgCellClassForMessageType:message.messageType];
                if (someClass && message.messageType != 6) {
                    CGFloat height = [someClass getCellHeightWithMessage:temp chatType:ChatType_SingleChat];
                    return height;
                } else {
                    QIMTextContainer *textContaner = [QIMMessageParser textContainerForMessage:message];
                    return [textContaner getHeightWithFramesetter:nil width:textContaner.textWidth] + 30;
                }
            }
                break;
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > _dataSounce.count - 1) {
        return [[UITableViewCell alloc] init];
    }
    id temp = [_dataSounce objectAtIndex:indexPath.row];
   STMsgModel *message = temp;
    switch ((int)message.messageType) {
            
        case QIMMessageType_Text:
        {
            static NSString *cellIdentifier = @"cell text";
            QIMSingleChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = [[QIMSingleChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                [cell setFrameWidth:self.view.frame.size.width];
                [cell setDelegate:self];
            }
            [cell setMessage:message];
            
            [cell refreshUI];
            return cell;
        }
            break;
        case QIMMessageType_Voice:
        {
            static NSString *cellIdentifier = @"cell voice";
            QIMSingleChatVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[QIMSingleChatVoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                [cell setFrameWidth:self.view.frame.size.width];
                [cell setDelegate:self];
            }
            [cell setMessage:message];
            cell.isGroupVoice = NO;
            cell.chatId = self.robotJId;
            [cell refreshUI];
            return cell;
        }
            break;
        case PublicNumberMsgType_RichText: {
            static NSString *cellIdentifier = @"Cell Rich Text";
            QIMPNRichTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[QIMPNRichTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                [cell setDelegate:self];
            }
            [cell setContent:message.message];
            [cell refreshUI];
            return cell;
        }
            break;
        case PublicNumberMsgType_ActionRichText:{
            static NSString *cellIdentifier = @"Cell Action Rich Text";
            QIMPNActionRichTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[QIMPNActionRichTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                [cell setDelegate:self];
            }
            [cell setContent:message.message];
            [cell refreshUI];
            return cell;
        }
            break;
        case PublicNumberMsgType_Notice:{
            static NSString *cellIdentifier = @"Cell Notice ";
            QIMPublicNumberNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[QIMPublicNumberNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                [cell setDelegate:self];
            }
            [cell setContent:message.message];
            [cell refreshUI];
            return cell;
        }
            break;
        case PublicNumberMsgType_OrderNotify:{
            static NSString *cellIdentifier = @"Cell Order Notify ";
            QIMPublicNumberOrderMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[QIMPublicNumberOrderMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                [cell setDelegate:self];
            }
            [cell setMessage:message];
            [cell refreshUI];
            return cell;
        }
            break;
        case QIMMessageType_Consult:
        {
            NSString *cellIdentifier = [NSString stringWithFormat:@"Cell OpenPlatform"];
            QIMOpenPlatformCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[QIMOpenPlatformCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                [cell setDelegate:self];
            }
            if (message.extendInformation.length > 0) {
                message.message = message.extendInformation;
            }
            [cell setMessage:message];
            [cell refreshUI];
            return cell;
        }
            break;
        default:
        {
            Class someClass = [[STKit sharedInstance] getRegisterMsgCellClassForMessageType:message.messageType];
            if (someClass && message.messageType != 6) {
                NSString *cellIdentifier = [NSString stringWithFormat:@"Cell %d",message.messageType];
                STMsgBaloonBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [[someClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    [cell setFrameWidth:_tableView.width];
                    cell.chatType = ChatType_SingleChat;
                    cell.delegate = self;
                }
                [cell setOwerViewController:self];
                [cell setMessage:message];
                [cell refreshUI];
                return cell;
            } else {
                static NSString *cellIdentifier = @"cell text";
                QIMSingleChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [[QIMSingleChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    [cell setFrameWidth:self.view.frame.size.width];
                    [cell setDelegate:self];
                }
                [cell setMessage:message];
                [cell refreshUI];
                return cell;
            }
        }
            break;
    }
    
}

#pragma mark - Cell Delegate
- (void)hiddenQDLoadingView{
    [_qdLoadingView removeFromSuperview];
}

- (void)updateQDLoadingView{
    if (_qdSeconds <= 0) {
        [_qdLoadingView setInfoStr:@"已分配给他人进行回复。"];
        [self performSelector:@selector(hiddenQDLoadingView) withObject:nil afterDelay:1.5];
    } else {
        [_qdLoadingView setInfoStr:[NSString stringWithFormat:@"正在进行抢答，筛选中... \r预计剩余时间：%d秒",_qdSeconds]];
        _qdSeconds--;
        [self performSelector:@selector(updateQDLoadingView) withObject:nil afterDelay:1];
    }
}

- (void)openPlatformRequest:(NSString *)urlStr ForDealId:(NSString *)dealId{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *temp = [urlStr stringByAppendingFormat:@"&qchat_id=%@",[[STKit sharedInstance] getLastJid]];
        [[STKit sharedInstance] sendTPGetRequestWithUrl:[temp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] withSuccessCallBack:^(NSData *responseData) {
            NSDictionary *resultDic = [[QIMJSONSerializer sharedInstance] deserializeObject:responseData error:nil];
            BOOL isSuccess = [[resultDic objectForKey:@"ret"] boolValue];
            if (isSuccess) {
                
            } else {
                NSString *errorMsg = [resultDic objectForKey:@"error_msg"];
                [_qdLoadingView setInfoStr:errorMsg];
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateQDLoadingView) object:nil];
                [self performSelector:@selector(hiddenQDLoadingView) withObject:nil afterDelay:1.5];
                int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
                switch (errorCode) {
                    case 5007:
                        [[STKit sharedInstance] setDealId:dealId ForState:QDDealState_Faild];
                        break;
                    case 5008:
                        [[STKit sharedInstance] setDealId:dealId ForState:QDDealState_TimeOut];
                        break;
                    default:
                        break;
                }
                [_tableView reloadData];
            }
        } withFailedCallBack:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_qdLoadingView setInfoStr:@"请求异常，抢单失败！"];
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateQDLoadingView) object:nil];
                [self performSelector:@selector(hiddenQDLoadingView) withObject:nil afterDelay:1.5];
            });
        }];
    });
}

- (void)QIMOpenPlatformCellClick:(QIMOpenPlatformCell *)openPlatformCel{
    NSDictionary *msgDic = [[QIMJSONSerializer sharedInstance] deserializeObject:openPlatformCel.message.message error:nil];
    int timeout = [[msgDic objectForKey:@"timeout"] intValue];
    NSString *dealurl = [msgDic objectForKey:@"dealurl"];
    if (dealurl.length > 0){
        [self openPlatformRequest:dealurl ForDealId:[msgDic objectForKey:@"dealid"]];
        _qdSeconds = timeout > 0?timeout:20;
        _qdLoadingView = [[QDLoadingView alloc] initWithFrame:_tableView.frame];
        [_qdLoadingView setInfoStr:[NSString stringWithFormat:@"正在进行抢答，筛选中... \r预计剩余时间：%d秒",_qdSeconds]];
        [self.view addSubview:_qdLoadingView];
        [_qdLoadingView showLoadingView];
        _qdSeconds--;
        [self performSelector:@selector(updateQDLoadingView) withObject:nil afterDelay:1];
    }
}

- (void)openWebUrl:(NSString *)url{
    QIMWebView *webVC = [[QIMWebView alloc] init];
    [webVC setUrl:url];
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)processEvent:(int)event withMessage:(id)message {
    if (event == MA_Repeater) {
        
        QIMContactSelectionViewController *controller = [[QIMContactSelectionViewController alloc] init];
        QIMNavController *nav = [[QIMNavController alloc] initWithRootViewController:controller];
        [controller setMessage:message];
        [[self navigationController] presentViewController:nav animated:YES completion:^{
            
        }];
        
        //        [[self navigationController] pushViewController:controller animated:YES];
    }else if (event == MA_Delete){
        for (STMsgModel * msg in _dataSounce) {
            if ([msg.messageId isEqualToString:[(STMsgModel *)message messageId]]) {
                NSInteger index = [_dataSounce indexOfObject:msg];
                [_dataSounce removeObject:msg];
                [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                [[STKit sharedInstance] deleteMsg:message ByJid:self.robotJId];
                break;
            }
        }
        
    }else if (event == MA_ToWithdraw){
        for (STMsgModel * msg in _dataSounce) {
            if ([msg.messageId isEqualToString:[(STMsgModel *)message messageId]]) {
                NSInteger index = [_dataSounce indexOfObject:msg];
                //                [_dataSounce removeObject:msg];
                //                [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                [(STMsgModel *)message setMessageType:QIMMessageType_Revoke];
                [_dataSounce replaceObjectAtIndex:index withObject:message];
                [[STKit sharedInstance] updateMsg:message ByJid:self.robotJId];
                [_tableView reloadData];
                
                //                NSString *jid = [infoDic objectForKey:@"fromId"];
                //                NSString *msgId = [infoDic objectForKey:@"messageId"];
                //                NSString *msg = [infoDic objectForKey:@"message"];
                NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
                [dicInfo setObject:[(STMsgModel *)message from] forKey:@"fromId"];
                [dicInfo setObject:[(STMsgModel *)message messageId] forKey:@"messageId"];
                [dicInfo setObject:[(STMsgModel *)message message] forKey:@"message"];
                NSString *msgInfo = [[QIMJSONSerializer sharedInstance] serializeObject:dicInfo];
                
                [[STKit sharedInstance] revokeMessageWithMessageId:[(STMsgModel *)message messageId] message:msgInfo ToJid:self.robotJId];
                break;
            }
        }
    } else if (event == MA_Favorite) {
        
        for (STMsgModel *msg in _dataSounce) {
            
            if ([msg.messageId isEqualToString:[(STMsgModel *)message messageId]]) {
                
                [[QIMMyFavoitesManager sharedMyFavoritesManager] setMyFavoritesArrayWithMsg:message];
                
                break;
            }
        }
    }
}

static CGPoint tableOffsetPoint;

#pragma mark - QIMMWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(QIMMWPhotoBrowser *)photoBrowser
{
    return _photos.count;
}

- (id <QIMMWPhoto>)photoBrowser:(QIMMWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index > _photos.count)
        return nil;
    
    NSString *imagePath;
    for (QIMDisplayImage *image in [_photos allValues]) {
        if (image.imageIndex == index) {
            imagePath = image.imagePath;
        }
    }
    if ([imagePath qim_hasPrefixHttpHeader]) {
        NSURL *url = [NSURL URLWithString:[imagePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        return url?[[QIMMWPhoto alloc] initWithURL:url]:nil;
    } else {
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
        if (image == nil) {
            image = [[UIImage alloc] initWithContentsOfFile:kImageDownloadFailImageFileName];
        }
        return image?[[QIMMWPhoto alloc] initWithImage:image]:nil;
    }
}

- (void)photoBrowserDidFinishModalPresentation:(QIMMWPhotoBrowser *)photoBrowser
{
    //界面消失
    [photoBrowser dismissViewControllerAnimated:YES completion:^{
        //tableView 回滚到上次浏览的位置
        [_tableView setContentOffset:tableOffsetPoint animated:YES];
    }];
}

#pragma mark - Action Method

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    CGPoint point = [touch locationInView:self.view];
    if (!CGRectContainsPoint(_textBar.frame, point)) {
        [self.textBar needFirstResponder:NO];
    }
    CGRect frame = _actionBottomView.frame;
    frame.origin.x = 44;
    frame.size.width -= 44;
    if (_currentShowSubActionView && !CGRectContainsPoint(frame, point) && !CGRectContainsPoint(_currentShowSubActionView.frame, point)) { 
        [self hidenSubActionView];
    }
    
//    当点击table空白处时，输入框自动回收
    if (CGRectContainsPoint(_tableView.frame, point) == YES) {
        [_textBar needFirstResponder:NO];
    }
    
    [QIMMenuImageView cancelHighlighted];
    return NO;
}

#pragma mark - UIScrollView的代理函数

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.textBar keyBoardDown];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat h1 = _tableView.contentOffset.y + _tableView.frame.size.height;
    CGFloat h2 =  _tableView.contentSize.height - 250;
    CGFloat tempOffY = (_tableView.contentSize.height - _tableView.frame.size.height);
    if ((  h1 > h2) && tempOffY > 0) {
        [self hidePopView];
    }
}

#pragma mark - MJRefresh 代理
- (void)loadNewPublicNumberMsgList {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *list = [[STKit sharedInstance] getPublicNumberMsgListById:self.robotJId WithLimit:kPageCount WithOffset:(int)_dataSounce.count];
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat offsetY = _tableView.contentSize.height -  _tableView.contentOffset.y;
            NSRange range = NSMakeRange(0, [list count]);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [_dataSounce insertObjects:list atIndexes:indexSet];
            [_tableView reloadData];
            
            _tableView.contentOffset = CGPointMake(0, _tableView.contentSize.height - offsetY - 30);
            //重新获取一次大图展示的数组
            [self addImageToImageList];
            [_tableView.mj_header endRefreshing];
        });
    });
}

- (void)scrollToBottom_tableView {
    if (_dataSounce.count == 0)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataSounce.count - 1 inSection:0];
    //    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        CGFloat offsetY = _tableView.contentSize.height + _tableView.contentInset.bottom - CGRectGetHeight(_tableView.frame);
        if (offsetY < -_tableView.contentInset.top)
            offsetY = -_tableView.contentInset.top;
        [_tableView setContentOffset:CGPointMake(0, offsetY) animated:YES];
    }else {
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

-(void)refreshTableView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSObject cancelPreviousPerformRequestsWithTarget:_tableView
                                                 selector:@selector(reloadData)
                                                   object:nil];
        
        [_tableView performSelector:@selector(reloadData)
                         withObject:nil
                         afterDelay:DEFAULT_DELAY_TIMES];
    });
}

-(NSString*)getStringFromAttributedString:(NSData*)imageData
{
   STMsgModel *  msg = nil; 
    msg = [[STKit sharedInstance] createPublicNumberMessageWithMsg:@"[obj type=\"image\" value=\"imageData\"]" extenddInfo:nil publicNumberId:self.robotJId msgType:PublicNumberMsgType_Text];
     msg.imageData = imageData;
    [_dataSounce addObject:msg];
    [_tableView reloadData];
    [self addImageToImageList];
    [self scrollToBottomWithCheck:YES];
    
    //Mark temp
//    [[QIMKit sharedInstance] uploadFileForData:imageData forMessage:msg withJid:self.robotJId isFile:YES];
    return nil;
}

-(NSString*)getStringFromAttributedSourceString:(NSString *)sourceStr
{
    return [[QIMEmotionManager sharedInstance] decodeHtmlUrlForText:sourceStr];
}

#pragma mark - show pop view

- (void)showPopView {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    if (notificationView == nil) {
        
        notificationView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 110, self.textBar.frame.origin.y - 50, 100, 40)];
        backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        [backImageView setImage:[UIImage qim_imageNamedFromQIMUIKitBundle:@"notificationToast"]];
        [notificationView addSubview:backImageView];
        
        UIImageView *messageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 7, 20, 20)];
        [messageImageView setImage:[UIImage qim_imageNamedFromQIMUIKitBundle:@"notificationToastCommentIcon"]];
        
        [notificationView addSubview:messageImageView];
        if (commentCountLabel == nil) {
            commentCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 70, 20)];
            [commentCountLabel setTextColor:[UIColor whiteColor]];
            [commentCountLabel setText:[NSBundle qim_localizedStringForKey:@"New_Messages_Below"]];
            [commentCountLabel setFont:[UIFont boldSystemFontOfSize:10]];
            [notificationView addSubview:commentCountLabel];
        }
        
        [self.view addSubview:notificationView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewToFoot)];
        [notificationView addGestureRecognizer:tap];
        notificationView.userInteractionEnabled = YES;
        [notificationView setHidden:NO];
        notificationView.alpha = 1.0;
    }
    [notificationView setHidden:NO];
    notificationView.alpha = 1.0;
    [UIView commitAnimations];
}


-(void)hidePopView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    notificationView.alpha = 0.0;
    [UIView commitAnimations];
}


- (void)moveViewToFoot
{
    [self scrollToBottom_tableView];
}

//获取大图展示数组

- (void)addImageToImageList
{
    /*
    [_photos removeAllObjects];
    
    NSInteger imageIndex = 0;
    NSInteger cellIndex  = 0;
    NSArray *tempDataSource = [NSArray arrayWithArray:_dataSounce];
    for (QIMMessageModel *msg in tempDataSource) {
        if (![msg isKindOfClass:[NSString class]]) {
            TextCellCache *cache = [_cellSizeDic objectForKey:msg.messageId];
//            [self updateTextCache:msg.messageId Cache:cache];
            if (cache) {
                if (cache.images.count > 0) {
                    NSString *imagePath = [cache.images firstObject][@"httpUrl"];
                    QIMVerboseLog(@"cache.imagescache.imagescache.imagescache.images%@",cache.images);
                    if (imagePath) {
                        QIMDisplayImage *displayImage = [[QIMDisplayImage alloc] init];
                        displayImage.imagePath       = imagePath;
                        displayImage.imageIndex      = imageIndex;
                        displayImage.cellIndex       = cellIndex;
                        [_photos setObject:displayImage forKey:@(cellIndex)];
                        imageIndex++;
                    }
                }
            }
        }
        cellIndex++;
    }
    */
}

#pragma mark - 语音

- (void)beginDoVoiceRecord
{
    //    _voiceRecordingView.alpha = 0;
    _voiceRecordingView.hidden = NO;
    [_voiceRecordingView beginDoRecord];
}

- (void)updateVoiceViewHeightInVCWithPower:(float)power
{
    [_voiceRecordingView doImageUpdateWithVoicePower:power];
}

- (void)voiceRecordWillFinishedIsTrue:(BOOL)isTrue andCancelByUser:(BOOL)isCancelByUser
{
    [_voiceRecordingView setHidden:YES];
    if (!isTrue && !isCancelByUser) {
        //录音时间太短，出错提示
        [_voiceTimeRemindView setHidden:NO];
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(hiddenQIMVoiceTimeRemindView) userInfo:nil repeats:NO];
        
    }
    [_voiceRecordingView voiceMaybeCancelWithState:0];
}

- (void)hiddenQIMVoiceTimeRemindView
{
    [_voiceTimeRemindView setHidden:YES];
}

- (void)voiceMaybeCancelWithState:(BOOL)ifMaybeCancel
{
    [_voiceRecordingView voiceMaybeCancelWithState:ifMaybeCancel];
}

- (void)sendVoiceWithDuration:(int)duration WithFileName:(NSString *)filename AndFilePath:(NSString *)filepath
{
    [self sendMessage:[NSString stringWithFormat:@"{\"%@\":\"%@\", \"%@\":\"%@\", \"%@\":%@,\"%@\":\"%@\"}", @"HttpUrl",filepath, @"FileName",filename, @"Seconds",[NSNumber numberWithInt:duration], @"filepath",filepath] WithInfo:nil ForMsgType:QIMMessageType_Voice];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == kReSendMsgAlertViewTag) {
        if (buttonIndex == 1) {
            [self processEvent:MA_Delete withMessage:_resendMsg];
        }else if (buttonIndex == 2){
            [self reSendMsg];
        }else{
        }
    }else{
    }
}

@end

