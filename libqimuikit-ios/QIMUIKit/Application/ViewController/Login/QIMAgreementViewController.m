//
//  QIMAgreementViewController.m
//  qunarChatIphone
//
//  Created by chenjie on 15/8/5.
//
//
#import <WebKit/WebKit.h>

#import "QIMAgreementViewController.h"
#import "NSBundle+QIMLibrary.h"

@interface QIMAgreementViewController ()
{
    WKWebView * _webView;
}

@end

@implementation QIMAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self setUpWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpNav
{
    self.navigationItem.title = [NSString stringWithFormat:@"%@软件使用许可协议", [STKit getQIMProjectType] == QIMProjectTypeStartalk ? @"Startalk" : @"QTalk"];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:[NSBundle qim_localizedStringForKey:@"common_close"] style:UIBarButtonItemStyleDone target:self action:@selector(closeHandle:)];
    [self.navigationItem setRightBarButtonItem:rightItem];
}

- (void)setUpWebView
{
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";

    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];

    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;

    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:wkWebConfig];
    //_webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    NSString *eulaFileName = [NSString stringWithFormat:@"%@", [STKit getQIMProjectType] == QIMProjectTypeStartalk ? @"Startalkeula" : @"QTalkeula"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:eulaFileName ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
}

- (void)closeHandle:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
