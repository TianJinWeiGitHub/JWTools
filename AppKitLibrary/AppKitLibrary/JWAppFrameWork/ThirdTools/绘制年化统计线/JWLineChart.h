//
//  JWLineChart.h
//  AppKitLibrary
//
//  Created by jinwei on 15/11/30.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JWLineChart : UIScrollView

/** 获取标签的一组索引块定义*/
typedef NSString *(^FSLabelForIndexGetter)(NSUInteger index);



/** 间距 default 50 */
@property (nonatomic, readwrite )CGFloat spaceWidth;

@property (nonatomic, readwrite) CGFloat margin;

@property (nonatomic, readonly) CGFloat axisWidth;

@property (nonatomic, readonly) CGFloat axisHeight;

/** 框线颜色 和 内部走势颜色*/
@property (nonatomic, readwrite) UIColor* axisColor;
@property (nonatomic, readwrite) UIColor* color;

@property (copy) FSLabelForIndexGetter labelForIndex;

/** 设置的实际图表数据，然后将其呈现给视图。*/
- (void)setChartData:(NSArray *)chartData;


@end
