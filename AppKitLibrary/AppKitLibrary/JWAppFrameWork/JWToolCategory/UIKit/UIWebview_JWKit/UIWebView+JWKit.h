//
//  UIWebView+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (JWKit)

/**
 *  Remove the background shadow of the UIWebView
 */
- (void)removeBackgroundShadow;

/**
 *  Load the requested website
 *
 *  @param website Website to load
 */
- (void)loadWebsite:(NSString *)website;

@end
