//
//  QIMKit+QIMNavConfig.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMNavConfig)

- (NSString *)qimNav_HttpHost;
- (NSString *)qimNav_TakeSmsUrl;
- (NSString *)qimNav_CheckSmsUrl;
- (NSString *)qimNav_NewHttpUrl;
- (NSString *)qimNav_WikiUrl;
- (NSString *)qimNav_TokenSmsUrl;
- (NSString *)qimNav_Javaurl;
- (NSString *)qimNav_Pubkey;
- (NSString *)qimNav_Domain;
- (QTLoginType)qimNav_LoginType; //登录方式
- (NSString *)qimNav_XmppHost;
- (NSString *)qimNav_LeaderUrl;

- (NSString *)qimNav_Mobileurl;
- (NSString *)qimNav_resetPwdUrl;

- (NSString *)qimNav_webAppUrl; //注册登陆
- (NSString *)qimNav_getManagerAppUrl;//管理页面
- (NSString *)qimNav_AppWebHostUrl; //web页host地址
/**
 文件服务HTTP接口 Host
 
 @return 返回接口Host
 */
- (NSString *)qimNav_InnerFileHttpHost;
- (NSString *)qimNav_Port;  //xmpp端口
- (NSString *)qimNav_ProtobufPort;   //Pb端口
- (NSString *)qimNav_ShareUrl;  //分享聊天记录url
- (NSString *)qimNav_DomainHost;    //种Cookie的domain

//hosts
- (NSString *)qimNav_HashHosts;
- (NSString *)qimNav_QCHost;

/**
 获取广告内容
 
 @return 返回广告数据
 */
- (NSArray *)qimNav_AdItems;

/**
 ad sec
 
 @return ad sec
 */
- (int)qimNav_AdSec;

/**
 是否展示广告
 
 @return 返回开关值
 */
- (BOOL)qimNav_AdShown;

/**
 is ad carousel
 
 @return 返回bool值
 */
- (BOOL)qimNav_AdCarousel;

/**
 延迟
 
 @return 延迟
 */
- (int)qimNav_AdCarouselDelay;

/**
 是否允许跳过
 
 @return 返回是否允许跳过
 */
- (BOOL)qimNav_AdAllowSkip;
- (long long)qimNav_AdInterval;   //两次广告的间隔之间

/**
 获取本地已经缓存的导航配置
 */
- (NSArray *)qimNav_getLocalNavServerConfigs;

/**
 跳过提示
 
 @return 返回跳过提示语
 */
- (NSString *)qimNav_AdSkipTips;

//imConfig
- (BOOL)qimNav_ShowOA;                //展示OA
- (BOOL)qimNav_ShowOrganizational;    //展示组织架构
- (NSString *)qimNav_Email;
- (NSString *)qimNav_UploadLog;     //上报日志
- (BOOL)qimNav_isToC;

//ability
- (NSString *)qimNav_GetPushState;
- (NSString *)qimNav_SetPushState;
- (NSString *)qimNav_QCloudHost;
- (NSString *)qimNav_Resetpwd;
- (NSString *)qimNav_Mconfig;
- (NSString *)qimNav_SearchUrl;
- (NSString *)qimNav_New_SearchUrl;
- (NSString *)qimNav_QcGrabOrder;
- (NSString *)qimNav_QcOrderManager;
- (BOOL)qimNav_NewPush;
- (BOOL)qimNav_Showmsgstat;

//RN Ability
- (BOOL)qimNav_RNMineView;      //展示RNMineView
- (BOOL)qimNav_RNAboutView;     //展示RNAboutView
- (BOOL)qimNav_RNGroupCardView; //展示RNGroupCardView
- (BOOL)qimNav_RNContactView;   //展示RNContactView
- (BOOL)qimNav_RNSettingView;   //展示RNSettingView
- (BOOL)qimNav_RNUserCardView;  //展示RNUserCardView
- (BOOL)qimNav_RNGroupListView;   //展示RN 群组列表
- (BOOL)qimNav_RNPublicNumberListView;    //展示RN 公众号列表

- (void)qimNav_setRNMineView:(BOOL)showFlag;      //设置展示RNMineView
- (void)qimNav_setRNAboutView:(BOOL)showFlag;     //设置展示RNAboutView
- (void)qimNav_setRNGroupCardView:(BOOL)showFlag; //设置展示RNGroupCardView
- (void)qimNav_setRNContactView:(BOOL)showFlag;   //设置展示RNContactView
- (void)qimNav_setRNSettingView:(BOOL)showFlag;   //设置展示RNSettingView
- (void)qimNav_setRNUserCardView:(BOOL)showFlag;  //设置展示RNUserCardView
- (void)qimNav_setRNGroupListView:(BOOL)showFlag;   //设置展示RN 群组列表
- (void)qimNav_setRNPublicNumberListView:(BOOL)showFlag;    //设置展示RN 公众号列表

//OPS
- (NSString *)qimNav_OpsHost;

//Video
- (NSString *)qimNav_Group_room_host;
- (NSString *)qimNav_Signal_host;
- (NSString *)qimNav_WssHost;
- (NSString *)qimNav_VideoApiHost;
- (NSString *)qimNav_VideoUrl;

//Versions
- (long long)qimNav_NavVersion;
- (long long)qimNav_CheckConfigVersion;

- (NSString *)qimNav_NavUrl;

- (NSString *)qimNav_NavTitle;

- (BOOL)qimNav_Debug;

- (NSArray *)qimNav_getDebugers;

- (NSString *)qimNav_HealthcheckUrl;

- (NSMutableArray *)qimNav_localNavConfigs;

- (void)qimNav_updateNavigationConfigWithCheck:(BOOL)check;
- (void)qimNav_updateNavigationConfigWithCheck:(BOOL)check withCallBack:(QIMKitGetNavConfigCallBack)callback;

/**
 清除广告
 */
- (void)qimNav_clearAdvertSource;

- (void)qimNav_swicthLocalNavConfigWithNavDict:(NSDictionary *)navDict;

- (NSString *)qimNav_getAdvertImageFilePath;

- (void)qimNav_updateAdvertConfigWithCheck:(BOOL)check;

- (void)qimNav_updateNavigationConfigWithDomain:(NSString *)domain WithUserName:(NSString *)userName withCallBack:(QIMKitGetNavConfigCallBack)callback;

- (BOOL)qimNav_updateNavigationConfigWithNavUrl:(NSString *)navUrl WithUserName:(NSString *)userName withCallBack:(QIMKitGetNavConfigCallBack)callback;

- (BOOL)qimNav_updateNavigationConfigWithNavDict:(NSDictionary *)navDict WithUserName:(NSString *)userName Check:(BOOL)check WithForcedUpdate:(BOOL)forcedUpdate withCallBack:(QIMKitGetNavConfigCallBack)callback;

@end
