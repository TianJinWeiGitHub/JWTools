//
//  UIColor+themeColor.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/23.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

//夜间模式
#define JWNightModel [[NSUserDefaults standardUserDefaults]objectForKey:@"jwNightModel"]


@interface UIColor (themeColor)

+ (UIColor *)JWColorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)JWColorWithHex:(int)hexValue;

+ (UIColor *)JWthemeColor;
+ (UIColor *)JWnameColor;
+ (UIColor *)JWtitleColor;
+ (UIColor *)JWseparatorColor;
+ (UIColor *)JWcellsColor;
+ (UIColor *)JWtitleBarColor;
+ (UIColor *)JWselectTitleBarColor;
+ (UIColor *)JWnavigationbarColor;
+ (UIColor *)JWselectCellSColor;
+ (UIColor *)JWlabelTextColor;
+ (UIColor *)JWteamButtonColor;

+ (UIColor *)JWinfosBackViewColor;
+ (UIColor *)JWlineColor;

+ (UIColor *)JWcontentTextColor;
+ (UIColor *)JWborderColor;
+ (UIColor *)JWrefreshControlColor;


@end
