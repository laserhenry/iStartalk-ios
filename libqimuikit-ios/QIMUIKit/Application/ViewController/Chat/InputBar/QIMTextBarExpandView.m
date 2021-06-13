//
//  QIMTextBarExpandView.m
//  qunarChatIphone
//
//  Created by chenjie on 15/7/9.
//
//

#define kItemWidth      54
#define kItemTagFrom    1000
#import "QIMMsgBaseVC.h"
#import "QIMTextBarExpandView.h"
#import "UserLocationViewController.h"
#import "QIMChatVC.h"  
#import "NSBundle+QIMLibrary.h"
#import "UIApplication+QIMApplication.h"
#if __has_include("QIMAutoTracker.h")
#import "QIMAutoTracker.h"
#endif


static NSMutableDictionary *__trdExtendInfoDic = nil;

@interface QIMTextBarExpandView() <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *view;

@end

@implementation QIMTextBarExpandView
{
    UIScrollView            * _mainScrollView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)addItems
{
    if ([[STKit sharedInstance] getMsgTextBarButtonInfoList].count) {
        [[STKit sharedInstance] removeAllExpandItems];
    }
    if (__trdExtendInfoDic == nil) {
        __trdExtendInfoDic = [[NSMutableDictionary alloc] init];
    }
    for (NSDictionary *trdEntendInfo in [[STKit sharedInstance] trdExtendInfo]) {
        NSString *trdEntendId = [trdEntendInfo objectForKey:@"trdextendId"];
        
        int client = [[trdEntendInfo objectForKey:@"client"] intValue];
        int support = [[trdEntendInfo objectForKey:@"support"] intValue];
        int scope = [[trdEntendInfo objectForKey:@"scope"] intValue];
        BOOL hasQchat = client & 1,hasQtalk = client & 2, hasSingle = support & 1,hasGroup = support & 2, hasVirtual = support & 4, hasConsult = support & 8, hasConsultServer = support & 16, hasPublicNumber = support & 32, hasNoMerchant = scope & 1,hasMerchant = scope & 2;
        int type = [[trdEntendInfo objectForKey:@"type"] intValue];
        NSString *title = [trdEntendInfo objectForKey:@"title"];
        [__trdExtendInfoDic setObject:trdEntendInfo forKey:trdEntendId];
        if ([STKit getQIMProjectType] == QIMProjectTypeQChat) {
            BOOL needShowForMerchant = ((hasNoMerchant &&![[STKit sharedInstance] isMerchant])||(hasMerchant &&[[STKit sharedInstance] isMerchant]));
            if (hasSingle && QIMTextBarExpandViewTypeSingle & self.type) {
                [[STKit sharedInstance] addMsgTextBarWithTrdInfo:trdEntendInfo];
            }
            if (hasGroup && QIMTextBarExpandViewTypeGroup & self.type) {
                [[STKit sharedInstance] addMsgTextBarWithTrdInfo:trdEntendInfo];
            }
            if (hasConsult && QIMTextBarExpandViewTypeConsult & self.type) {
                [[STKit sharedInstance] addMsgTextBarWithTrdInfo:trdEntendInfo];
            }
            
            if (needShowForMerchant && hasConsultServer && QIMTextBarExpandViewTypeConsultServer & self.type) {
                [[STKit sharedInstance] addMsgTextBarWithTrdInfo:trdEntendInfo];
            }
            if (hasVirtual && QIMTextBarExpandViewTypeRobot & self.type) {
                [[STKit sharedInstance] addMsgTextBarWithTrdInfo:trdEntendInfo];
            }
        }
        if ([STKit getQIMProjectType] != QIMProjectTypeQChat) {
            if (hasSingle && QIMTextBarExpandViewTypeSingle & self.type) {
                [[STKit sharedInstance] addMsgTextBarWithTrdInfo:trdEntendInfo];
            }
            if (hasGroup && QIMTextBarExpandViewTypeGroup & self.type) {
                [[STKit sharedInstance] addMsgTextBarWithTrdInfo:trdEntendInfo];
            }
            if (hasConsult && QIMTextBarExpandViewTypeConsult & self.type) {
                [[STKit sharedInstance] addMsgTextBarWithTrdInfo:trdEntendInfo];
            }
            if (hasConsultServer && QIMTextBarExpandViewTypeConsultServer & self.type) {
                [[STKit sharedInstance] addMsgTextBarWithTrdInfo:trdEntendInfo];
            }
            if (hasVirtual && QIMTextBarExpandViewTypeRobot & self.type) {
                [[STKit sharedInstance] addMsgTextBarWithTrdInfo:trdEntendInfo];
            }
            
            if (hasPublicNumber && QIMTextBarExpandViewTypePublicNumber & self.type) {
                [[STKit sharedInstance] addMsgTextBarWithTrdInfo:trdEntendInfo];
            }
        }
    }
    if ([[STKit sharedInstance] trdExtendInfo].count <= 0) {
        [self defaultItems];
    }
}

- (void)defaultItems {
    
     [[STKit sharedInstance] addMsgTextBarWithImage:@"aio_icons_pic" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_album"] ForItemId:QIMTextBarExpandViewItem_Photo];
     
     [[STKit sharedInstance] addMsgTextBarWithImage:@"aio_icons_camera" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_camera"] ForItemId:QIMTextBarExpandViewItem_Camera];
    
     if ([STKit getQIMProjectType] == QIMProjectTypeQChat & self.type == (QIMTextBarExpandViewTypeConsultServer)) {
     //快捷回复按钮只有在ConsultServer中展示
         [[STKit sharedInstance] addMsgTextBarWithImage:@"aio_icons_quickReply" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_quick_reply"] ForItemId:QIMTextBarExpandViewItem_QuickReply];
     }
#if __has_include("QIMWebRTCMeetingClient.h")
        if ([STKit getQIMProjectType] != QIMProjectTypeQChat) {

         if (self.type & QIMTextBarExpandViewTypeSingle) {
             [[STKit sharedInstance] addMsgTextBarWithImage:@"aio_icons_videoCall" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_videoCall"] ForItemId:QIMTextBarExpandViewItem_VideoCall];
             [[STKit sharedInstance] addMsgTextBarWithImage:@"aio_icons_encryptchat" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_encryptchat"] ForItemId:QIMTextBarExpandViewItem_Encryptchat];
         }
         if (self.type & QIMTextBarExpandViewTypeGroup) {
             [[STKit sharedInstance] addMsgTextBarWithImage:@"aio_icons_videoCall" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_videoCall"] ForItemId:QIMTextBarExpandViewItem_VideoCall];
         }
    }
     #endif
    [[STKit sharedInstance] addMsgTextBarWithImage:@"aio_icons_location" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_position"] ForItemId:QIMTextBarExpandViewItem_Location];
    
     if (([STKit getQIMProjectType] == QIMProjectTypeQTalk) && (self.type & (QIMTextBarExpandViewTypeNomal | QIMTextBarExpandViewTypeSingle | QIMTextBarExpandViewTypeGroup))) {
     //        [[QIMKit sharedInstance] addMsgTextBarWithImage:@"iconfont-fire" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_burn_after_reading"] ForItemType:QIMTextBarExpandViewItemType_BurnAfterReading pushVC:nil];
     }
     if ([STKit getQIMProjectType] == QIMProjectTypeQChat) {
         if (self.type & (QIMTextBarExpandViewTypeConsultServer)) {
         //转移会话按钮只有在ConsultServer中展示
             [[STKit sharedInstance] addMsgTextBarWithImage:@"aio_icons_transfer" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_move_chat"] ForItemId:QIMTextBarExpandViewItem_ChatTransfer];
         }
         [[STKit sharedInstance] addMsgTextBarWithImage:@"aio_icons_sendProduct" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_send_product"] ForItemId:QIMTextBarExpandViewItem_SendProduct];
     }
    [[STKit sharedInstance] addMsgTextBarWithImage:@"aio_icons_red_pack" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_red_package"] ForItemId:QIMTextBarExpandViewItem_RedPack];
    
     if ([STKit getQIMProjectType] != QIMProjectTypeQChat) {
         [[STKit sharedInstance] addMsgTextBarWithImage:@"aa_collection_icon" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_aa"] ForItemId:QIMTextBarExpandViewItem_AACollection];
         [[STKit sharedInstance] addMsgTextBarWithImage:@"aio_icons_share_nameplate" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_share_card"] ForItemId:QIMTextBarExpandViewItem_ShareCard];
     }
    [[STKit sharedInstance] addMsgTextBarWithImage:@"aio_icons_folder" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_file"] ForItemId:QIMTextBarExpandViewItem_MyFiles];

     //ios 的发活动去掉吧，后台都快没了 by wz.wang 2017-12-06 15:42
     if (self.type & QIMTextBarExpandViewTypeGroup) {
         [[STKit sharedInstance] addMsgTextBarWithImage:@"aio_icons_group_activity" WithTitle:[NSBundle qim_localizedStringForKey:@"textbar_button_activity"] ForItemId:QIMTextBarExpandViewItem_SendActivity];
     }
}

- (void)displayItems
{
    NSInteger i = 0;
    NSInteger page = 0;
    float  space = (self.width - kItemWidth * 4) / 5;
    
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_mainScrollView];
    }else{
        for (UIView * view in _mainScrollView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    NSArray * items = [[STKit sharedInstance] getMsgTextBarButtonInfoList];
    
    for (NSDictionary * itemDic in items) {
        NSString *trId = [itemDic objectForKey:@"trdextendId"];
        UIImageView *locationButton = [[UIImageView alloc] initWithFrame:CGRectMake(page * _mainScrollView.width + (space + kItemWidth) * (i % 4) + space, (i / 4) * (kItemWidth + 10 + 25) + 10, kItemWidth, kItemWidth)];
        NSString *icon = [itemDic objectForKey:@"icon"];
        [locationButton setAccessibilityIdentifier:trId];
        UIImage *defaultIcon = [UIImage qim_imageNamedFromQIMUIKitBundle:@"textbar_common_icon"];
        if (icon.length > 0) {
            [locationButton qim_setImageWithURL:[NSURL URLWithString:[icon stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:defaultIcon];
        } else {
            NSString *imageName = [itemDic objectForKey:@"ImageName"];
            [locationButton setImage:[UIImage qim_imageNamedFromQIMUIKitBundle:imageName]];
        }
        [locationButton setUserInteractionEnabled:YES];
        [_mainScrollView addSubview:locationButton];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(page * _mainScrollView.width + (space + kItemWidth) * (i % 4) + space - 10, locationButton.bottom + 5, kItemWidth + 20, 20)];
        titleLabel.text = [itemDic objectForKey:@"title"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = [UIColor qim_colorWithHex:0x666666];
        [titleLabel setUserInteractionEnabled:YES];
        [titleLabel setAccessibilityIdentifier:trId];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemBtnHandle:)];
        [locationButton setAccessibilityIdentifier:trId];
        [locationButton addGestureRecognizer:tap];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemBtnHandle:)];
        [titleLabel setAccessibilityIdentifier:trId];
        [titleLabel addGestureRecognizer:tap2];
        [_mainScrollView addSubview:titleLabel];
        page = page + (i + 1) / (2 * 4);
        i = (i + 1) % (2 * 4);
    }
    _mainScrollView.contentSize = CGSizeMake((ceilf((float)(items.count) / 8.0) * _mainScrollView.width), _mainScrollView.height);
}


- (void)itemBtnHandle:(UITapGestureRecognizer *)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UIView *view = (UIView*) tap.view;
    NSString *sendId = [view accessibilityIdentifier];
    NSDictionary *trdDic = [[STKit sharedInstance] getExpandItemsForTrdextendId:sendId];
    NSString *trdId = [trdDic objectForKey:@"trdextendId"];
    NSString *trdName = [trdDic objectForKey:@"title"];

    NSArray *textBarOpenIds = @[QIMTextBarExpandViewItem_Photo, QIMTextBarExpandViewItem_Camera, QIMTextBarExpandViewItem_QuickReply];
#if __has_include("QIMAutoTracker.h")
    [[QIMAutoTrackerManager sharedInstance] addACTTrackerDataWithEventId:trdId withDescription:trdName?trdName:trdId];
#endif
    if ([textBarOpenIds containsObject:trdId] && self.delegate && [self.delegate respondsToSelector:@selector(didClickExpandItemForTrdextendId:)]) {
        //这里由TextBar打开
        [self.delegate didClickExpandItemForTrdextendId:trdId];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kExpandViewItemHandleNotification object:trdId];
        });
    }
}

#pragma mark - QIMMsgBaseVCDelegate

-(void)sendMessage:(NSString *)message WithInfo:(NSString *)info ForMsgType:(int)msgType
{
    
    //Comment by lilulucas.li 10.18
//    [(QIMChatVC *)self.parentVC sendMessage:message WithInfo:info ForMsgType:msgType];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger pageIndex = offsetX / self.width;
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidScrollToIndex:)]) {
        
        [self.delegate scrollViewDidScrollToIndex:pageIndex];
    }
}

@end
