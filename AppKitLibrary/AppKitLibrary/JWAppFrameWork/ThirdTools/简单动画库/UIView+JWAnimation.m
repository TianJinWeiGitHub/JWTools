//
//  UIView+JWAnimation.m
//  AppKitLibrary
//
//  Created by secoo02 on 15/11/23.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "UIView+JWAnimation.h"

#define kTransitionTime 0.55
#define kFlipTime       0.85

@implementation UIView (JWAnimation)

/** 旋转rotation */
- (void)rotateWithduration:(CFTimeInterval)time fromValue:(id)fromevalue toValue:(id)toValue
{
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    rotation.fromValue = fromevalue;
    rotation.toValue = toValue;
    rotation.duration = time;
    rotation.repeatCount = /*INFINITY*/ 1;
    rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    // rotation.fillMode = kCAFillModeForwards;
    // rotation.removedOnCompletion = NO;
    self.transform = CGAffineTransformMakeRotation([toValue floatValue]);
    [self.layer addAnimation:rotation forKey:@"jwan_roate"];
}

/** xy rotation [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 0, 0)/(M_PI, 0, 1, 0)] */
- (void)rotateXYWithduration:(CFTimeInterval)time toValue:(id)toValue
{
    CABasicAnimation *TransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    TransformAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    TransformAnim.toValue = toValue;
    TransformAnim.cumulative = YES;
    TransformAnim.duration = time;
    TransformAnim.repeatCount = 2;
    [self.layer addAnimation:TransformAnim forKey:nil];

}

/** 左右抖动 */
- (void)shakeAnimationWithDuration:(CFTimeInterval)time
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = time;
    animation.additive = YES;
    [self.layer addAnimation:animation forKey:@"jwshake"];
}

/** 环形动画 */
- (void)trackAnimationwithRect:(CGRect)rect
{
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(rect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = /*kCAAnimationRotateAuto*/ nil;
    [self.layer addAnimation:orbit forKey:@"jwani-track"];

}

/** 切换替代 相同位置的动画效果为向两侧移动然后位移回来切换显示层*/
- (void)reShuffleAnimationwithView:(UIView *)anotherView toValue:(float)toValue
{
    toValue = -toValue;
    // Animation group for cardA
    CABasicAnimation *zPosition = [CABasicAnimation animation];
    zPosition.keyPath = @"zPosition";
    zPosition.fromValue = @(toValue);
    zPosition.toValue = @(-toValue);
    zPosition.duration = 1.2;
    
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = @[ @0, @0.14, @0 ];
    rotation.duration = 1.2;
    rotation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
    position.keyPath = @"position";
    position.values = @[[NSValue valueWithCGPoint:CGPointZero],
                        [NSValue valueWithCGPoint:CGPointMake(90, -20)],
                        [NSValue valueWithCGPoint:CGPointZero]];
    position.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    position.additive = YES;
    position.duration = 1.2;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[ zPosition, rotation, position ];
    group.duration = 1.2;
    
    self.layer.zPosition = -toValue;
    [self.layer addAnimation:group forKey:@"shuffle"];
    
    // Animation group for cardB
    CABasicAnimation *zPosition1 = [CABasicAnimation animation];
    zPosition1.keyPath = @"zPosition";
    zPosition1.fromValue = @(-toValue);
    zPosition1.toValue = @(toValue);
    zPosition1.duration = 1.2;
    
    CAKeyframeAnimation *rotation1 = [CAKeyframeAnimation animation];
    rotation1.keyPath = @"transform.rotation";
    rotation1.values = @[ @0, @(-0.14), @0 ];
    rotation1.duration = 1.2;
    rotation1.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    CAKeyframeAnimation *position1 = [CAKeyframeAnimation animation];
    position1.keyPath = @"position";
    position1.values = @[[NSValue valueWithCGPoint:CGPointZero],
                         [NSValue valueWithCGPoint:CGPointMake(-85, -20)],
                         [NSValue valueWithCGPoint:CGPointZero]];
    position1.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    position1.additive = YES;
    position1.duration = 1.2;
    
    CAAnimationGroup *group1 = [[CAAnimationGroup alloc] init];
    group1.animations = @[ zPosition1, rotation1, position1 ];
    group1.duration = 1.2;
    
    anotherView.layer.zPosition = toValue;
    [anotherView.layer addAnimation:group1 forKey:@"shuffle"];
}

/** 揭开 */
- (void)animationRevealdirection:(NSString *)direction;
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:direction];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [self.layer addAnimation:animation forKey:nil];
}

/** 渐隐渐消 */
- (void)animationFade
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:animation forKey:nil];
}


/** 翻转 kCAMediaTimingFunctionEaseInEaseOut*/
- (void)animationFlipDirection:(NSString *)direction;
{
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 2];
    rotationAnimation.duration = 0.750f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:direction];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.duration = 0.75f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:direction];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 0.75f;
    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = 1;//HUGE_VALF;
    [animationGroup setAnimations:[NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil]];
    
    [self.layer addAnimation:animationGroup forKey:@"animationGroup"];
}


+ (void)animationFlip:(UIView *)view direction:(NSString *)direction
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kFlipTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"oglFlip"];
    [animation setSubtype:direction];
    [view.layer addAnimation:animation forKey:nil];
}

/** push */
- (void)animationPushDirection:(NSString *)direction
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:direction];
    [self.layer addAnimation:animation forKey:nil];
}

/** Curl UnCurl*/


- (void)animationCurlDirection:(NSString *)direction;
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"pageCurl"];
    [animation setSubtype:direction];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationUnCurlDirection:(NSString *)direction;
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"pageUnCurl"];
    [animation setSubtype:direction];
    
    [self.layer addAnimation:animation forKey:nil];
}

/** 旋转缩放 */
- (void)animationRotateAndScaleEffects{
    [UIView animateWithDuration:0.75
                     animations:^{
                         
         self.transform = CGAffineTransformMakeScale(0.001, 0.001);
         CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
         animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0.70, 0.40, 0.80) ];//旋转形成一道闪电。
         //animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0) ];//y轴居中对折番。
         //animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 1.0, 0.0, 0.0) ];//沿X轴对折翻转。
         //animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0.50, -0.50, 0.50) ];
         //animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0.1, 0.2, 0.2) ];
         
         animation.duration = 0.45;
         animation.repeatCount = 1;
         [self.layer addAnimation:animation forKey:nil];
     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.75 animations:^{
              
                             self.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         }
                          ];
                     }
     ];
}


/** Move */
- (void)animationMoveDirection:(NSString *)direction
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:direction];
    [self.layer addAnimation:animation forKey:nil];
}

/** 立方体 */
- (void)animationCubeDirection:(NSString *)direction;
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:direction];
    [self.layer addAnimation:animation forKey:nil];
}

/** 水波纹 */
- (void)animationRippleEffect
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"rippleEffect"];
    [animation setSubtype:kCATransitionFromRight];
    [self.layer addAnimation:animation forKey:nil];
}

/** 相机开合*/
- (void)animationCameraEffectType:(NSString *)type
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:type];
    [self.layer addAnimation:animation forKey:nil];
}

/** 吸收*/
- (void)animationSuckEffect
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"suckEffect"];
    [animation setSubtype:kCATransitionFromRight];
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationBounceIn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.0001];
    [self setAlpha:0.8];
    [self setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)];
    [UIView commitAnimations];
}

- (void)animationBounceOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.73];
    //    [UIView setAnimationDelay:0.2];
    [self setAlpha:1.0];
    [self setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)];
    [UIView commitAnimations];
}

- (void)animationBounce
{
    CGRect rect = self.bounds;
    CGPoint center = self.center;
    [self setCenter:CGPointMake(160, 240)];
    [self setFrame:CGRectZero];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [self setAlpha:1.0];
    [self setBounds:rect];
    [self setCenter:center];
    [UIView commitAnimations];
}


- (void)invalidated
{
//    CGPoint bottomLeft 	= CGPointMake(35.f, 400.f);
//    CGPoint topLeft		= CGPointMake(35.f, 200.f);
//    CGPoint bottomRight = CGPointMake(285.f, 400.f);
//    CGPoint topRight	= CGPointMake(285.f, 200.f);
//    CGPoint roofTip		= CGPointMake(160.f, 100.f);
//    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:bottomLeft];
//    [path addLineToPoint:topLeft];
//    [path addLineToPoint:roofTip];
//    [path addLineToPoint:topRight];
//    [path addLineToPoint:topLeft];
//    [path addLineToPoint:bottomRight];
//    [path addLineToPoint:topRight];
//    [path addLineToPoint:bottomLeft];
//    [path addLineToPoint:bottomRight];
//    
//    CAShapeLayer *pathLayer = [CAShapeLayer layer];
//    pathLayer.frame = CGRectMake(35, 100, 250, 200);
//    pathLayer.bounds = CGRectMake(35, 100, 250, 200);
//    pathLayer.path = path.CGPath;
//    pathLayer.strokeColor = [[UIColor blackColor] CGColor];
//    pathLayer.fillColor = nil;
//    pathLayer.lineWidth = 6.f;
//    pathLayer.lineJoin = kCALineJoinRound;
//    [self.layer addSublayer:pathLayer];
//    
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 10.0;
//    pathAnimation.fromValue = @(0);
//    pathAnimation.toValue = @(1);
//    [self addAnimation:pathAnimation forKey:@"strokeEnd"];
}
@end
