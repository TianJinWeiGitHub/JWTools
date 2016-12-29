//
//  UIButton+JWKit.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "UIButton+JWKit.h"
#import "UIFont+JWKit.h"
#import "UIImage+JWKit.h"
#import "UIColor+JWKit.h"

@implementation UIButton (JWKit)

+ (instancetype)initWithFrame:(CGRect)frame
{
    return [UIButton initWithFrame:frame title:nil];
}

+ (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    return [UIButton initWithFrame:frame title:title backgroundImage:nil];
}

+ (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title backgroundImage:(UIImage *)backgroundImage
{
    return [UIButton initWithFrame:frame title:title backgroundImage:backgroundImage highlightedBackgroundImage:nil];
}

+ (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    
    return button;
}

+ (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    return [UIButton initWithFrame:frame title:title backgroundImage:[UIImage imageWithColor:color] highlightedBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:components[0]-0.1 green:components[1]-0.1 blue:components[2]-0.1 alpha:1]]];
}

+ (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor
{
    return [UIButton initWithFrame:frame title:title backgroundImage:[UIImage imageWithColor:color] highlightedBackgroundImage:[UIImage imageWithColor:highlightedColor]];
}

+ (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    return [UIButton initWithFrame:frame title:nil backgroundImage:[UIImage imageWithColor:color] highlightedBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:components[0]-0.1 green:components[1]-0.1 blue:components[2]-0.1 alpha:1]]];
}

+ (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor
{
    return [UIButton initWithFrame:frame title:nil backgroundImage:[UIImage imageWithColor:color] highlightedBackgroundImage:[UIImage imageWithColor:highlightedColor]];
}

+ (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    return [UIButton initWithFrame:frame image:image highlightedImage:nil];
}

+ (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    
    return button;
}

- (void)setTitleFont:(FontName)fontName size:(CGFloat)size
{
    [self.titleLabel setFont:[UIFont fontForFontName:fontName size:size]];
}

- (void)setTitleColor:(UIColor *)color
{
    [self setTitleColor:color highlightedColor:[color colorWithAlphaComponent:0.4]];
}

- (void)setTitleColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:highlightedColor forState:UIControlStateHighlighted];
}


@end
