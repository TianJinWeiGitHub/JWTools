//
//  UIBarButtonItem+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JWKit)

/**
 *  Create an UIBarButtonItem with type setted to FlexibleSpace
 *
 *  @return Returns the created UIBarButtonItem
 */
- (instancetype)initWithBarButtonFlexibleSpace;

/**
 *  Create an UIBarButtonItem with type setted to FlexibleSpace or FixedSpace
 *
 *  @param spaceType Must be FlexibleSpace or FixedSpace, otherwise a FlexibleSpace UIBarButtonItem will be created
 *  @param width     To use only if space is setted to FixedSpace, and it will be the width of it
 *
 *  @return Returns the created UIBarButtonItem
 */
- (instancetype)initWithBarButtonSpaceType:(UIBarButtonSystemItem)spaceType width:(CGFloat)width;

@end
