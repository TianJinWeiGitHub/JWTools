//
//  UIImageView+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JWKit)

/**
 *  Create an UIImageView with the given image and frame
 *
 *  @param image UIImageView image
 *  @param rect  UIImageView frame
 *
 *  @return Returns the created UIImageView
 */
+ (instancetype)initWithImage:(UIImage *)image
                        frame:(CGRect)rect;

/**
 *  Create an UIImageView with the given image, size and center
 *
 *  @param image  UIImageView image
 *  @param size   UIImageView size
 *  @param center UIImageView center
 *
 *  @return Returns the created UIImageView
 */
+ (instancetype)initWithImage:(UIImage *)image
                         size:(CGSize)size
                       center:(CGPoint)center;

/**
 *  Create an UIImageView with the given image and center
 *
 *  @param image  UIImageView image
 *  @param center UIImageView center
 *
 *  @return Returns the created UIImageView
 */
+ (instancetype)initWithImage:(UIImage *)image
                       center:(CGPoint)center;

/**
 *  Create an UIImageView with an image and use it as a template with the given color
 *
 *  @param image     UIImageView image
 *  @param tintColor UIImageView tint color
 *
 *  @return Returns the created UIImageView
 */
+ (instancetype)initWithImageAsTemplate:(UIImage *)image
                              tintColor:(UIColor *)tintColor;

/**
 *  Create a drop shadow effect
 *
 *  @param color   Shadow's color
 *  @param radius  Shadow's radius
 *  @param offset  Shadow's offset
 *  @param opacity Shadow's opacity
 */
- (void)setImageShadowColor:(UIColor *)color
                     radius:(CGFloat)radius
                     offset:(CGSize)offset
                    opacity:(CGFloat)opacity;

/**
 *  Mask the current UIImageView with an UIImage
 *
 *  @param image The mask UIImage
 */
- (void)setMaskImage:(UIImage *)image;


@end
