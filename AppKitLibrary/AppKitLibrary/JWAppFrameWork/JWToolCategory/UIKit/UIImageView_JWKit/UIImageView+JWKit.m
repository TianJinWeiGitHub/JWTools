//
//  UIImageView+JWKit.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "UIImageView+JWKit.h"

@implementation UIImageView (JWKit)

+ (instancetype)initWithImage:(UIImage *)image frame:(CGRect)rect
{
    UIImageView *_image = [[UIImageView alloc] init];
    [_image setFrame:rect];
    [_image setImage:image];
    return _image;
}

+ (instancetype)initWithImage:(UIImage *)image size:(CGSize)size center:(CGPoint)center
{
    UIImageView *_image = [[UIImageView alloc] init];
    [_image setFrame:CGRectMake(0, 0, size.width, size.height)];
    [_image setImage:image];
    [_image setCenter:center];
    return _image;
}

+ (instancetype)initWithImage:(UIImage *)image center:(CGPoint)center
{
    UIImageView *_image = [[UIImageView alloc] init];
    [_image setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [_image setImage:image];
    [_image setCenter:center];
    return _image;
}

+ (instancetype)initWithImageAsTemplate:(UIImage *)image tintColor:(UIColor *)tintColor
{
    UIImageView *_image = [[UIImageView alloc] init];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_image setImage:image];
    [_image setTintColor:tintColor];
    return _image;
}

- (void)setImageShadowColor:(UIColor *)color radius:(CGFloat)radius offset:(CGSize)offset opacity:(CGFloat)opacity
{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.clipsToBounds = NO;
}

- (void)setMaskImage:(UIImage *)image
{
    CALayer *mask = [CALayer layer];
    mask.contents = (id)[image CGImage];
    mask.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.layer.mask = mask;
    self.layer.masksToBounds = YES;
}


@end
