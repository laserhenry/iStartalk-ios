//
//  QTalk.m
//  qunarChatIphone
//
//  Created by xueping on 15/7/9.
//
//

#import "StarTalk.h"
#import "QIMKitPublicHeader.h"
#import "QIMIconFont.h"
#import "QIMImageManager.h"
#import "QIMEmotionManager.h"
#if __has_include("QIMNoteManager.h")
#import "QIMNoteManager.h"
#endif

static StarTalk *__global_qtalk = nil;

@implementation StarTalk

+ (void)load {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didfinishNSNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __global_qtalk = [[StarTalk alloc] init];
    });
    return __global_qtalk;
}

+ (void)didfinishNSNotification:(NSNotification *)notify {
    [[StarTalk sharedInstance] initConfiguration];
}

- (void)initConfiguration {
    //初始化字体集
    [QIMIconFont setFontName:@"QTalk-QChat"];
    
    //初始化图片缓存地址
    [[QIMImageManager sharedInstance] initWithQIMImageCacheNamespace:@"QIMImageCache"];

    // 初始化表情
    [QIMEmotionManager sharedInstance];
    // 初始化管理类
    [STKit sharedInstance];
#if __has_include("QIMNoteManager.h")
    //初始化QIMNote
    [QIMNoteManager sharedInstance];
#endif
    
    // 注册支持的消息类型
    // 文本消息
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMDefalutMessageCell" ForMessageType:QIMMessageType_Text];
    [[STKit sharedInstance] setMsgShowText:@"[文本]" ForMessageType:QIMMessageType_Text];
    // 图片
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMSingleChatImageCell" ForMessageType:QIMMessageType_Image];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"[Photo]"] ForMessageType:QIMMessageType_Image];
    [[STKit sharedInstance] setMsgShowText:@"[表情]" ForMessageType:QIMMessageType_ImageNew];

    // 语音
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMSingleChatVoiceCell" ForMessageType:QIMMessageType_Voice];
    [[STKit sharedInstance] setMsgShowText:@"[语音]" ForMessageType:QIMMessageType_Voice];
    // 文件
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMFileCell" ForMessageType:QIMMessageType_File];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"[File]"] ForMessageType:QIMMessageType_File];
    // 时间戳
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMSingleChatTimestampCell" ForMessageType:QIMMessageType_Time];
    // Topic
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMGroupTopicCell" ForMessageType:QIMMessageType_Topic];
    [[STKit sharedInstance] setMsgShowText:@"[群公告]" ForMessageType:QIMMessageType_Topic];
    // Location Share 
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMLocationShareMsgCell" ForMessageType:QIMMessageType_LocalShare];
    // card Share
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMCardShareMsgCell" ForMessageType:QIMMessageType_CardShare];
    [[STKit sharedInstance] setMsgShowText:@"[位置分享]" ForMessageType:QIMMessageType_LocalShare];
    
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMShareLocationChatCell" ForMessageType:QIMMessageType_shareLocation];
    [[STKit sharedInstance] setMsgShowText:@"[位置共享]" ForMessageType:QIMMessageType_shareLocation];
    
    // Video
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMVideoMsgCell" ForMessageType:QIMMessageType_SmallVideo];
    [[STKit sharedInstance] setMsgShowText:@"[视频]" ForMessageType:QIMMessageType_SmallVideo];
    // Source Code
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMSourceCodeCell" ForMessageType:QIMMessageType_SourceCode];
    [[STKit sharedInstance] setMsgShowText:@"[代码段]" ForMessageType:QIMMessageType_SourceCode];
//    QIMMessageType_Markdown
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMSourceCodeCell" ForMessageType:QIMMessageType_Markdown];
    [[STKit sharedInstance] setMsgShowText:@"[Markdown]" ForMessageType:QIMMessageType_Markdown];
    
    // red pack
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMRedPackCell" ForMessageType:QIMMessageType_RedPack];
    [[STKit sharedInstance] setMsgShowText:@"[红包]" ForMessageType:QIMMessageType_RedPack];
    
    // red pack desc
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMRedPackDescCell" ForMessageType:QIMMessageType_RedPackInfo];
    [[STKit sharedInstance] setMsgShowText:@"[红包]" ForMessageType:QIMMessageType_RedPackInfo];
    
    //预测对赌
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMForecastCell" ForMessageType:QIMMessageType_Forecast];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Prediction_tip"] ForMessageType:QIMMessageType_Forecast];
    
    //抢单消息
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Order_Taking_tip"] ForMessageType:MessageType_C2BGrabSingle];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Order_Taking_tip"] ForMessageType:MessageType_QCZhongbao];

    
    // red pack desc
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMRedPackDescCell" ForMessageType:QIMMessageType_RedPackInfo];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"redpack_tip"] ForMessageType:QIMMessageType_RedPackInfo];
    
    // AA收款
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMAACollectionCell" ForMessageType:QIMMessageType_AA];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Split_Bill_tip"] ForMessageType:QIMMessageType_AA];
    
    // AA收款 desc
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMAACollectionDescCell" ForMessageType:QIMMessageType_AAInfo];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Split_Bill_tip"] ForMessageType:QIMMessageType_AAInfo];
    
    // 产品信息
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMProductInfoCell" ForMessageType:QIMMessageType_product];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Product_Information_tip"] ForMessageType:QIMMessageType_product];
    
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMExtensibleProductCell" ForMessageType:QIMMessageType_ExProduct];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Product_Information_tip"] ForMessageType:QIMMessageType_ExProduct];
    
    // 活动
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMActivityCell" ForMessageType:QIMMessageType_activity];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Event_tip"] ForMessageType:QIMMessageType_activity];
    
    // 撤回消息
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMSingleChatTimestampCell" ForMessageType:QIMMessageType_Revoke];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"recalled_message"] ForMessageType:QIMMessageType_Revoke];
    
#if __has_include("QIMWebRTCClient.h")
    //语音聊天
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMRTCChatCell" ForMessageType:QIMMessageType_WebRTC_Audio];
    //视频聊天
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMRTCChatCell" ForMessageType:QIMMessageType_WebRTC_Vedio];
    
    [[STKit sharedInstance] setMsgShowText:@"[语音聊天]" ForMessageType:QIMMessageType_WebRTC_Audio];
    
    [[STKit sharedInstance] setMsgShowText:@"[视频聊天]" ForMessageType:QIMMessageType_WebRTC_Vedio];
    
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Voice_Call_tip"] ForMessageType:QIMWebRTC_MsgType_Audio];
    
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Video_Call_tip"] ForMessageType:QIMWebRTC_MsgType_Video];
#endif
#if __has_include("QIMWebRTCClient.h")
    //视频会议
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMRTCChatCell" ForMessageType:QIMMessageTypeWebRtcMsgTypeVideoMeeting];


    [[STKit sharedInstance] setMsgShowText:@"[视频会议]" ForMessageType:QIMMessageTypeWebRtcMsgTypeVideoMeeting];
    
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMRTCChatCell" ForMessageType:QIMMessageTypeWebRtcMsgTypeVideoGroup];
    [[STKit sharedInstance] setMsgShowText:@"[视频会议]" ForMessageType:QIMMessageTypeWebRtcMsgTypeVideoGroup];
    
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Video_Conference_tip"] ForMessageType:QIMMessageTypeWebRtcMsgTypeVideoMeeting];
    
#endif
    // 窗口抖动
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMShockMsgCell" ForMessageType:QIMMessageType_Shock];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Shake_Screen_tip"] ForMessageType:QIMMessageType_Shock];

    //问题列表
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMRobotQuestionCell" ForMessageType:QIMMessageTypeRobotQuestionList];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Problem_List_tip"] ForMessageType:QIMMessageTypeRobotQuestionList];
    
    //机器人答案
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMRobotAnswerCell" ForMessageType:QIMMessageType_RobotAnswer];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Robot_Answer_tip"] ForMessageType:QIMMessageType_RobotAnswer];
    
    // 第三方通用Cell
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMCommonTrdInfoCell" ForMessageType:QIMMessageType_CommonTrdInfo];
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMCommonTrdInfoCell" ForMessageType:QIMMessageType_CommonTrdInfoPer];
    //加密消息Cell
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMEncryptChatCell" ForMessageType:QIMMessageType_Encrypt];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Encrypted_Message_tip"] ForMessageType:QIMMessageType_Encrypt];
    
    //会议室提醒
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMMeetingRemindCell" ForMessageType:QIMMessageTypeMeetingRemind];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Meeting_Room_Notification"] ForMessageType:QIMMessageTypeMeetingRemind];
    
    //驼圈提醒
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMWorkMomentRemindCell" ForMessageType:QIMMessageTypeWorkMomentRemind];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"Moments_Notification"] ForMessageType:QIMMessageTypeWorkMomentRemind];
    
    //勋章提醒
    [[STKit sharedInstance] registerMsgCellClassName:@"QIMUserMedalRemindCell" ForMessageType:QIMMessageTypeUserMedalRemind];
    [[STKit sharedInstance] setMsgShowText:@"勋章提醒" ForMessageType:QIMMessageTypeUserMedalRemind];

    [[STKit sharedInstance] setMsgShowText:@"收到一条消息" ForMessageType:QIMMessageType_GroupNotify];
    [[STKit sharedInstance] setMsgShowText:[NSBundle qim_localizedStringForKey:@"received_message"] ForMessageType:QIMMessageType_GroupNotify];
}

@end
