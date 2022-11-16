//
//  STImagePasteVC.m
//  QIMUIKit
//
//  Created by busylei on 2022/11/15.
//

#import "STImagePasteVC.h"
#import "QIMCommonUIFramework.h"

@interface STImagePasteVC ()

@end

@implementation STImagePasteVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViews];
}

- (void) setViews{
    if (_image){
        self.view.backgroundColor = [[UIColor alloc] initWithWhite: 0 alpha: 0.3];
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(cancel)];
        [self.view addGestureRecognizer: tapGesture];
        
        CGSize viewSize = self.view.bounds.size;
        CGSize imageSize = _image.size;
    
        CGFloat imageViewWidth = viewSize.width * 0.8;
        CGFloat imageViewHeight = imageViewWidth / imageSize.width * imageSize.height;
        CGFloat suspectedImageHeight = viewSize.height * 0.7;
        if(imageViewHeight > suspectedImageHeight){
            imageViewHeight = suspectedImageHeight;
        }
        CGFloat containerWidth = imageViewWidth + 20;
        CGFloat containerHeight = imageViewHeight + 20 + 40;
        
        UIView* container = [[UIView alloc] initWithFrame: CGRectMake((viewSize.width - containerWidth) / 2, (viewSize.height - containerHeight) / 2, containerWidth, containerHeight)];
        if (@available(iOS 13.0, *)) {
            container.backgroundColor = UIColor.systemBackgroundColor;
        } else {
            container.backgroundColor = UIColor.whiteColor;
        }
        container.layer.cornerRadius = 5;
        [self.view addSubview: container];
        
        UIImageView* imageView = [[UIImageView alloc] initWithImage: _image];
        imageView.frame = CGRectMake(10, 10, imageViewWidth, imageViewHeight);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [container addSubview: imageView];
        
        UIButton* cancelButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [cancelButton setTitle: [NSBundle qim_localizedStringForKey:@"common_cancel"] forState: UIControlStateNormal];
        [cancelButton addTarget: self action: @selector(cancel) forControlEvents: UIControlEventTouchUpInside];
        [cancelButton sizeToFit];
        cancelButton.center = CGPointMake(containerWidth / 4, containerHeight - 20);
        [cancelButton setTitleColor: UIColor.systemBlueColor forState: UIControlStateNormal];
        [container addSubview: cancelButton];
        
        UIButton* sendButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [sendButton setTitle: [NSBundle qim_localizedStringForKey:@"common_send"] forState: UIControlStateNormal];
        [sendButton addTarget: self action: @selector(send) forControlEvents: UIControlEventTouchUpInside];
        [sendButton sizeToFit];
        sendButton.center = CGPointMake(containerWidth / 4 * 3, containerHeight - 20);
        [sendButton setTitleColor: UIColor.systemBlueColor forState: UIControlStateNormal];
        [container addSubview: sendButton];
    }
}

- (void) cancel{
    [self dismissViewControllerAnimated: true completion:^{
        
    }];
}

- (void) send{
    NSData *imageData = UIImageJPEGRepresentation(_image, 0.8);
    NSString *imagePath = [[STKit sharedInstance] qim_saveImageData:imageData];
    [_delegate qim_textbarSendImageWithImagePath:imagePath];
    
    [self dismissViewControllerAnimated: true completion:^{
        
    }];
}

@end
