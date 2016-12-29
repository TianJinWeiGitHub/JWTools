//
//  UIScrollView+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (JWKit)
/**
 *  Create an UIScrollView and set some parameters
 *
 *  @param frame                ScrollView's frame
 *  @param contentSize          ScrollView's content size
 *  @param clipsToBounds        Set if ScrollView has to clips to bounds
 *  @param pagingEnabled        Set if ScrollView has paging enabled
 *  @param showScrollIndicators Set if ScrollView has to show the scroll indicators, vertical and horizontal
 *  @param delegate             ScrollView's delegate
 *
 *  @return Returns the created UIScrollView
 */
+ (UIScrollView *)initWithFrame:(CGRect)frame
                    contentSize:(CGSize)contentSize
                  clipsToBounds:(BOOL)clipsToBounds
                  pagingEnabled:(BOOL)pagingEnabled
           showScrollIndicators:(BOOL)showScrollIndicators
                       delegate:(id<UIScrollViewDelegate>)delegate;


@end
