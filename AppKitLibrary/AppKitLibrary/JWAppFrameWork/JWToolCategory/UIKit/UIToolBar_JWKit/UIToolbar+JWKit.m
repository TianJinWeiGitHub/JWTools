//
//  UIToolbar+JWKit.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "UIToolbar+JWKit.h"

@implementation UIToolbar (JWKit)

- (void)setTransparent:(BOOL)transparent
{
    if(transparent)
    {
        [self setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];
    }
    else
    {
        [self setBackgroundImage:nil forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self setShadowImage:nil forToolbarPosition:UIBarPositionAny];
    }
}

@end
