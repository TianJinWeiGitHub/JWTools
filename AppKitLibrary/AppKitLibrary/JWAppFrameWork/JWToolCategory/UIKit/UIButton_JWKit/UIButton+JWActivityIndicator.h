//
//  UIButton+JWActivityIndicator.h
//  AppKitLibrary
//
//  Created by secoo02 on 15/11/20.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JWActivityIndicator)

@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign, getter=isWorking) BOOL working;

@end
