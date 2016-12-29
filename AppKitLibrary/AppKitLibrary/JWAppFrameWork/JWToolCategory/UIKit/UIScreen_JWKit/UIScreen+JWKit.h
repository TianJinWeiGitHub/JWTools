//
//  UIScreen+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  Get the screen width and height
 */
#define SCREEN_WIDTH [[UIScreen mainScreen] fixedScreenSize].width
#define SCREEN_HEIGHT [[UIScreen mainScreen] fixedScreenSize].height



@interface UIScreen (JWKit)

/**
 *  Check if the current device has a Retina display
 *
 *  @return Returns YES if it has a Retina display, NO if not
 */
+ (BOOL)isRetina;

/**
 *  Check if the current device has a Retina display
 *
 *  @return Returns YES if it has a Retina HD display, NO if not
 */
+ (BOOL)isRetinaHD;

/**
 *  Returns the fixed screen size, based on device orientation
 *
 *  @return Returns a GCSize with the fixed screen size
 */
- (CGSize)fixedScreenSize;

@end
