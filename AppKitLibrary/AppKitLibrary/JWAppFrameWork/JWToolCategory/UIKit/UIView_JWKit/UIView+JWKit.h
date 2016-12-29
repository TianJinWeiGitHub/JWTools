//
//  UIView+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (JWKit)


@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;


//设置圆角半径
- (void)setCornerRadius:(CGFloat)cornerRadius;

//设置边框宽度和颜色
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color;

//视图转换为图像
- (UIImage *)convertViewToImage;

//更新模糊
//- (UIImage *)updateBlur;

@end
