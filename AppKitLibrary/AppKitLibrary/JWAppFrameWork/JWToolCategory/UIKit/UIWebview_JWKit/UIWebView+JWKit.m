//
//  UIWebView+JWKit.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "UIWebView+JWKit.h"

@implementation UIWebView (JWKit)

- (void)removeBackgroundShadow
{
    for(UIView *eachSubview in [self.scrollView subviews])
    {
        if([eachSubview isKindOfClass:[UIImageView class]] && eachSubview.frame.origin.x <= 500)
        {
            eachSubview.hidden = YES;
            [eachSubview removeFromSuperview];
        }
    }
}

- (void)loadWebsite:(NSString *)website
{
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:website]]];
}

@end
