//
//  UINavigationBar+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (JWKit)

/**
 *  Set the UINavigationBar to transparent or not
 *
 *  @param transparent YES to set it transparent, NO to not
 */
- (void)setTransparent:(BOOL)transparent;

/**
 *  Set the UINavigationBar to transparent or not
 *
 *  @param transparent YES to set it transparent, NO to not
 *  @param translucent A Boolean value indicating whether the navigation bar is translucent or not
 */
- (void)setTransparent:(BOOL)transparent translucent:(BOOL)translucent;

@end
