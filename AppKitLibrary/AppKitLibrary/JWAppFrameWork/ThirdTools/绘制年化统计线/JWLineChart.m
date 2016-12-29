//
//  JWLineChart.m
//  AppKitLibrary
//
//  Created by jinwei on 15/11/30.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "JWLineChart.h"
#import <QuartzCore/QuartzCore.h>

#define LineChartLineColor [UIColor colorWithRed:218.0/255 green:218.0/255 blue:218.0/255 alpha:1]

@interface JWLineChart ()
{
    float leftSpace;
}
@property (nonatomic, strong) NSMutableArray* data;

@property (nonatomic) CGFloat min;
@property (nonatomic) CGFloat max;
@property (nonatomic) CGMutablePathRef initialPath;
@property (nonatomic) CGMutablePathRef newPath;

@end

@implementation JWLineChart
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setDefaultParameters];
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)setChartData:(NSArray *)chartData
{
    NSAssert([chartData count]!=0, @"数据不能为空");

    _data = [NSMutableArray arrayWithArray:chartData];
    
    _min = MAXFLOAT;
    _max = -MAXFLOAT;
    
    for(int i = 0; i < _data.count; i++) {
        NSNumber* number = _data[i];
        if([number floatValue] < _min)
            _min = [number floatValue];
        
        if([number floatValue] > _max)
            _max = [number floatValue];
    }
    
    _max = [self getUpperRoundNumber:_max forGridStep:5];
    
    if(isnan(_max)) {
        _max = 1;
    }
    [self strokeChart];
    
    //设置下标显示
    if(_labelForIndex) {
        int q = (int)_data.count ;
        for(int i = 0 ; i < q ; i++) {
            NSInteger itemIndex = q * i;
            if(itemIndex >= _data.count)
            {
                itemIndex = _data.count - 1;
            }
            NSString* text = _labelForIndex(itemIndex);
            CGPoint p = CGPointMake(i * _spaceWidth+leftSpace, _axisHeight + _margin);
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - _spaceWidth/2.0, p.y + 2, _spaceWidth, 16)];
            label.text = text;
            label.textAlignment = 1;
            label.font = [UIFont boldSystemFontOfSize:10.0f];
            label.textColor = [UIColor grayColor];
            [self addSubview:label];
        }
    }
    
    [self setContentSize:CGSizeMake(_spaceWidth *chartData.count+10, self.frame.size.height)];
}
- (void)drawRect:(CGRect)rect
{
    
}

- (void)strokeChart
{
    
    UIBezierPath *path      = [UIBezierPath bezierPath];
    UIBezierPath *noPath    = [UIBezierPath bezierPath];
    UIBezierPath *fill      = [UIBezierPath bezierPath];
    UIBezierPath *noFill    = [UIBezierPath bezierPath];
    
    CGFloat scale = _axisHeight / _max;
    NSNumber* first = _data[0];
    
    for(int i=1;i<_data.count;i++) {
        NSNumber* last = _data[i - 1];
        NSNumber* number = _data[i];
        
        CGPoint p1 = CGPointMake(leftSpace + (i - 1) * _spaceWidth, _axisHeight + _margin - [last floatValue] * scale);
        
        CGPoint p2 = CGPointMake(leftSpace + i * _spaceWidth, _axisHeight + _margin - [number floatValue] * scale);
        
        [fill moveToPoint:p1];
        [fill addLineToPoint:p2];
        [fill addLineToPoint:CGPointMake(p2.x, _axisHeight + _margin)];
        [fill addLineToPoint:CGPointMake(p1.x, _axisHeight + _margin)];
        
        [noFill moveToPoint:CGPointMake(p1.x, _axisHeight + _margin)];
        [noFill addLineToPoint:CGPointMake(p2.x, _axisHeight + _margin)];
        [noFill addLineToPoint:CGPointMake(p2.x, _axisHeight + _margin)];
        [noFill addLineToPoint:CGPointMake(p1.x, _axisHeight + _margin)];
    }
    
    
    [path moveToPoint:CGPointMake(leftSpace, _axisHeight + _margin - [first floatValue] * scale)];
    [noPath moveToPoint:CGPointMake(leftSpace, _axisHeight + _margin)];
    
    for(int i=1;i<_data.count;i++) {
        
        NSNumber* number = _data[i];
        [path addLineToPoint:CGPointMake(leftSpace + i * _spaceWidth, _axisHeight + _margin - [number floatValue] * scale)];
        [noPath addLineToPoint:CGPointMake(leftSpace + i *_spaceWidth, _axisHeight + _margin)];
        
    }
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.frame = self.bounds;
    fillLayer.bounds = self.bounds;
    fillLayer.path = fill.CGPath;
    fillLayer.strokeColor = nil;
    fillLayer.fillColor = [_color colorWithAlphaComponent:0.25].CGColor;
    fillLayer.lineWidth = 0;
    fillLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:fillLayer];
    
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.bounds;
    pathLayer.bounds = self.bounds;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [_color CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 2;
    pathLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:pathLayer];
    
    CABasicAnimation *fillAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    fillAnimation.duration = 0.25;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.fromValue = (id)noFill.CGPath;
    fillAnimation.toValue = (id)fill.CGPath;
    [fillLayer addAnimation:fillAnimation forKey:@"path"];
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = 0.25;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = (__bridge id)(noPath.CGPath);
    pathAnimation.toValue = (__bridge id)(path.CGPath);
    [pathLayer addAnimation:pathAnimation forKey:@"path"];
    
    
    
    
    //圆点和线
    for(int i= 0 ;i<_data.count;i++) {
        
        CAShapeLayer *solidLine =  [CAShapeLayer layer];
        CGMutablePathRef solidPath =  CGPathCreateMutable();
        solidLine.lineWidth = 0.f ;
        solidLine.strokeColor = [UIColor lightGrayColor].CGColor;
        solidLine.fillColor = LineChartLineColor.CGColor;
        CGPathAddEllipseInRect(solidPath, nil, CGRectMake(i*_spaceWidth+leftSpace-2,_axisHeight+_margin-2, 4, 4));
        solidLine.path = solidPath;
        CGPathRelease(solidPath);
        [self.layer addSublayer:solidLine];
        
        CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
        CGMutablePathRef solidShapePath =  CGPathCreateMutable();
        [solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
        [solidShapeLayer setStrokeColor:LineChartLineColor.CGColor];
        solidShapeLayer.lineWidth = .5f ;
        CGPathMoveToPoint(solidShapePath, NULL, i*_spaceWidth+leftSpace, 20);
        CGPathAddLineToPoint(solidShapePath, NULL, i*_spaceWidth+leftSpace,_axisHeight+_margin-2);
        [solidShapeLayer setPath:solidShapePath];
        CGPathRelease(solidShapePath);
        [self.layer addSublayer:solidShapeLayer];
    }
    
    //当前的原
    NSNumber* last = [_data lastObject];
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    CGMutablePathRef solidPath =  CGPathCreateMutable();
    solidLine.lineWidth = 2.f ;
    solidLine.strokeColor = [UIColor orangeColor].CGColor;
    solidLine.fillColor = [UIColor whiteColor].CGColor;
    CGPathAddEllipseInRect(solidPath, nil, CGRectMake(leftSpace + ([_data count]-1)* _spaceWidth-4,_axisHeight + _margin - [last floatValue] * scale-4, 8, 8));
    solidLine.path = solidPath;
    CGPathRelease(solidPath);
    [self.layer addSublayer:solidLine];
}

- (void)setDefaultParameters
{
    _color = [UIColor colorWithRed:0.18f green:0.67f blue:0.84f alpha:1.0f];;
    _margin = 5.0f;
    _axisWidth = self.frame.size.width - 2 * _margin;
    _spaceWidth = 50;
    _axisHeight = self.frame.size.height - 2 * _margin-20;
    _axisColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    leftSpace = 30;
}


- (CGFloat)getUpperRoundNumber:(CGFloat)value forGridStep:(int)gridStep
{
    CGFloat logValue = log10f(value);
    CGFloat scale = powf(10, floorf(logValue));
    CGFloat n = ceilf(value / scale * 2);
    
    int tmp = (int)(n) % gridStep;
    
    if(tmp != 0) {
        n += gridStep - tmp;
    }
    
    return n * scale / 2.0f;
}

@end
