//
//  JWEditingBar.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/23.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWPlaceholderTextView.h"


@interface JWEditingBar : UIToolbar

@property (nonatomic, copy) void (^sendContent)(NSString *content);

@property (nonatomic, strong) GrowingTextView *editView;

@property (nonatomic, strong) UIButton *modeSwitchButton;

@property (nonatomic, strong) UIButton *inputViewButton;

//@property (nonatomic, strong) UIButton *moreButton;

- (instancetype)initWithModeSwitchButton:(BOOL)hasAModeSwitchButton;


@end
