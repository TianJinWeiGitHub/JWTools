//
//  UIScrollView+ScalableCover.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/23.
//  Copyright © 2015年 jinwei group. All rights reserved.
//   可以缩放的scrollview

#import <UIKit/UIKit.h>

static const CGFloat MaxHeight = 200;


@interface ScalableCover : UIImageView

@property (nonatomic, weak) UIScrollView *scrollView;

@end


@interface UIScrollView (ScalableCover)

@property (nonatomic, weak) ScalableCover *scalableCover;

- (void)addScalableCoverWithImage:(UIImage *)image;

- (void)removeScalableCover;


@end
