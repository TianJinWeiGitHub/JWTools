//
//  JWRefreshHeadView.m
//  AppKitLibrary
//
//  Created by why_ios on 2016/12/29.
//  Copyright © 2016年 jinwei group. All rights reserved.
//

#import "JWRefreshHeadView.h"

const CGFloat   jw_startOffset              = 36;
const CGFloat   jw_startRefreshOffset       = 66;
const CGFloat   jw_RefreshMargin            = 3;

#define JWRefreshColor(_alpha) [UIColor colorWithWhite:0.7 alpha:_alpha]


@interface JWRefreshHeadView()
{
    CALayer         *drawLayer;
    UILabel         *capionLabel;
    UIImage         *image;
    
    /** 是否正在刷新中状态 */
    BOOL        refreshing;
    
    /** 执行控制 */
    BOOL        canRefresh;
    
    /** 是否在进行回弹动画*/
    BOOL        backing;
    
    NSAttributedString  *finishSucess;
    NSAttributedString  *finishError;
    
    UIActivityIndicatorView *indicatorView;
    
   
  
    

    
    //回弹动画结束立即执行结束的动画
    void (^backCompleteBlock)();
    
   
}


@end

@implementation JWRefreshHeadView

#pragma mark - 位置变化
- (void)setJw_progress:(CGFloat)jw_progress
{
    if (jw_progress == _jw_progress)return;
    
    NSLog(@"%f",jw_progress);
    if (!refreshing) {
        //①开始拖出
        if (jw_progress <= jw_startOffset) {
            if (_jw_progress<=3 && jw_progress>3) {
                canRefresh = YES;
                capionLabel.alpha = 0;
                [self drawViewFromeHeight:jw_startOffset];
            }
        }
        //②拉伸阶段
        else if (jw_progress < jw_startRefreshOffset) {
            if (canRefresh) [self drawViewFromeHeight:jw_progress];
        }
        //③开始刷新
        else if (canRefresh) {
            canRefresh = NO;
            refreshing = YES;
            [self backAnimate:jw_startRefreshOffset];
            if (self.js_startRefreshBlock) {
                self.js_startRefreshBlock();
            }
        }
    }
    //④刷新状态下回弹需停顿
    else if (_jw_progress > jw_startOffset && jw_progress < jw_startRefreshOffset) {
        [self superviewScrollTo:-jw_startOffset];
        
    }
    _jw_progress = jw_progress;
    
    CGRect frame = self.frame;
    frame.size.height = MAX(jw_startOffset, jw_progress);
    frame.origin.y = -frame.size.height;
    self.frame = frame;
}

#pragma mark - 橡皮筋自动回弹动画
- (void)backAnimate:(CGFloat)animateH
{
    backing = YES;//回弹动画执行中
    //橡皮筋回弹
    CGFloat endOffset = jw_startOffset + 15;//回弹结束偏移量
    if (animateH >= endOffset) {
        animateH -= 3;
        [self drawViewFromeHeight:animateH];
        //循环调用
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.014 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self backAnimate:animateH];
        });
    }
    //显示指示器
    else{
        drawLayer.contents = nil;
        [indicatorView startAnimating];
        
        backing = NO;//回弹动画结束
        if (backCompleteBlock) {
            backCompleteBlock();
            backCompleteBlock = nil;
        }
    }
}

#pragma mark - 结束刷新
- (void)refreshFinish:(BOOL)isSuccess
{
    if (refreshing) {
        //正在进行回弹动画时，结束动画放在回弹动画结束后执行
        if (backing) {
            
            __weak __typeof (self) weakSelf = self;
            backCompleteBlock = ^{
                refreshing = NO;
                if (weakSelf) {
                    [weakSelf endAnimate:isSuccess];
                }
            };
        }
        //未进行回弹动画时，直接执行结束动画
        else {
            refreshing = NO;
            [self endAnimate:isSuccess];
        }
    }
}

#pragma mark - 结束动画
- (void)endAnimate:(BOOL)isSuccess
{
    [indicatorView stopAnimating];
    
    capionLabel.attributedText = [self endCapion:isSuccess];
    [UIView animateWithDuration:1.5 animations:^{
        capionLabel.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished && _jw_progress == jw_startOffset) {
            [self superviewScrollTo:0];//滚动到顶部
        }
    }];
}

#pragma mark - 绘制
- (void)drawViewFromeHeight:(CGFloat)h
{
    //初始化画布
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGSize size = drawLayer.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, screenScale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    //拉伸度
    CGFloat s = (h-jw_startOffset) / (jw_startRefreshOffset-jw_startOffset);
    // ①绘制橡皮筋部分
    //阴影颜色
    drawLayer.shadowColor = [UIColor colorWithWhite:0 alpha:.6+.4*s].CGColor;
    //填充颜色
    CGColorRef color = JWRefreshColor(1).CGColor;
    if (refreshing) color = JWRefreshColor(.6+.4*s).CGColor;
    CGContextSetFillColorWithColor(ctx, color);
    //大圆半径
    CGFloat w = size.width / 2.l;
    CGFloat R = w - w*.3 * (backing?1:s);
    //坐标移动至大圆圆心
    CGContextTranslateCTM(ctx, w, w+jw_RefreshMargin);
    //小圆半径
    CGFloat r = (backing?.4:1)*w*(1-s)+3*s;
    //小圆圆心
    CGPoint o = CGPointMake(0, h-w-r-jw_RefreshMargin*2);
    //各曲线交点
    double agl = M_PI_2 / 9.l;
    CGPoint a1 = CGPointMake(-R*cos(agl), R*sin(agl));
    CGPoint a2 = CGPointMake(-a1.x, a1.y);
    //    CGPoint b1 = CGPointMake(-r, o.y);
    CGPoint b2 = CGPointMake(r, o.y);
    //贝塞尔曲线控制点
    CGPoint c1 = CGPointMake(-r, o.y/2.l);
    CGPoint c2 = CGPointMake(-c1.x, c1.y);
    //路径
    CGContextMoveToPoint(ctx, a2.x, a2.y);
    CGContextAddArc(ctx, 0, 0, R, agl, 2*M_PI+agl, NO);
    CGContextAddQuadCurveToPoint(ctx, c2.x, c2.y, b2.x, b2.y);
    CGContextAddArc(ctx, o.x, o.y, r, 0, M_PI, NO);
    CGContextAddQuadCurveToPoint(ctx, c1.x, c1.y, a1.x, a1.y);
    //绘制路径
    CGContextDrawPath(ctx, kCGPathFill);
    
    // ②绘制图片
    CGFloat wide = 2*R*0.7l;
    CGRect frame = CGRectMake(-wide/2.l, -wide/2.l, wide, wide);
    //旋转坐标系
    CGContextRotateCTM(ctx, s * M_PI*1.5);
    if (!image) image = [UIImage imageNamed: @"JWRefresh.bundle/jw_refresh_normal"];
    [image drawInRect:frame];
    
    //提取绘制图像
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(ctx);
    UIGraphicsEndImageContext();
    //    CGContextRelease(ctx);
    
    drawLayer.contents = (__bridge id _Nullable)(img.CGImage);
}


#pragma mark - 重写
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, 0, jw_startOffset);
        self.clipsToBounds = YES;
        
        //图层
        drawLayer = [CALayer layer];
        CGFloat wide = jw_startOffset-2*jw_RefreshMargin;
        drawLayer.frame = CGRectMake(0, 0, wide, jw_startRefreshOffset);
        [self.layer addSublayer:drawLayer];
        drawLayer.shadowRadius = 1;
        drawLayer.shadowOffset = CGSizeMake(0, 1);
        drawLayer.shadowOpacity = 0.1;
        
        //指示器
        indicatorView = [UIActivityIndicatorView new];
        indicatorView.center = CGPointMake(0, jw_startOffset/2.l);
        indicatorView.color = [UIColor grayColor];
        [self addSubview:indicatorView];
        
        //提示标签
        capionLabel = [UILabel new];
        capionLabel.bounds = CGRectMake(0, 0, 300, 30);
        capionLabel.center = indicatorView.center;
        capionLabel.alpha = 0;
        capionLabel.textColor = [UIColor colorWithWhite:.45 alpha:1];
        capionLabel.textAlignment = NSTextAlignmentCenter;
        capionLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:capionLabel];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    if (self.frame.size.width != frame.size.width) {
        [self centerSub:frame.size.width];
    }
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    if (self.bounds.size.width != bounds.size.width) {
        [self centerSub:bounds.size.width];
    }
    [super setBounds:bounds];
}


//drawLayer居中
- (void)centerSub:(CGFloat)width
{
    CGRect frame = drawLayer.frame;
    frame.origin.x = (width - frame.size.width) / 2.l;
    drawLayer.frame = frame;
    
    CGPoint center = indicatorView.center;
    center.x = width / 2.l;
    indicatorView.center = center;
    capionLabel.center = center;
}


#pragma mark - 辅助方法
//滚动
- (void)superviewScrollTo:(CGFloat)offsetY
{
    UIScrollView *scrollView = (UIScrollView *)[self superview];
    if (scrollView) {
        CGPoint offset = scrollView.contentOffset;
        offset.y = offsetY;

        if (scrollView.contentInset.top) {
            offset.y-= scrollView.contentInset.top;
        }
        [scrollView setContentOffset:offset animated:YES];
    }
}

//提示文字
- (NSAttributedString *)endCapion:(BOOL)isSuccess
{
    if (isSuccess) {
        if (!finishSucess) {
            finishSucess = [self attributedString:@"刷新成功" imgName:[UIImage imageNamed: @"JWRefresh.bundle/jw_refresh_sucess"]];
        }
        return finishSucess;
    }else {
        if (!finishError) {
            finishError = [self attributedString:@"刷新失败" imgName:[UIImage imageNamed: @"JWRefresh.bundle/jw_refresh_fail"]];
        }
        return finishError;
    }
}

- (NSAttributedString *)attributedString:(NSString *)capion imgName:(UIImage *)img
{
    NSTextAttachment *attachment = [NSTextAttachment new];
    attachment.image = img;
    CGSize size = attachment.image.size;
    attachment.bounds = CGRectMake(0, -2.5l, size.width, size.height);
    NSAttributedString *imgAttrStr = [NSAttributedString attributedStringWithAttachment:attachment];
    NSString *str = [NSString stringWithFormat:@" %@", capion];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    [attrString insertAttributedString:imgAttrStr atIndex:0];
    return attrString;
}



@end
