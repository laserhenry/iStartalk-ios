//
//  QTImageAssetCell.m
//  qunarChatIphone
//
//  Created by admin on 15/8/18.
//
//

#import "STImgAssetCell.h"

#import "STImgAssetView.h"

#import "STImgAssetViewController.h"

#define kAssetViewTagPriex  10001

@interface STImgAssetCell()<STImgAssetViewDelegate>

@end

@implementation STImgAssetCell

+ (CGFloat)getCellHeight{
    return kImageCap + imageItemWidth;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        for (int i = 0; i < kColoumn; i++) {
            STImgAssetView *assetView=[[STImgAssetView alloc] initWithFrame:CGRectMake((imageItemWidth+kImageCap)*i, kImageCap, imageItemWidth, imageItemWidth)];
            [assetView setDelegate:self];
            [assetView setTag:kAssetViewTagPriex+i];
            [self.contentView addSubview:assetView];
        }
    }
    return self;
}

- (void)refreshUI{
    for (int i = 0; i < kColoumn; i++) {
        STImgAssetView *assetView = (STImgAssetView *)[self.contentView viewWithTag:kAssetViewTagPriex+i];
        if (i < self.assets.count) {
            [assetView setHidden:NO];
            ALAsset *asset = [self.assets objectAtIndex:i];
            NSArray *list = [((STImgAssetViewController*)_delegate) indexPathsForSelectedItems];
            [assetView bind:asset selectionFilter:self.selectionFilter isSeleced:[list containsObject:self.assets[i]]];
        } else {
            [assetView setHidden:YES];
        }
    }
}

#pragma mark - ZYQAssetView Delegate

-(BOOL)shouldSelectAsset:(ALAsset *)asset{
    if (_delegate!=nil&&[_delegate respondsToSelector:@selector(shouldSelectAsset:)]) {
        return [_delegate shouldSelectAsset:asset];
    }
    return YES;
}

-(void)tapSelectHandle:(BOOL)select asset:(ALAsset *)asset{
    if (select) {
        if (_delegate!=nil&&[_delegate respondsToSelector:@selector(didSelectAsset:)]) {
            [_delegate didSelectAsset:asset];
        }
    }
    else{
        if (_delegate!=nil&&[_delegate respondsToSelector:@selector(didDeselectAsset:)]) {
            [_delegate didDeselectAsset:asset];
        }
    }
}


@end
