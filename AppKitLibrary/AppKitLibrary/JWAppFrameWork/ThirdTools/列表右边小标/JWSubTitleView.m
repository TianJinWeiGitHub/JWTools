//
//  JWSubTitleView.m
//  AppKitLibrary
//
//  Created by secoo02 on 15/11/23.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "JWSubTitleView.h"

//颜色
#define JWColor(a,b,c,d) [UIColor colorWithRed:(a)/255. green:(b)/255. blue:(c)/255. alpha:(d)]

//时间
#define time 0.3

@interface JWSubTitleView ()

@property (nonatomic,assign)CGFloat singleLabelH;

@property (nonatomic,assign)int selectTag;

@end

@implementation JWSubTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.selectTag=-1;
    }
    return self;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint beganPoint = [touch locationInView:self];
    int tag=beganPoint.y/self.singleLabelH;
    [self makeBeganMove:tag andPoint:beganPoint];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint touchMove = [touch locationInView:self];
    int tag=touchMove.y/self.singleLabelH;
    [self makeMove:tag andPoint:touchMove];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint touchEnd = [touch locationInView:self];
    int tag = touchEnd.y/self.singleLabelH;
    [self makeEndMove:tag andPoint:touchEnd];
}

-(void)makeBeganMove:(int)tag andPoint:(CGPoint)point{
    
    for (JWSubTitleLabel *label in self.subviews) {

        //当前
        if (label.tag==tag) {
            [self makeLabelMove:label andToValue:-40 andFromValue:label.fromValue];
        }
        //上边
        if (label.tag>=tag-4 && label.tag>=0 && label.tag<tag) {
            int toValue =(int)-(4-(tag-label.tag))*10 ;
            [self makeLabelMove:label andToValue:toValue andFromValue:label.fromValue];
        }
        //下边
        if (label.tag<self.dataArray.count && label.tag<=tag+4 && label.tag>tag) {
            [self makeLabelMove:label andToValue:(int)-(4-(-tag+label.tag))*10 andFromValue:label.fromValue];
        }
    }
}

//触摸的时候的动画
-(void)makeMove:(int)tag andPoint:(CGPoint)point{
    
    
    if (tag==self.selectTag) {
        return;
    }
    self.selectTag = tag;
    
    //其余的
    for (JWSubTitleLabel *label in self.subviews) {
        assert(label.tag>=0);
        assert(label.tag<self.dataArray.count);
        //最在上面
        if (tag-4>label.tag) {
            [self makeLabelMove:label andToValue:0 andFromValue:label.fromValue];
        }
        //上边
        else if (label.tag>=tag-4 && label.tag<tag) {
            [self makeLabelMove:label andToValue:(int)-(4-(tag-label.tag))*10 andFromValue:label.fromValue];
        }
        //中间的那个
        else if (label.tag==tag) {
            [self makeLabelMove:label andToValue:-40 andFromValue:label.fromValue];
        }
        //下边的
        else if (label.tag<tag+4 && label.tag>tag) {
            [self makeLabelMove:label andToValue:(int)-(4-(-tag+label.tag))*10 andFromValue:label.fromValue];
        }
        //最下面的几个 或者没有 回归原位 条件是//(label.tag>tag+4)
        else {
            [self makeLabelMove:label andToValue:0 andFromValue:label.fromValue];
        }
        
    }
    
}

//触摸结束的时候的动画
-(void)makeEndMove:(int)tag andPoint:(CGPoint)point{
    
    //通知代理 滑动tableView
    if ([self.delegate respondsToSelector:@selector(touchEndPoint:andWithSelectedTag:)]) {
        [_delegate touchEndPoint:point andWithSelectedTag:tag];
    }
    //所有的回归原位
    for (JWSubTitleLabel *label in self.subviews) {
        [self makeLabelMove:label andToValue:0 andFromValue:label.fromValue];
        
    }
    
}

-(void)makeLabelMove:(JWSubTitleLabel *)label andToValue:(int)toValue andFromValue:(int)fromValue{
    
    //偏转
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.duration=time;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.keyPath = @"transform.translation.x";
    anim.fromValue = @(fromValue);
    anim.toValue = @(toValue);
    label.fromValue=toValue;
    [label.layer addAnimation:anim forKey:@"trans"];
    //改变颜色
    int colorMultiple = -toValue/10;
    
    if (colorMultiple!=4) {
        int colorAdd = colorMultiple * 35 + 123;
        label.textColor = JWColor(colorAdd, colorAdd, colorAdd,1);
    }else {
        label.textColor = JWColor(0, 0, 0, 1);//黑色
    }
    
    
}

//数据过来之后创建子控件
-(void)setDataArray:(NSMutableArray *)dataArray{
    
    _dataArray = dataArray;
    for (int i = 0; i<_dataArray.count; i++) {
        JWSubTitleLabel *titleLabel = [[JWSubTitleLabel alloc]init];
        titleLabel.text = _dataArray[i];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = JWColor(123, 123, 123, 1);
        titleLabel.tag=i;
        [self addSubview:titleLabel];
    }
    
}
//为子控件设置frame
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    for (JWSubTitleLabel *label in self.subviews) {
        CGFloat labelH=self.frame.size.height/(_dataArray.count);
        CGFloat labelY=label.tag * labelH;
        CGFloat labelW=self.frame.size.width;
        CGFloat labelX=0;
        label.frame=CGRectMake(labelX, labelY, labelW, labelH);
    }
    self.singleLabelH =self.frame.size.height / self.dataArray.count;
    
}


@end

@implementation JWSubTitleLabel

@end