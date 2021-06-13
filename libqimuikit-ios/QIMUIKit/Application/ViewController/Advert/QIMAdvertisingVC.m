//
//  QIMAdvertisingVC.m
//  qunarChatIphone
//
//  Created by admin on 16/3/29.
//
//

#import <WebKit/WebKit.h>

#import "QIMAdvertisingVC.h"
#import "QIMWebView.h"
#import "STAdvertItem.h"
#import "QIMTapGestureRecognizer.h"


@interface WebViewScrollerDelegate : NSObject<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *scrollerList;
@property (nonatomic, weak) QIMAdvertisingVC *owner;
@end

@interface QIMAdvertisingVC ()<WKNavigationDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    WKWebView *_webView;
    QIMImageView *_adImageView;
    UIButton *_loadingButton;
    int _currentLoadingTime;
    STAdvertItem *_currentAdvertItem;
    int _prepPageIndex;
    
    WebViewScrollerDelegate *_webviewScrollerDelegate;
}

@property (nonatomic, strong) UIButton *loadingButton;

@end

@implementation QIMAdvertisingVC

- (UIButton *)loadingButton {
    if (!_loadingButton) {
        _loadingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    return _loadingButton;
}

- (void)onOpenWebView:(QIMTapGestureRecognizer *)tap {
    
    NSString *linkUrl = tap.imageLink;
    QIMWebView *webVC = [[QIMWebView alloc] init];
    [webVC setUrl:linkUrl];
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)onLoadUrl:(QIMTapGestureRecognizer *)tap{
    [self cancelLoadingState];
    
    [_adImageView removeFromSuperview];
    _adImageView = nil;
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";

    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];

    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;

    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) configuration:wkWebConfig];
    webView.navigationDelegate = self;
    NSURL *url = [NSURL URLWithString:[tap.imageLink stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    [self.view bringSubviewToFront:webView];
}

- (void)onCloseClick{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[STKit sharedInstance] qimNav_clearAdvertSource];
    [_loadingButton removeAllSubviews];
    SEL sel = @selector(launchMainController);
    if ([[[UIApplication sharedApplication] delegate] respondsToSelector:sel]) {
        [[[STAppWindowMgr sharedInstance] advertWindow] setHidden:YES];
        [[STAppWindowMgr sharedInstance] setAdvertWindow:nil];
        [[[STAppWindowMgr sharedInstance] advertWindow] resignKeyWindow];
    }
}

- (void)cancelLoadingState{
    if ([_loadingButton.titleLabel.text isEqualToString:@"ㄨ"]==NO) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [_loadingButton removeTarget:self action:@selector(onLoadingButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_loadingButton addTarget:self action:@selector(onCloseClick) forControlEvents:UIControlEventTouchUpInside];
        [_loadingButton setFrame:CGRectMake(self.view.width - 44, 20, 24, 24)];
        [_loadingButton setTitle:@"ㄨ" forState:UIControlStateNormal];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if ([[STKit sharedInstance] qimNav_AdCarousel] == NO && [[navigationAction.request.URL description] isEqualToString:[_currentAdvertItem adLinkUrl]] == NO) {
        [self cancelLoadingState];
    } else if ([[STKit sharedInstance] qimNav_AdCarousel] && [[STKit sharedInstance] qimNav_AdItems].count > 1) {
        if (_pageControl.currentPage >=0 && _pageControl
            .currentPage < [[[STKit sharedInstance] qimNav_AdItems] count]) {
            STAdvertItem *adItem = [[STKit sharedInstance] qimNav_AdItems][_pageControl.currentPage];
            if (adItem.adType == AdvertType_Touch && [[navigationAction.request.URL description] isEqualToString:[adItem adLinkUrl]] == NO) {
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(carouselAdvert) object:nil];
            }
        }
    }
    return;
}

- (void)onLoadingButtonClick{
    if ([[STKit sharedInstance] qimNav_AdAllowSkip]) {
        [self onCloseClick];
    } else {
        NSString *skipTips = [[STKit sharedInstance] qimNav_AdSkipTips];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:skipTips delegate:nil cancelButtonTitle:[NSBundle qim_localizedStringForKey:@"OK"] otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = ceil(scrollView.contentOffset.x / _scrollView.width);
    NSInteger pageIndex;
    if (page == 0 ) {
        pageIndex = _pageControl.numberOfPages-1;
        [_scrollView setContentOffset:CGPointMake(_scrollView.width * _pageControl.numberOfPages, 0)];
    } else if (page > _pageControl.numberOfPages + 1) {
        pageIndex = 0;
        [_scrollView setContentOffset:CGPointMake(_scrollView.width, 0)];
    } else {
        pageIndex = page-1;
    }
    if (pageIndex >= _pageControl.numberOfPages) {
//        pageIndex = 0;
        [self onCloseClick];
    } else if(pageIndex < 0) {
        pageIndex = _pageControl.numberOfPages - 1;
    }
    _pageControl.currentPage = pageIndex;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([[STKit sharedInstance] qimNav_AdItems].count > 1 && [[STKit sharedInstance] qimNav_AdCarouselDelay] > 0) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(carouselAdvert) object:nil];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if ([[STKit sharedInstance] qimNav_AdItems].count > 1 && [[STKit sharedInstance] qimNav_AdCarouselDelay] > 0) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(carouselAdvert) object:nil];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([[STKit sharedInstance] qimNav_AdItems].count > 1 && [[STKit sharedInstance] qimNav_AdCarouselDelay] > 0) {
        [self performSelector:@selector(carouselAdvert) withObject:nil afterDelay:[[STKit sharedInstance] qimNav_AdCarouselDelay]];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([[STKit sharedInstance] qimNav_AdItems].count > 1 && [[STKit sharedInstance] qimNav_AdCarouselDelay] > 0 && decelerate) {
        [self performSelector:@selector(carouselAdvert) withObject:nil afterDelay:[[STKit sharedInstance] qimNav_AdCarouselDelay]];
    }
}
// 滚动显示
- (void)initCarouselUI{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _scrollView.delegate = self;
    _scrollView.delaysContentTouches = NO;
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setPagingEnabled:[[STKit sharedInstance] qimNav_AdItems].count > 0];
    [self.view addSubview:_scrollView];
    int index = 1;
    for (STAdvertItem *adItem in [[STKit sharedInstance] qimNav_AdItems]) {
        switch ([adItem adType]) {
            case AdvertType_Touch:
            {
                WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(index * _scrollView.width, 0, _scrollView.width, _scrollView.height)];
                [webView.scrollView setDelegate:_webviewScrollerDelegate];
                [_webviewScrollerDelegate.scrollerList addObject:webView.scrollView];
                webView.navigationDelegate = self;
                NSURL *url = [NSURL URLWithString:[adItem.adLinkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [webView loadRequest:request];
                [_scrollView addSubview:webView];
            }
                break;
            case AdvertType_Image:
            {
                _adImageView = [[QIMImageView alloc] initWithFrame:CGRectMake(index * _scrollView.width, 0, _scrollView.width, _scrollView.height)];
                NSString *imgUrl = [adItem adImgUrl];
                NSString *filePath = [[STKit sharedInstance] qimNav_getAdvertImageFilePath];
                NSString *advertFileName = [[STKit sharedInstance] getFileNameFromUrl:imgUrl];
                filePath = [filePath stringByAppendingPathComponent:advertFileName];
                _adImageView.image = [QIMImage imageWithContentsOfFile:filePath];
                [_scrollView addSubview:_adImageView];
                if (adItem.adLinkUrl) {
                    QIMTapGestureRecognizer *tap = [[QIMTapGestureRecognizer alloc] initWithTarget:self action:@selector(onOpenWebView:)];
                    [tap setImageLink:adItem.adLinkUrl];
                    [_adImageView setUserInteractionEnabled:YES];
                    [_adImageView addGestureRecognizer:tap];
                }
            }
                break;
            default:
                break;
        }
        index++;
    }
    if (_scrollView.pagingEnabled) {
        { //最前边 补充一个
            STAdvertItem *lastItem = [[[STKit sharedInstance] qimNav_AdItems] lastObject];
            switch ([lastItem adType]) {
                case AdvertType_Touch:
                {
                    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.width, _scrollView.height)];
                    [webView.scrollView setDelegate:_webviewScrollerDelegate];
                    [_webviewScrollerDelegate.scrollerList addObject:webView.scrollView];
                    webView.navigationDelegate = self;
                    NSURL *url = [NSURL URLWithString:[lastItem.adLinkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    NSURLRequest *request = [NSURLRequest requestWithURL:url];
                    [webView loadRequest:request];
                    [_scrollView addSubview:webView];
                }
                    break;
                case AdvertType_Image:
                {
                    _adImageView = [[QIMImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.width, _scrollView.height)];
                    NSString *imgUrl = [lastItem adImgUrl];
                    NSString *filePath = [[STKit sharedInstance] qimNav_getAdvertImageFilePath];
                    NSString *advertFileName = [[STKit sharedInstance] getFileNameFromUrl:imgUrl];
                    filePath = [filePath stringByAppendingPathComponent:advertFileName];
                    _adImageView.image = [QIMImage imageWithContentsOfFile:filePath];
                    [_scrollView addSubview:_adImageView];
                    if (lastItem.adLinkUrl) {
                        QIMTapGestureRecognizer *tap = [[QIMTapGestureRecognizer alloc] initWithTarget:self action:@selector(onOpenWebView:)];
                        [tap setImageLink:lastItem.adLinkUrl];
                        [_adImageView setUserInteractionEnabled:YES];
                        [_adImageView addGestureRecognizer:tap];
                    }
                }
                    break;
                default:
                    break;
            }
        }
        { //最后一个 补充一个
            STAdvertItem *firstItem = [[[STKit sharedInstance] qimNav_AdItems] firstObject];
            NSInteger count = [[[STKit sharedInstance] qimNav_AdItems] count] + 1;
            switch ([firstItem adType]) {
                case AdvertType_Touch:
                {
                    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(count * _scrollView.width, 0, _scrollView.width, _scrollView.height)];
                    [webView.scrollView setDelegate:_webviewScrollerDelegate];
                    [_webviewScrollerDelegate.scrollerList addObject:webView.scrollView];
                    webView.navigationDelegate = self;
                    NSURL *url = [NSURL URLWithString:[firstItem.adLinkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    NSURLRequest *request = [NSURLRequest requestWithURL:url];
                    [webView loadRequest:request];
                    [_scrollView addSubview:webView];
                }
                    break;
                case AdvertType_Image:
                {
                    _adImageView = [[QIMImageView alloc] initWithFrame:CGRectMake(count * _scrollView.width, 0, _scrollView.width, _scrollView.height)];
                    NSString *imgUrl = [firstItem adImgUrl];
                    NSString *filePath = [[STKit sharedInstance] qimNav_getAdvertImageFilePath];
                    NSString *advertFileName = [[STKit sharedInstance] getFileNameFromUrl:imgUrl];
                    filePath = [filePath stringByAppendingPathComponent:advertFileName];
                    _adImageView.image = [QIMImage imageWithContentsOfFile:filePath];
                    [_scrollView addSubview:_adImageView];
                    if (firstItem.adLinkUrl) {
                        QIMTapGestureRecognizer *tap = [[QIMTapGestureRecognizer alloc] initWithTarget:self action:@selector(onOpenWebView:)];
                        [tap setImageLink:firstItem.adLinkUrl];
                        [_adImageView setUserInteractionEnabled:YES];
                        [_adImageView addGestureRecognizer:tap];
                    }
                }
                    break;
                default:
                    break;
            }
        }
    }
    
    _loadingButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 44, 20, 24, 24)];
    [_loadingButton.layer setCornerRadius:12];
    [_loadingButton setBackgroundColor:[UIColor qim_colorWithHex:0x0 alpha:0.75]];
    [_loadingButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_loadingButton setTitle:@"ㄨ" forState:UIControlStateNormal];
    [_loadingButton addTarget:self action:@selector(onCloseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loadingButton];
    if (_scrollView.pagingEnabled) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.height - 40, self.view.width, 20)];
        [_pageControl setNumberOfPages:[[STKit sharedInstance] qimNav_AdItems].count];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPage   = 0;
        [self.view addSubview:_pageControl];
        
        [_scrollView setContentSize:CGSizeMake(_scrollView.width * ([[STKit sharedInstance] qimNav_AdItems].count+2), _scrollView.height)];
        [_scrollView setContentOffset:CGPointMake(_scrollView.width, 0)];
        if ([[STKit sharedInstance] qimNav_AdItems].count > 1 && [[STKit sharedInstance] qimNav_AdCarouselDelay] > 0) {
            [self performSelector:@selector(carouselAdvert) withObject:nil afterDelay:[[STKit sharedInstance] qimNav_AdCarouselDelay]];
        }
    }
}

- (void)carouselAdvert{
    int pageIndex = _scrollView.contentOffset.x/_scrollView.width;
    pageIndex++;
    [_scrollView setContentOffset:CGPointMake(pageIndex * _scrollView.width, 0) animated:YES];
    if ([[STKit sharedInstance] qimNav_AdItems].count > 1 && [[STKit sharedInstance] qimNav_AdCarouselDelay] > 0) {
        [self performSelector:@selector(carouselAdvert) withObject:nil afterDelay:[[STKit sharedInstance] qimNav_AdCarouselDelay]];
    }
}
// 单个显示
- (void)initAdvertUI{
    int index = 0;
    NSNumber *ciNum = [[STKit sharedInstance] userObjectForKey:@"AdvertPlayIndex"];
    if (ciNum) {
        index = ciNum.intValue + 1;
        if (index < [[STKit sharedInstance] qimNav_AdItems].count) {
        } else {
            index = 0;
        }
    } else {
        index = 0;
    }
    if (index >= 0 && index < [[STKit sharedInstance] qimNav_AdItems].count) {
        _currentAdvertItem = [[STKit sharedInstance] qimNav_AdItems][index];
    }
    if (_currentAdvertItem) {
        [[STKit sharedInstance] setUserObject:@(index) forKey:@"AdvertPlayIndex"];
        
        switch ([_currentAdvertItem adType]) {
            case AdvertType_Touch:
            {
                WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
                [webView.scrollView setDelegate:_webviewScrollerDelegate];
                [_webviewScrollerDelegate.scrollerList addObject:webView.scrollView];
                webView.navigationDelegate = self;
                NSURL *url = [NSURL URLWithString:[_currentAdvertItem.adLinkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [webView loadRequest:request];
                [self.view addSubview:webView];
            }
                break;
            case AdvertType_Image:
            {
                _adImageView = [[QIMImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
                NSString *imgUrl = [_currentAdvertItem adImgUrl];
                NSString *filePath = [[STKit sharedInstance] qimNav_getAdvertImageFilePath];
                NSString *advertFileName = [[STKit sharedInstance] getFileNameFromUrl:imgUrl];
                filePath = [filePath stringByAppendingPathComponent:advertFileName];
                _adImageView.image = [QIMImage imageWithContentsOfFile:filePath];
                [self.view addSubview:_adImageView];
                if (_currentAdvertItem.adLinkUrl) {
                    QIMTapGestureRecognizer *tap = [[QIMTapGestureRecognizer alloc] initWithTarget:self action:@selector(onLoadUrl:)];
                    [tap setImageLink:_currentAdvertItem.adLinkUrl];
                    [_adImageView setUserInteractionEnabled:YES];
                    [_adImageView addGestureRecognizer:tap];
                }
            }
                break;
            case AdvertType_Video:
            {
                
            }
                break;
            default:
                break;
        }
        _currentLoadingTime = [[STKit sharedInstance] qimNav_AdSec];
        if (_currentLoadingTime == 0) {
            _currentLoadingTime = 5;
        }
        _loadingButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 80, 20, 60, 24)];
        [_loadingButton.layer setCornerRadius:12];
        [_loadingButton setBackgroundColor:[UIColor qim_colorWithHex:0x0 alpha:0.75]];
        [_loadingButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_loadingButton setTitle:[NSString stringWithFormat:@"%ds 跳过",_currentLoadingTime] forState:UIControlStateNormal];
        [_loadingButton addTarget:self action:@selector(onLoadingButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:_loadingButton];
        [self performSelector:@selector(updateLoadingButtonTitle) withObject:nil afterDelay:1];
    }
}

- (void)onTempClick{
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    [self cancelLoadingState];
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webviewScrollerDelegate = [[WebViewScrollerDelegate alloc] init];
    [_webviewScrollerDelegate setOwner:self];
    [_webviewScrollerDelegate setScrollerList:[NSMutableArray array]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTempClick)];
    [tap setDelegate:self];
    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    
    if ([[STKit sharedInstance] qimNav_AdCarousel]) {
        [self initCarouselUI];
    } else {
        [self initAdvertUI]; 
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLoadingButtonTitle{
    _currentLoadingTime--;
    [_loadingButton setTitle:[NSString stringWithFormat:@"%ds 跳过",_currentLoadingTime] forState:UIControlStateNormal];
    if (_currentLoadingTime == 0) {
        [self onCloseClick];
    } else {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(updateLoadingButtonTitle) withObject:nil afterDelay:1];
    }
}

@end

@implementation WebViewScrollerDelegate
- (void)dealloc{
    for (UIScrollView *scrollView in self.scrollerList) {
        [scrollView setDelegate:nil];
    }
    [self setScrollerList:nil];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.owner cancelLoadingState];
}
@end
