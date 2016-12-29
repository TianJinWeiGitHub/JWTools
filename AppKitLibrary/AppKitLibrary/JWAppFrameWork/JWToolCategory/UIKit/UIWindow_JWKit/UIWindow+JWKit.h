//
//  UIWindow+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Show touch on screen
 */
#define BFShowTouchOnScreen [UIApplication.sharedApplication.keyWindow activateTouch]

/**
 *  Hide touch on screen
 */
#define BFHideTouchOnScreen [UIApplication.sharedApplication.keyWindow deactivateTouch]

/**
 *  This category adds some useful methods to UIWindow
 *
 *  BFShowTouchOnScreen: Show touch on screen
 *
 *  BFHideTouchOnScreen: Hide touch on screen
 */


@interface UIWindow (JWKit)

/**
 *  Take a screenshot of current window, without saving it
 *
 *  @return Returns the screenshot as an UIImage
 */
- (UIImage *)takeScreenshot;

/**
 *  Take a screenshot of current window and choose if save it or not
 *
 *  @param save YES to save, NO to don't save
 *
 *  @return Returns the screenshot as an UIImage
 */
- (UIImage *)takeScreenshotAndSave:(BOOL)save;

/**
 *  Take a screenshot of current window, choose if save it or not after a delay
 *
 *  @param delay      The delay, in seconds
 *  @param save       YES to save, NO to don't save
 *  @param completion Completion handler with the UIImage
 */
- (void)takeScreenshotWithDelay:(CGFloat)delay save:(BOOL)save completion:(void (^)(UIImage *screenshot))completion;

/**
 *  Show touch on screen. (Use BFShowTouchOnScreen macro)
 */
- (void)activateTouch;

/**
 *  Hide touch on screen. (Use BFHideTouchOnScreen macro)
 */
- (void)deactivateTouch;

/*!
 @method topMostController
 
 @return Returns the current Top Most ViewController in hierarchy.
 */
- (UIViewController*) topMostController;

/*!
 @method currentViewController
 
 @return Returns the topViewController in stack of topMostController.
 */
- (UIViewController*)currentViewController;




@end
