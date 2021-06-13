//
//  QIMWebLoginVC.m
//  qunarChatIphone
//
//  Created by admin on 16/2/16.
//
//
#import <WebKit/WebKit.h>

#import "QIMWebLoginVC.h"
#import "QIMJSONSerializer.h"
#import "QIMNavConfigManagerVC.h"
#import "MBProgressHUD.h"
#import "NSBundle+QIMLibrary.h"

@interface QIMWebLoginVC ()<WKNavigationDelegate>{
    WKWebView *_webView;
    MBProgressHUD *_progressHUD;
    UIButton *_settingButton;
    NSString *_loginUrl;
}

@end

@implementation QIMWebLoginVC

- (void)syncWebviewCookie
{
    NSString * qCookie = [[[STKit sharedInstance] userObjectForKey:@"QChatCookie"] objectForKey:@"q"];
    NSString * vCookie = [[[STKit sharedInstance] userObjectForKey:@"QChatCookie"] objectForKey:@"v"];
    NSString * tCookie = [[[STKit sharedInstance] userObjectForKey:@"QChatCookie"] objectForKey:@"t"];
    
    if ([qCookie qim_isStringSafe] && [vCookie qim_isStringSafe] && [tCookie qim_isStringSafe])
    {
        NSMutableDictionary *qcookieProperties = [NSMutableDictionary dictionary];
        [qcookieProperties setQIMSafeObject:@"_q" forKey:NSHTTPCookieName];
        [qcookieProperties setQIMSafeObject:qCookie forKey:NSHTTPCookieValue];
        [qcookieProperties setQIMSafeObject:@".qunar.com"forKey:NSHTTPCookieDomain];
        [qcookieProperties setQIMSafeObject:@"/" forKey:NSHTTPCookiePath];
        [qcookieProperties setQIMSafeObject:@"0" forKey:NSHTTPCookieVersion];
        
        NSHTTPCookie*qcookie = [NSHTTPCookie cookieWithProperties:qcookieProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:qcookie];
        
        NSMutableDictionary *vcookieProperties = [NSMutableDictionary dictionary];
        [vcookieProperties setObject:@"_v" forKey:NSHTTPCookieName];
        [vcookieProperties setQIMSafeObject:vCookie forKey:NSHTTPCookieValue];
        [vcookieProperties setObject:@".qunar.com"forKey:NSHTTPCookieDomain];
        [vcookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
        [vcookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
        
        NSHTTPCookie*vcookie = [NSHTTPCookie cookieWithProperties:vcookieProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:vcookie];
        
        NSMutableDictionary *tcookieProperties = [NSMutableDictionary dictionary];
        [tcookieProperties setQIMSafeObject:@"_t" forKey:NSHTTPCookieName];
        [tcookieProperties setQIMSafeObject:tCookie forKey:NSHTTPCookieValue];
        [tcookieProperties setQIMSafeObject:@".qunar.com"forKey:NSHTTPCookieDomain];
        [tcookieProperties setQIMSafeObject:@"/" forKey:NSHTTPCookiePath];
        [tcookieProperties setQIMSafeObject:@"0" forKey:NSHTTPCookieVersion];
        
        NSHTTPCookie*tcookie = [NSHTTPCookie cookieWithProperties:tcookieProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:tcookie];
        
        NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        NSArray *cookies = [sharedHTTPCookieStorage cookies];
        QIMVerboseLog(@"cookie : %@",cookies);
    }
    else
    {
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        NSArray *cookieArray = [NSArray arrayWithArray:[cookieJar cookies]];
        for (NSHTTPCookie *cookie in cookieArray)
        {
            if ([[cookie domain] qim_isStringSafe] && [[cookie domain] isEqual:@".qunar.com"] &&
                [[cookie name] qim_isStringSafe] &&
                ([[cookie name] isEqual:@"_q"] || [[cookie name] isEqual:@"_v"] || [[cookie name] isEqual:@"_t"]))
            {
                [cookieJar deleteCookie:cookie];
            }
        }
    }
}

- (void)dealloc
{
    [_progressHUD removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _progressHUD = nil;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    [_progressHUD setHidden:NO];
    NSHTTPCookieStorage *myCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSString *q = nil;
    NSString *v = nil;
    NSString *t = nil;
    for (NSHTTPCookie *cookie in [myCookie cookies]) {
        if ([cookie.name isEqualToString:@"_q"]) {
            q = cookie.value;
        } else if([cookie.name isEqualToString:@"_v"]) {
            v = cookie.value;
        } else if([cookie.name isEqualToString:@"_t"]) {
            t = cookie.value;
        }
    }
    if (!q || !v || !t) {
        q = [[[STKit sharedInstance] userObjectForKey:@"QChatCookie"] objectForKey:@"q"];
        v = [[[STKit sharedInstance] userObjectForKey:@"QChatCookie"] objectForKey:@"v"];
        t = [[[STKit sharedInstance] userObjectForKey:@"QChatCookie"] objectForKey:@"t"];
    }
    if (q && v && t) {
        NSString *userName = [q substringFromIndex:2];
        NSMutableDictionary * passwordDic = [NSMutableDictionary dictionaryWithCapacity:1];
        [passwordDic setQIMSafeObject:q forKey:@"q"];
        [passwordDic setQIMSafeObject:v forKey:@"v"];
        [passwordDic setQIMSafeObject:t forKey:@"t"];
        [[STKit sharedInstance] setUserObject:passwordDic forKey:@"QChatCookie"];
        //同步http cookie
        [self syncWebviewCookie];
        userName = [[userName lowercaseString] stringByReplacingOccurrencesOfString:@"@" withString:@"[#at]"];
        
        
        NSString *lastUserName = [STKit getLastUserName];
        NSString *lastUserToken = [[STKit sharedInstance] getLastUserToken];
//        [[QIMKit sharedInstance] userObjectForKey:@"userToken"];
        if (lastUserName.length > 0 && lastUserToken.length > 0) {
            [[STKit sharedInstance] updateLastTempUserToken:lastUserToken];
//            [[QIMKit sharedInstance] setUserObject:lastUserToken forKey:@"kTempUserToken"];
            [[STKit sharedInstance] loginWithUserName:lastUserName WithPassWord:lastUserToken];
            [_progressHUD setHidden:YES];
        } else {
            //      切换成Token登录模式
            NSString *buName = @"app";
            [[STKit sharedInstance] getQChatTokenWithBusinessLineName:buName withCallBack:^(NSDictionary *qchatToken) {
                if (qchatToken.count) {
                    NSString *userNameToken = [qchatToken objectForKey:@"username"];
                    NSString *pwdToken = [qchatToken objectForKey:@"token"];
                    //        {"token":{"plat":"app", "macCode":"xxxxxxxxxxxx", "token":"xxxxxxxxxx"}}
                    NSMutableDictionary *tokenDic = [NSMutableDictionary dictionary];
                    [tokenDic setObject:buName forKey:@"plat"];
                    [tokenDic setObject:[[STKit sharedInstance] macAddress] forKey:@"macCode"];
                    [tokenDic setObject:pwdToken forKey:@"token"];
                    NSString *password = [[QIMJSONSerializer sharedInstance] serializeObject:@{@"token":tokenDic}];
                    [[STKit sharedInstance] updateLastTempUserToken:password];
                    [[STKit sharedInstance] loginWithUserName:userNameToken WithPassWord:password];
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self clearLoginCookie];
                        [self loadLoginUrl];
                        [_progressHUD setHidden:YES];
                    });
                }
            }];
        }
        if ([navigationAction.request.URL.absoluteString containsString:@"/personalcenter/myaccount/"]) {
            return ;
        }
    }
    return ;
}

- (void)webViewDidFinishLoad:(WKWebView *)webView{
    
    [_progressHUD setHidden:YES];
    if ([webView.URL.description hasPrefix:@"https://user.qunar.com/mobile/login.jsp"]) {
        NSString *meta = @"document.getElementsByClassName(\"back\")[0].style.display=\"none\";";
        [webView evaluateJavaScript:meta completionHandler:nil];
    }
}

- (void)webView:(WKWebView *)webView didFailLoadWithError:(NSError *)error {
    QIMVerboseLog(@"WebLogin : %@, Error : %@", webView.request.URL.absoluteString, error);
    if ([webView.URL.absoluteString containsString:@"user.qunar.com"]) {
        [self clearLoginCookie];
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:[NSBundle qim_localizedStringForKey:@"common_prompt"] message:[NSBundle qim_localizedStringForKey:@"relogin_checkNetWork"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:[NSBundle qim_localizedStringForKey:@"ok"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf clearLoginCookie];
            [weakSelf loadLoginUrl];
            [_progressHUD setHidden:YES];
        }];
        UIAlertAction *settingAction = [UIAlertAction actionWithTitle:[NSBundle qim_localizedStringForKey:@"myself_tab_setting"] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            [weakSelf loadLoginUrl];
        }];
        [alertVc addAction:okAction];
        [alertVc addAction:settingAction];
        [self presentViewController:alertVc animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loginUrl = @"https://user.qunar.com/mobile/login.jsp?onlyLogin=true&ret=qauth.im.complete&loginType=mobile";
    
    UIView *stateBarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    [stateBarBgView setBackgroundColor:[UIColor qunarBlueColor]];
    [self.view addSubview:stateBarBgView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginNotify:) name:kNotificationLoginState object:nil];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, self.view.height)];
    [_webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    _progressHUD.minSize = CGSizeMake(120, 120);
    _progressHUD.minShowTime = 1;
    [_progressHUD setLabelText:@"正在加载"];
    [_progressHUD show:YES];
    [self.view addSubview:_progressHUD];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSettingBtnAction:)];
    tap.numberOfTouchesRequired = 1; //手指数
    tap.numberOfTapsRequired = 5; //tap次数
    [self.view addGestureRecognizer:tap];
    
    _settingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 24)];
    [_settingButton setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [_settingButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_settingButton setTitleColor:[UIColor qim_colorWithHex:0x999999] forState:UIControlStateNormal];
    [_settingButton setTitle:[NSBundle qim_localizedStringForKey:@"nav_Set_Service_Address"] forState:UIControlStateNormal];
    [_settingButton setImage:[UIImage qim_imageNamedFromQIMUIKitBundle:@"iconSetting"] forState:UIControlStateNormal];
    [_settingButton addTarget:self action:@selector(onSettingClick:) forControlEvents:UIControlEventTouchUpInside];
    _settingButton.hidden = YES;
    [self.view addSubview:_settingButton];
    [self loadLoginUrl];
}

- (void)showSettingBtnAction:(UITapGestureRecognizer *)tapGesture {
    _settingButton.hidden = !_settingButton.hidden;
}

- (void)onSettingClick:(UIButton *)sender{
    QIMNavConfigManagerVC *navURLsSettingVc = [[QIMNavConfigManagerVC alloc] init];
    QIMNavController *navURLsSettingNav = [[QIMNavController alloc] initWithRootViewController:navURLsSettingVc];
    [self presentViewController:navURLsSettingNav animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)loadLoginUrl {
    
    NSURL *requestUrl = [NSURL URLWithString:_loginUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [_webView loadRequest:request];
}

- (void)loginNotify:(NSNotification *)notify{
    QIMVerboseLog(@"登录结果通知 : %@", notify);
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([notify.object boolValue]) {
            [STFastEntrance showMainVc];
        } else {
            [self clearLoginCookie];
            __weak typeof(self) weakSelf = self;
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:[NSBundle qim_localizedStringForKey:@"common_prompt"] message:[NSBundle qim_localizedStringForKey:@"login_faild"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:[NSBundle qim_localizedStringForKey:@"ok"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf loadLoginUrl];
                [_progressHUD setHidden:YES];
            }];
            [alertVc addAction:okAction];
            [self presentViewController:alertVc animated:YES completion:nil];
        }
    });
}

- (void)clearLoginCookie{
    QIMVerboseLog(@"清空了QChat Web登录Cookie");
    [[STKit sharedInstance] removeUserObjectForKey:@"QChatCookie"];
    NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [sharedHTTPCookieStorage cookies]) {
        [sharedHTTPCookieStorage deleteCookie:cookie];
    }
}

@end
