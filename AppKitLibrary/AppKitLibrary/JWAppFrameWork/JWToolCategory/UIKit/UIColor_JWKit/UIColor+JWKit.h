//
//  UIColor+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JWKit)
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define RGB(r, g, b) RGBA(r, g, b, 1.0f)


@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat white;
@property (nonatomic, readonly) CGFloat hue;
@property (nonatomic, readonly) CGFloat saturation;
@property (nonatomic, readonly) CGFloat brightness;
@property (nonatomic, readonly) CGFloat alpha;
@property (nonatomic, readonly) CGFloat luminance;

+ (UIColor *)hex:(NSString *)hexString;

+ (UIColor *)hexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString DEPRECATED_MSG_ATTRIBUTE("Use +hex");

+ (UIColor *)colorWithHex:(unsigned int)hex;

+ (UIColor *)colorWithHex:(unsigned int)hex
                    alpha:(float)alpha;

+ (UIColor *)colorForColorString:(NSString *)colorString;

+ (UIColor *)randomColor;

+ (UIColor *)colorWithColor:(UIColor *)color
                      alpha:(float)alpha;

- (BOOL)canProvideRGBComponents;

- (UIColor *)contrastingColor;

- (UIColor *)complementaryColor;

@end
