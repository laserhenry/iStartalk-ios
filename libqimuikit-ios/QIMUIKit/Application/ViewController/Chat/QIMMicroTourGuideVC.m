//
//  QIMMicroTourGuideVC.m
//  qunarChatIphone
//
//  Created by admin on 16/4/15.
//
//

#import <WebKit/WebKit.h>

#import "QIMMicroTourGuideVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "QIMChatVC.h"
#import "QIMJSONSerializer.h"
#import "QIMGroupChatVC.h"
#import "QIMWebView.h"
#import "NSBundle+QIMLibrary.h"

@interface QIMMicroTourGuideVC ()<WKNavigationDelegate>{
    WKWebView *_msgWebView;
    NSMutableArray *_dataSource;
    BOOL _ready;
}

@end

@implementation WKWebView(SynchronousEvaluateJavaScript)

- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script
{
    __block NSString *resultString = nil;
    __block BOOL finished = NO;

    [self evaluateJavaScript:script completionHandler:^(id result, NSError *error) {
        if (error == nil) {
            if (result != nil) {
                resultString = [NSString stringWithFormat:@"%@", result];
            }
        } else {
            NSLog(@"evaluateJavaScript error : %@", error.localizedDescription);
        }
        finished = YES;
    }];

    while (!finished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }

    return resultString;
}
@end

@implementation QIMMicroTourGuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataSource = [NSMutableArray array];
    NSArray *msgList = [[STKit sharedInstance] getPublicNumberMsgListById:self.userId WithLimit:50 WithOffset:0];
    [_dataSource addObjectsFromArray:msgList]; 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMessageList:) name:kNotificationMessageUpdate object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMessageState:) name:@"kNotificationUpdateQDMessageState" object:nil];
    [self initWebView];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollToBottom{
    NSInteger height = [[_msgWebView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] intValue];
    [_msgWebView.scrollView scrollRectToVisible:CGRectMake(0, height - _msgWebView.frame.size.height, _msgWebView.width, _msgWebView.height) animated:YES];
}

- (void)updateMessageList:(NSNotification *)notify{
    NSString *userId = notify.object;
    if ([self.userId isEqualToString:userId]) {
       STMsgModel *msg = [notify.userInfo objectForKey:@"message"];
        [_dataSource addObject:msg];
        if (_ready) {
            [self initMessage:msg];
            [self scrollToBottom];
        }
    }
}

- (void)initMessage:(STMsgModel *)msg{
    switch (msg.messageType) {
        case QIMMessageType_Time:
        {
//            NSString *timeStr = [[NSDate dateWithTimeIntervalSince1970:msg.messageDate] formattedDateDescription];
//            [self appendTimeStemp:timeStr];
        }
            break;
        case QIMMessageType_MicroTourGuide:
        {
            NSString *element = [msg message];
            NSDictionary *contentDic = [[QIMJSONSerializer sharedInstance] deserializeObject:element error:nil];
            element = [contentDic objectForKey:@"htmlcontent"];
            if (element.length > 0) {
                NSString *data = [[QIMJSONSerializer sharedInstance] serializeObject:@{@"htmlcontent":element,@"time":@([[NSDate qim_dateWithTimeIntervalInMilliSecondSince1970:msg.messageDate] qim_timeIntervalSince1970InMilliSecond])}];
                [self appendHtmlElement:data];
            }
        }
            break;
        default:
            break;
    }
}

- (void)initWebView{
    
    NSString *ua = [[QIMWebView defaultUserAgent] stringByAppendingString:@" qunariphone"];
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : ua, @"User-Agent":ua}];
    
    _msgWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    //[_msgWebView setDelegate:self];
    [self.view addSubview:_msgWebView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"QIMMicroTourRoot" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [_msgWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    return ;
}

- (void)webViewDidFinishLoad:(WKWebView *)webView{
//    [self resgisterJSMethod];
    [self resgisterJSMethod];
//    [self appendTimeStemp:@"2016-06-03 08:30"];
    [self initDataSource];
    _ready = YES;
}

- (void)resgisterJSMethod{
    JSContext *context=[_msgWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"openNewSession"] = ^() {
        NSArray *args = [JSContext currentArguments];
        NSString *jid = [args.firstObject toString];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([jid rangeOfString:@"@conference"].location == NSNotFound) {
                [self openSingleChat:jid];
            } else {
                [self openGroupChat:jid];
            }
        });
    };
    context[@"openNewLink"] = ^() {
        NSArray *args = [JSContext currentArguments];
        NSString *url = [args.firstObject toString];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self openUrl:url];
        });
    };
    context[@"updateCardState"] = ^() {
        NSArray *args = [JSContext currentArguments];
        if (args.count >= 2) {
            NSString *msgId = args[0];
            NSString *state = args[1];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateMessageWithMsgId:msgId WithState:state];
            });
        }
    };
}

- (void)updateMessageState:(NSNotification *)notify{
    if ([notify.object isEqualToString:self.userId]) {
        NSString *msgId = [notify.userInfo objectForKey:@"MsgId"];
        NSString *state = [notify.userInfo objectForKey:@"State"];
        [self updateMessageWithMsgId:msgId WithState:state];
    }
}

- (void)updateMessageWithMsgId:(NSString *)msgId WithState:(NSString *)state{
    JSContext *context=[_msgWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *jsFunctStr=[NSString stringWithFormat:@"updateMessage('%@','%@')",msgId,state];
    [context evaluateScript:jsFunctStr];
}

- (void)appendTimeStemp:(NSString *)timeStemp{
    JSContext *context=[_msgWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *jsFunctStr=[NSString stringWithFormat:@"appendTimeStemp('%@')",timeStemp];
    [context evaluateScript:jsFunctStr];
}

- (void)appendHtmlElement:(NSString *)element{
    JSContext *context=[_msgWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *jsFunctStr=[NSString stringWithFormat:@"pushMessage(%@)",[element stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"]];
    [context evaluateScript:jsFunctStr];
}

- (void)initDataSource{
    for (STMsgModel *msg in _dataSource) {
        [self initMessage:msg];
    }
    [self scrollToBottom];
}

- (void)openSingleChat:(NSString *)jid{
    [STFastEntrance openSingleChatVCByUserId:jid];
}

- (void)openGroupChat:(NSString *)jid{
    NSDictionary *groupDic = [[STKit sharedInstance] getGroupCardByGroupId:jid];
    if (groupDic) {
        NSString *jid = [groupDic objectForKey:@"GroupId"];
        [STFastEntrance openGroupChatVCByGroupId:jid];
    }
}

- (void)openUrl:(NSString *)url{
    QIMWebView *webView = [[QIMWebView alloc] init];
    [webView setUrl:url];
    [webView setFromQiangDan:YES];
    [webView setFromUserId:self.userId];
    [self.navigationController pushViewController:webView animated:YES];
}

@end
