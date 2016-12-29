//
//  UIView+JWAnimation.h
//  AppKitLibrary
//
//  Created by secoo02 on 15/11/23.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"


#define JWkCameraEffectOpen  @"cameraIrisHollowOpen"
#define JWkCameraEffectClose @"cameraIrisHollowClose"

@interface UIView (JWAnimation)

/** 旋转rotation */
- (void)rotateWithduration:(CFTimeInterval)time fromValue:(id)fromevalue toValue:(id)toValue;

/** xy rotation*/
- (void)rotateXYWithduration:(CFTimeInterval)time toValue:(id)toValue;

/** 左右抖动 */
- (void)shakeAnimationWithDuration:(CFTimeInterval)time;

/** 环形动画 */
- (void)trackAnimationwithRect:(CGRect)rect;

/** 切换替代 相同位置的动画效果为向两侧移动然后位移回来切换显示层*/
- (void)reShuffleAnimationwithView:(UIView *)anotherView toValue:(float)toValue;

/** 揭开 */
- (void)animationRevealdirection:(NSString *)direction;

/** 渐隐渐消 */
- (void)animationFade;

/** 翻转 */
- (void)animationFlipDirection:(NSString *)direction;

/** 旋转缩放 */
- (void)animationRotateAndScaleEffects;//各种旋转缩放效果。

/** push */
- (void)animationPushDirection:(NSString *)direction;

/** Curl UnCurl*/
- (void)animationCurlDirection:(NSString *)direction;
- (void)animationUnCurlDirection:(NSString *)direction;

/** Move */
- (void)animationMoveDirection:(NSString *)direction;

/** 立方体 */
- (void)animationCubeDirection:(NSString *)direction;

/** 水波纹 */
- (void)animationRippleEffect;

/** 相机开合*/
- (void)animationCameraEffectType:(NSString *)type;

/** 吸收*/
- (void)animationSuckEffect;

- (void)animationBounceOut;
- (void)animationBounceIn;
- (void)animationBounce;

@end
