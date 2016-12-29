//
//  JWBottomBarViewController.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/24.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWEditingBar.h"
#import "JWOperationBar.h"

@class JWEmojiPageVC;

@interface JWBottomBarViewController : UIViewController

@property (nonatomic, strong) JWEditingBar *editingBar;
@property (nonatomic, strong) JWOperationBar *operationBar;
@property (nonatomic, strong) NSLayoutConstraint *editingBarYConstraint;
@property (nonatomic, strong) NSLayoutConstraint *editingBarHeightConstraint;

- (instancetype)initWithModeSwitchButton:(BOOL)hasAModeSwitchButton;

- (void)sendContent;

- (void)updateInputBarHeight;

- (void)hideEmojiPageView;


@end
