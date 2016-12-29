//
//  JWTapDetectingImageView.h
//  AppKitLibrary
//
//  Created by jinwei on 15/11/27.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JWTapDetectingImageViewDelegate <NSObject>

@optional

- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView tripleTapDetected:(UITouch *)touch;

@end

@interface JWTapDetectingImageView : UIImageView

@property (nonatomic, weak) id <JWTapDetectingImageViewDelegate>tapDelegate;

@end









@protocol JWTapDetectingViewDelegate <NSObject>

@optional

- (void)view:(UIView *)view singleTapDetected:(UITouch *)touch;
- (void)view:(UIView *)view doubleTapDetected:(UITouch *)touch;
- (void)view:(UIView *)view tripleTapDetected:(UITouch *)touch;

@end

@interface JWTapDetectingView : UIView
@property (nonatomic, weak) id <JWTapDetectingViewDelegate>tapDelegate;


@end