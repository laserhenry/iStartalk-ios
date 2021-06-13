//
//  QTalkSearch.m
//  qunarChatIphone
//
//  Created by wangyu.wang on 2016/11/28.
//
//

#import <React/RCTRootView.h>
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import "NSBundle+QIMLibrary.h"

#if defined (QIMLogEnable) && QIMLogEnable == 1
#import "QIMLocalLog.h"
#endif

#import "QTalkSearchRNView.h"
#import "MBProgressHUD.h"

static RCTBridge *bridge = nil;

@implementation QTalkSearchRNView

- (MBProgressHUD *)progressHUD {

    if (!_progressHUD) {

        _progressHUD = [[MBProgressHUD alloc] initWithFrame:self.bounds];
        _progressHUD.minSize = CGSizeMake(120, 120);
        _progressHUD.center = self.center;
        _progressHUD.minShowTime = 0.7;
        [[UIApplication sharedApplication].keyWindow addSubview:_progressHUD];
    }
    return _progressHUD;
}

- (void)setProgressHUDDetailsLabelText:(NSString *)text {

    [self.progressHUD setDetailsLabelText:text];
    [self.progressHUD show:YES];
}

- (void)closeHUD {
    if (self.progressHUD) {
        [self.progressHUD hide:YES];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:[self getRCTbridge] moduleName:@"qtalkSearch" initialProperties:[self getNewSearchInitialProps]];

        [rootView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
        [self addSubview:rootView];
        rootView.frame = self.bounds;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(rnBundleUpdate:)
                                                     name:kNotify_RN_QTALK_SEARCH_BUNDLE_UPDATE
                                                   object:nil];

        [self closeHUD];
    }
    return self;
}

- (NSDictionary *)getNewSearchInitialProps {
    NSMutableDictionary *initialProps = [NSMutableDictionary dictionaryWithCapacity:1];
    [initialProps setQIMSafeObject:[[STKit sharedInstance] qimNav_InnerFileHttpHost] forKey:@"server"];
    return initialProps;
}

- (void)viewWillAppear:(BOOL)animated {
    if ([self getRCTbridge] == nil) {
        [self setProgressHUDDetailsLabelText:@"正在载入"];
    }

    [self.ownerVC.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)rnBundleUpdate:(NSNotification *)notification {
    // remove subview
    [self removeAllSubviews];
    // clear bridge cache
    [self clearBridge];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:[self getRCTbridge] moduleName:[QTalkSearchRNView getRegisterBundleName] initialProperties:[self getNewSearchInitialProps]];

    [rootView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];

    [self addSubview:rootView];

    rootView.frame = self.bounds;

    [self closeHUD];
}

- (void)clearBridge {
    bridge = nil;

    [self setProgressHUDDetailsLabelText:@"正在载入"];
}

- (RCTBridge *)getRCTbridge {
    if (bridge == nil) {
        [self buildBundle];
    }
    return bridge;
}

- (void)buildBundle {
    NSURL *jsLocation = [self getJSCodeLocation];

    bridge = [[RCTBridge alloc] initWithBundleURL:jsLocation
                                   moduleProvider:nil
                                    launchOptions:nil];
}

- (NSURL *)getJSCodeLocation {
    // For production use, this `NSURL` could instead point to a pre-bundled file on disk:
//    return [NSURL URLWithString:@"http://ip:8081/index.ios.bundle?platform=ios&dev=true"];
    NSString *appDebugOpsSearchRNDebugUrlStr = [[STKit sharedInstance] userObjectForKey:@"qtalkSearchRNDebugUrl"];
    if (appDebugOpsSearchRNDebugUrlStr.length > 0) {
        NSURL *appDebugOpsSearchRNDebugUrl = [NSURL URLWithString:appDebugOpsSearchRNDebugUrlStr];
        return appDebugOpsSearchRNDebugUrl;
    } else {
        NSString *innerJsCodeLocation = [NSBundle qim_myLibraryResourcePathWithClassName:@"QIMRNKit" BundleName:@"QIMRNKit" pathForResource:[QTalkSearchRNView getInnerBundleName] ofType:@"jsbundle"];
        NSURL *jsCodeLocation = [NSURL URLWithString:innerJsCodeLocation];
        // load jsbundle from cacheqtalk_temp_features
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];

        NSString *latestJSCodeURLString = [[path stringByAppendingPathComponent:[QTalkSearchRNView getCachePath]] stringByAppendingPathComponent:[QTalkSearchRNView getAssetBundleName]];

        NSURL *_latestJSCodeLocation;
        if (latestJSCodeURLString && [[NSFileManager defaultManager] fileExistsAtPath:latestJSCodeURLString]) {
            QIMVerboseLog(@"Search JsBundle本地缓存文件存在%@", latestJSCodeURLString);
            _latestJSCodeLocation = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", latestJSCodeURLString]];
            jsCodeLocation = _latestJSCodeLocation;
        } else {
            //内置包
        }
        QIMVerboseLog(@"jsCodeLocation : %@", jsCodeLocation);

        // debug
        _jsCodeLocation = jsCodeLocation;

        return jsCodeLocation;
    }
}

/*
 * 依赖客户端升级 大版本号
 *
 */
+ (NSString *)getAssetBundleName {
    return @"rn-qtalk-search.ios.jsbundle_v4";
}

/*
 * 离线资源包 压缩文件名
 *
 */
+ (NSString *)getAssetZipBundleName {
    return @"rn-qtalk-search.ios.jsbundle.tar.gz";
}

/*
 * 内置bundle 文件名
 *
 */
+ (NSString *)getInnerBundleName {
    return @"rn-qtalk-search.ios";
}

/*
 * 缓存路径
 *
 */
+ (NSString *)getCachePath {
    return @"rnRes/qtalk_search/";
}

/*
 * 依赖js端注册模块名,需要保持一致
 *
 */
+ (NSString *)getRegisterBundleName {
    return @"qtalkSearch";
}

- (void)dealloc {
    [self.progressHUD removeFromSuperview];
    self.progressHUD = nil;
}

@end
