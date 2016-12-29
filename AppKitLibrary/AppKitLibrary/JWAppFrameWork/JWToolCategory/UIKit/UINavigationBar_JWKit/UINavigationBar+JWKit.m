//
//  UINavigationBar+JWKit.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "UINavigationBar+JWKit.h"

@implementation UINavigationBar (JWKit)

- (void)setTransparent:(BOOL)transparent
{
    [self setTransparent:transparent translucent:YES];
}

- (void)setTransparent:(BOOL)transparent translucent:(BOOL)translucent
{
    if(transparent)
    {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
        self.translucent = translucent;
    }
    else
    {
        [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = nil;
        self.translucent = translucent;
    }
}

@end
