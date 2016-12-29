//
//  JWPreviewPhotoView.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/29.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "JWPreviewPhotoView.h"
#import "UIImageView+WebCache.h"
#import "JWPreviewPhotoController.h"
#import "JWSquarePhotoViewController.h"

#define photoSpace 8   //图片间距

@interface JWPreviewPhotoView ()

{
    float morePhotosize;
    NSMutableArray *photoImgViews;
    NSArray *urlArrays;
}

@end

@implementation JWPreviewPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    _row = 3;
    _margin = 10;
    morePhotosize = (self.frame.size.width-photoSpace*2-20)/3;
    
    photoImgViews = [NSMutableArray arrayWithCapacity:9];
    for (int i = 0 ; i< 9; i++) {
        UIImageView *oneImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        oneImg.contentMode = UIViewContentModeScaleAspectFill;
        oneImg.clipsToBounds = YES;
        oneImg.tag= i;
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPhotoAction:)];
        oneImg.userInteractionEnabled = YES;
        [oneImg addGestureRecognizer:tap];
        [photoImgViews addObject:oneImg];
        [self addSubview:oneImg];
    }
    self.backgroundColor = [UIColor clearColor];
}

-(void)tapPhotoAction:(UITapGestureRecognizer*)tap
{
    
    if (!urlArrays || urlArrays.count < 1) {
        return;
    }
    NSInteger tag = 1;
    UIImageView *oneImg = (UIImageView *)tap.view;
    if (oneImg) {
        if (oneImg.tag == 10) {
            oneImg.tag = 1;
        }else{
            tag = oneImg.tag+1;
        }
    }
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    JWSquarePhotoViewController *previewPhoto = [[JWSquarePhotoViewController alloc]initWithImgs:urlArrays withCurrentIndex:tag];
    [topVC presentViewController:previewPhoto animated:YES completion:nil];
    
}


- (float)setImageUrlsOfArray:(NSArray *)urls
{
    if (!urls) return 0;
    if (urls.count <1 ) return 0;
    if (urls) {
        
        morePhotosize = (self.frame.size.width-photoSpace*(self.row-1)-2*self.margin)/self.row;
        
        urlArrays = urls;
        NSInteger count = urls.count;
        for (int i = 0 ; i < count ; i++ ){
            float top_y = 0;
            if (i== 3 || i== 4 || i==5 ) {
                top_y = morePhotosize+photoSpace/2;
            }else if (i== 6 || i== 7 || i==8 ){
                top_y = morePhotosize *2 + photoSpace;
            }
            UIImageView *tempImageView = [photoImgViews objectAtIndex:i];
            tempImageView.hidden = NO;
            NSString *imgUrl = [urls objectAtIndex:i];
            [tempImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"icon_image_default.png"]];
            tempImageView.frame =  CGRectMake(self.margin+morePhotosize*(i%3)+photoSpace/2*(i%3), top_y, morePhotosize, morePhotosize);
            if (i == urls.count-1) {
                CGRect rect = self.frame;
                rect.size.height = tempImageView.frame.origin.y+tempImageView.frame.size.height;
                self.frame = rect;
            }
        }
    }
    return self.frame.size.height;
}



@end
