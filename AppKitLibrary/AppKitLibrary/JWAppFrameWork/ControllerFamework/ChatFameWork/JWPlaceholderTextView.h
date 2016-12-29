//
//  JWPlaceholderTextView.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/23.
//  Copyright © 2015年 jinwei group. All rights reserved.
//  输入

#import <UIKit/UIKit.h>

@interface JWPlaceholderTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;

@end

@interface GrowingTextView : JWPlaceholderTextView

@property (nonatomic, assign) NSUInteger maxNumberOfLines;

@property (nonatomic, readonly) CGFloat maxHeight;

- (instancetype)initWithPlaceholder:(NSString *)placeholder;

- (CGFloat)measureHeight;

@end
