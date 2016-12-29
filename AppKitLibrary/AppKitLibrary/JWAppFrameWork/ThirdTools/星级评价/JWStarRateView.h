//
//  JWStarRateView.h
//  AppKitLibrary
//
//  Created by secoo02 on 15/11/20.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JWStarRateView;

@protocol JWStarRateViewDelegate <NSObject>

@optional

- (void)starRateView:(JWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;

@end

@interface JWStarRateView : UIView


@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--1，默认为1

@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO

@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO

@property (nonatomic, weak) id<JWStarRateViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;

@end



