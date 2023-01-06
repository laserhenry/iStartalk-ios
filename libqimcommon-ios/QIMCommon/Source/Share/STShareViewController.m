//
//  STShareViewController.m
//  QIMCommon
//
//  Created by busylei on 2022/12/26.
//

#import "STShareViewController.h"
#import "QTalkSessionDataManager.h"
#import "QtalkSessionModel.h"
#import "QTalkNewSessionTableViewCell.h"
#import "QIMKit+QIMSession.h"
#import "STShareExtensionHelper.h"
#import "QIMUUIDTools.h"
#import "QIMStringTransformTools.h"
#import <AVFoundation/AVFoundation.h>

@interface STShareViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation STShareViewController

static NSString* GROUP_IDENTIFIER = @"group.com.im.startalk";

UIView* bar;
UITableView* sessionView;

NSArray * sessionList;
QTalkSessionDataManager *dataManager;
STKit* kit;

NSArray* items;
NSInteger sendingCount;

- (void)viewDidLoad {
    [super viewDidLoad];
    kit = [STKit sharedInstance];
    [self setupTitleBar];
    [self setupSessionView];
}

- (void) setupTitleBar{
    bar = [UIView new];
    [self.view addSubview: bar];
    UILayoutGuide * layoutGuide;
    if (@available(iOS 11, *)) {
        layoutGuide = self.view.safeAreaLayoutGuide;
     
    } else {
        layoutGuide = self.view.layoutMarginsGuide;
    }
    bar.translatesAutoresizingMaskIntoConstraints = NO;
    [bar.leadingAnchor constraintEqualToAnchor:layoutGuide.leadingAnchor].active = YES;
    [bar.trailingAnchor constraintEqualToAnchor:layoutGuide.trailingAnchor].active = YES;
    [bar.topAnchor constraintEqualToAnchor:layoutGuide.topAnchor].active = YES;
    [bar.heightAnchor constraintEqualToConstant: 80].active = YES;
    
    UIButton* button = [UIButton buttonWithType: UIButtonTypeCustom];
    [button setTitle: @"Close" forState: UIControlStateNormal];
    [button setTitleColor: UIColor.blackColor forState:UIControlStateNormal];
    [button setTitleColor: UIColor.grayColor forState:UIControlStateHighlighted];
    [button addTarget: self action:@selector(close) forControlEvents: UIControlEventTouchUpInside];
    [bar addSubview:button];
    
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button.leadingAnchor constraintEqualToAnchor:bar.leadingAnchor constant: 20].active = YES;
    [button.centerYAnchor constraintEqualToAnchor:bar.centerYAnchor].active = YES;
    
    UILabel* label = [UILabel new];
    label.text = @"Choose a seesion";
    label.font = [UIFont systemFontOfSize: 18 weight:UIFontWeightMedium];
    [bar addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = false;
    [label.centerXAnchor constraintEqualToAnchor:bar.centerXAnchor].active = YES;
    [label.centerYAnchor constraintEqualToAnchor:bar.centerYAnchor].active = YES;
}

- (void) close{
    [[self presentingViewController] dismissViewControllerAnimated: YES completion:^{} ];
}

-(void) setupSessionView{
    sessionView = [UITableView new];
    sessionView.dataSource = self;
    sessionView.delegate = self;
    
    sessionView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    sessionView.separatorInset = UIEdgeInsetsMake(0, 70, 0, 0.5);
    sessionView.tableFooterView = [UIView new];

    [self.view addSubview: sessionView];
    sessionView.translatesAutoresizingMaskIntoConstraints = NO;
    UILayoutGuide * layoutGuide;
    if (@available(iOS 11, *)) {
        layoutGuide = self.view.safeAreaLayoutGuide;
     
    } else {
        layoutGuide = self.view.layoutMarginsGuide;
    }
    [sessionView.leadingAnchor constraintEqualToAnchor:layoutGuide.leadingAnchor].active = YES;
    [sessionView.trailingAnchor constraintEqualToAnchor:layoutGuide.trailingAnchor].active = YES;
    [sessionView.topAnchor constraintEqualToAnchor:bar.bottomAnchor].active = YES;
    [sessionView.bottomAnchor constraintEqualToAnchor:layoutGuide.bottomAnchor].active = YES;
    
    
    STKit* kit = [STKit sharedInstance];
    [self setupSessions];
}

- (void) setupSessions{
    sessionList = [kit getSessionList];

    dataManager = [QTalkSessionDataManager new];
    [dataManager setQtBlock:^{
        sessionList = [kit getSessionList];
        [sessionView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return sessionList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger row = indexPath.row;
    NSDictionary *dict = sessionList[row];
    NSString *chatId = [dict objectForKey:@"XmppId"];
    NSString *realJid = [dict objectForKey:@"RealJid"];
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell ChatId(%@) RealJid(%@) %d", chatId, realJid, indexPath.row];
    QTalkNewSessionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[QTalkNewSessionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setIndexPath:indexPath];
    [cell setAccessibilityIdentifier:chatId];
    cell.infoDic = dict;
    [cell refreshUI];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [QTalkNewSessionTableViewCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger selectedRow = indexPath.row;
    NSDictionary *dict = sessionList[selectedRow];
    [self showConfirmAlert:dict];
    
}

- (void) showConfirmAlert: (NSDictionary* )session{
    NSString* name = session[@"Name"];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Confirm sending to:"
                                   message: name
                                   preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style: UIAlertActionStyleCancel handler: nil];
    [alert addAction:cancelAction];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
        [self sendItems: session];
    }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) sendItems: (NSDictionary* )session{
    STShareExtensionHelper * shareHelper = [STShareExtensionHelper sharedInstance];
    items = [shareHelper shareItems];
    sendingCount = items.count;
    
    [self showIndicator];
    for(NSDictionary* item in items){
        NSString * type = item[@"type"];
        NSString* name = item[@"name"];
        NSString* path = item[@"path"];
        if([type isEqualToString:@"image"]){
            [self sendImage: path session:session];
        }else if([type isEqualToString:@"movie"]){
            [self sendMovie:path name:name session:session];
        }else{
            [self sendFile:path name:name session:session];
        }
    }
}

- (void) showIndicator{
    UIView* background = [UIView new];
    background.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.2];
    background.layer.cornerRadius = 5;
    background.clipsToBounds = YES;
    [self.view addSubview:background];
    background.translatesAutoresizingMaskIntoConstraints = NO;
    [background.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [background.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [background.widthAnchor constraintEqualToConstant:100].active = YES;
    [background.heightAnchor constraintEqualToConstant:100].active = YES;
    
    UIActivityIndicatorView* indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    [self.view addSubview:indicatorView];
    indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [indicatorView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [indicatorView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    
    [indicatorView startAnimating];
}

- (void) sendImage: (NSString *) path session: (NSDictionary *) session{
    NSData* data = [NSData dataWithContentsOfFile:path];
    NSString * localPath = [kit qim_saveImageData:data];
    UIImage *image = [UIImage imageWithData: data];
    CGFloat width = CGImageGetWidth(image.CGImage);
    CGFloat height = CGImageGetHeight(image.CGImage);
    
    NSString* chatId = [session objectForKey:@"XmppId"];
    ChatType chatType = [[session objectForKey:@"ChatType"] intValue];

    NSString *msgText = [NSString stringWithFormat:@"[obj type=\"image\" value=\"LocalFileName=%@\" width=%f height=%f]", localPath, width, height];
    STMsgModel *msg = [kit createMessageWithMsg:msgText extenddInfo:nil userId:chatId userType:chatType msgType:QIMMessageType_Text];
    [kit saveMsg:msg ByJid:chatId];
    [kit qim_uploadImageWithImageKey:localPath forMessage:msg];
    [self decreaseSendingCount];
}

- (void) sendMovie: (NSString *) path name: (NSString *) name session: (NSDictionary *) session{
    NSURL* url = [NSURL fileURLWithPath: path];
    AVAsset* asset = [AVURLAsset URLAssetWithURL:url options: nil];
    CMTime duration = asset.duration;
    NSInteger videoMaxTimeLen = [[kit userObjectForKey:@"videoMaxTimeLen"] integerValue];
    float durationValue = CMTimeGetSeconds(duration) * 1000;
    
    if(durationValue > videoMaxTimeLen){
        [self sendFile:path name:name session:session];
        return;
    }
    
    name = [self makeMovieName:name];
    NSString* localPath = [self makeMoviePath:name];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:localPath]) {
        [self doSendMovie:asset name:name duration:durationValue path:localPath session:session];
    } else {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetHighestQuality];
        exportSession.outputURL = [NSURL fileURLWithPath:localPath];
        exportSession.outputFileType = AVFileTypeMPEG4;
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         {
            if(exportSession.status == AVAssetExportSessionStatusCompleted){
                [self doSendMovie:asset name:name duration:durationValue path:localPath session:session];
            }else if(exportSession.status == AVAssetExportSessionStatusFailed){
                [self decreaseSendingCount];
            }
         }];
    }
}

- (void) doSendMovie:(AVAsset *) asset name:(NSString*) name duration:(float) duration path:(NSString *) path session: (NSDictionary *) session{
    UIImage* thumbImage = [self makeMovieCover:asset];
    CGSize size = thumbImage.size;
    NSData * thumbData = UIImageJPEGRepresentation(thumbImage, 0.8);
    NSString* thumbfileName = [NSString stringWithFormat:@"%@_thumb.jpg", name.stringByDeletingPathExtension];
    NSString * thumbFilePath = [NSString stringWithFormat:@"%@_thumb.jpg", path.stringByDeletingPathExtension];
    [thumbData writeToFile:thumbFilePath atomically:YES];
    NSString* sizePresentation = [self makeFileSizePresentation:path];
    
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
    [dicInfo setQIMSafeObject:thumbFilePath forKey:@"LocalVideoThumbPath"];
    [dicInfo setQIMSafeObject:thumbFilePath forKey:@"ThumbUrl"];
    [dicInfo setQIMSafeObject:thumbfileName forKey:@"ThumbName"];
    [dicInfo setQIMSafeObject:name forKey:@"FileName"];
    [dicInfo setQIMSafeObject:@(size.width) forKey:@"Width"];
    [dicInfo setQIMSafeObject:@(size.height) forKey:@"Height"];
    [dicInfo setQIMSafeObject:sizePresentation forKey:@"FileSize"];
    [dicInfo setQIMSafeObject:@(duration) forKey:@"Duration"];
    [dicInfo setQIMSafeObject:path forKey:@"LocalVideoOutPath"];
    NSString *msgContent = [[QIMJSONSerializer sharedInstance] serializeObject:dicInfo];
    
    NSString *msgId = [QIMUUIDTools UUID];
    NSString* chatId = [session objectForKey:@"XmppId"];
    ChatType chatType = [[session objectForKey:@"ChatType"] intValue];
    STMsgModel *msg = [STMsgModel new];
    [msg setMessageId:msgId];
    [msg setMessageDirection:QIMMessageDirection_Sent];
    [msg setChatType:chatType];
    [msg setMessageType:QIMMessageType_SmallVideo];
    [msg setMessageDate:([[NSDate date] timeIntervalSince1970] - [[STKit sharedInstance] getServerTimeDiff]) * 1000];
    [msg setFrom:[[STKit sharedInstance] getLastJid]];
    [msg setRealJid:chatId];
    [msg setMessage:msgContent];
    [msg setTo:chatId];
    [msg setPlatform:IMPlatform_iOS];
    [msg setMessageSendState:QIMMessageSendState_Waiting];

    [kit saveMsg:msg ByJid:chatId];
    [kit qim_uploadVideoPath:path forMessage:msg];
    
    [self decreaseSendingCount];
}

- (void) sendFile: (NSString *) path name: (NSString *) name session: (NSDictionary *) session{
    NSData* data = [NSData dataWithContentsOfFile:path];
    [kit qim_saveLocalFileData: data withFileName:name];
    NSString * localPath = [kit qim_getLocalFileDataWithFileName:name];
    long long fileLength = data.length;
    NSString *fileSize = [QIMStringTransformTools qim_CapacityTransformStrWithSize:fileLength];
    NSString *fileMd5 = [data qim_md5String];
    NSDictionary *jsonObject = @{
                                 @"FileName": name,
                                 @"FileSize": fileSize,
                                 @"FileLength": @(fileLength),
                                 @"FileMd5": fileMd5 ? fileMd5 : @"",
                                 @"IPLocalPath": name,
                                 @"Uploading": @(1)
                                 };
    NSString* chatId = [session objectForKey:@"XmppId"];
    ChatType chatType = [[session objectForKey:@"ChatType"] intValue];
    NSString *extendInfo = [[QIMJSONSerializer sharedInstance] serializeObject:jsonObject];
    STMsgModel *msg = [kit createMessageWithMsg:extendInfo extenddInfo:extendInfo userId:chatId userType:chatType msgType:QIMMessageType_File];

    [kit saveMsg:msg ByJid:chatId];
    [kit qim_uploadFileWithFilePath:localPath forMessage:msg];
    
    [self decreaseSendingCount];
}

- (NSString *) makeMovieName: (NSString*) name{
    name = name.stringByDeletingPathExtension;
    return [NSString stringWithFormat:@"video_%@.mp4", name];
}

- (NSString *) makeMoviePath: (NSString *) name{
    NSString* directory = [kit getDownloadFilePath];
    return [NSString stringWithFormat:@"%@/%@", directory, name];
}

- (UIImage *) makeMovieCover: (AVAsset*) asset{
    AVAssetImageGenerator * generator = [AVAssetImageGenerator assetImageGeneratorWithAsset: asset];
    CMTime time = CMTimeMake(0, 1);
    CGImageRef cgImage = [generator copyCGImageAtTime: time actualTime:nil error:nil];
    if(cgImage != nil){
        return [UIImage imageWithCGImage: cgImage];;
    }else{
        return [UIImage new];
    }
}

- (NSString*) makeFileSizePresentation:(NSString *) path{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    long long filesize = 0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];
        filesize = [[fileDic objectForKey:NSFileSize] longLongValue];
    }
    
    return [QIMStringTransformTools qim_CapacityTransformStrWithSize: filesize];

}

- (void) decreaseSendingCount{
    dispatch_async(dispatch_get_main_queue(), ^{
        sendingCount = sendingCount - 1;
        if(sendingCount == 0){
            STShareExtensionHelper * shareHelper = [STShareExtensionHelper sharedInstance];
            [shareHelper cleanItems];
            [self close];
        }
    });
}


@end
