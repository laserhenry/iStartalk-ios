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
    
        CGFloat containerWidth = viewSize.width * 0.8;
        CGFloat containerHeight = containerWidth / imageSize.width * imageSize.height;
        CGFloat suspectedContainerHeight = viewSize.height * 0.8;
        if(containerHeight > suspectedContainerHeight){
            containerHeight = suspectedContainerHeight;
        }
        CGFloat imageViewWidth = containerWidth - 10;
        CGFloat imageViewHeight = containerHeight - 10;
        containerHeight = containerHeight + 40;
        
        UIView* container = [[UIView alloc] initWithFrame: CGRectMake((viewSize.width - containerWidth) / 2, (viewSize.height - containerWidth) / 2, containerWidth, containerHeight)];
        if (@available(iOS 13.0, *)) {
            container.backgroundColor = UIColor.systemBackgroundColor;
        } else {
            container.backgroundColor = UIColor.whiteColor;
        }
        [self.view addSubview: container];
        
        UIImageView* imageView = [[UIImageView alloc] initWithImage: _image];
        imageView.frame = CGRectMake((containerWidth - imageViewWidth) / 2, (containerHeight - 40 - imageViewHeight) / 2, imageViewWidth, imageViewHeight);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [container addSubview: imageView];
        
        UIButton* cancelButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [cancelButton setTitle: @"Cancel" forState: UIControlStateNormal];
        [cancelButton addTarget: self action: @selector(cancel) forControlEvents: UIControlEventTouchUpInside];
        [cancelButton sizeToFit];
        cancelButton.center = CGPointMake(containerWidth / 4, containerHeight - 20);
        [cancelButton setTitleColor: UIColor.systemBlueColor forState: UIControlStateNormal];
        [container addSubview: cancelButton];
        
        UIButton* sendButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [sendButton setTitle: @"Send" forState: UIControlStateNormal];
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
