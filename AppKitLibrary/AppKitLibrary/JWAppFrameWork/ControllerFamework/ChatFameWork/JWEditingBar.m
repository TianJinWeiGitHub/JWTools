//
//  JWEditingBar.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/23.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "JWEditingBar.h"
#import "UIView+JWKit.h"
#import "UIColor+themeColor.h"


@implementation JWEditingBar

- (id)initWithModeSwitchButton:(BOOL)hasAModeSwitchButton
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        [self addBorder];
        [self setLayoutWithModeSwitchButton:hasAModeSwitchButton];
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return self;
}


- (void)setLayoutWithModeSwitchButton:(BOOL)hasAModeSwitchButton
{
    _modeSwitchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_modeSwitchButton setImage:[UIImage imageNamed:@"toolbar-barSwitch"] forState:UIControlStateNormal];
    
    _inputViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_inputViewButton setImage:[UIImage imageNamed:@"toolbar-emoji2"] forState:UIControlStateNormal];
    
    _editView = [[GrowingTextView alloc] initWithPlaceholder:@"说点什么"];
    _editView.returnKeyType = UIReturnKeySend;
    [_editView setCornerRadius:5.0];
    
    if (JWNightModel) {
        self.barTintColor = [UIColor colorWithRed:22.0/255 green:22.0/255 blue:22.0/255 alpha:1.0];
        [_editView setBorderWidth:1.0f andColor:[UIColor JWborderColor]];
        _modeSwitchButton.backgroundColor = [UIColor clearColor];
        _inputViewButton.backgroundColor = [UIColor clearColor];
        _editView.backgroundColor = [UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.0];
    } else {
        self.barTintColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1.0];
        [_editView setBorderWidth:1.0f andColor:[UIColor JWColorWithHex:0xC8C8CD]];
        _modeSwitchButton.backgroundColor = [UIColor clearColor];
        _inputViewButton.backgroundColor = [UIColor clearColor];
        _editView.backgroundColor = [UIColor JWColorWithHex:0xF5FAFA];
    }
    _editView.textColor = [UIColor JWtitleColor];
    
    [self addSubview:_editView];
    [self addSubview:_modeSwitchButton];
    [self addSubview:_inputViewButton];
    
    for (UIView *view in self.subviews) {view.translatesAutoresizingMaskIntoConstraints = NO;}
    NSDictionary *views = NSDictionaryOfVariableBindings(_modeSwitchButton, _inputViewButton, _editView);
    
    if (hasAModeSwitchButton) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_modeSwitchButton(22)]-5-[_editView]-8-[_inputViewButton(35)]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_modeSwitchButton]|" options:0 metrics:nil views:views]];
    } else {
        [_modeSwitchButton removeFromSuperview];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[_editView]-8-[_inputViewButton(25)]-10-|"
                                                                     options:0 metrics:nil views:views]];
    }
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_inputViewButton]-5-|" options:0 metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_editView]-5-|" options:0 metrics:nil views:views]];
}


- (void)addBorder
{
    UIView *upperBorder = [UIView new];
    upperBorder.backgroundColor = [UIColor JWborderColor];
    upperBorder.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:upperBorder];
    
    UIView *bottomBorder = [UIView new];
    bottomBorder.backgroundColor = [UIColor JWborderColor];
    bottomBorder.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:bottomBorder];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(upperBorder, bottomBorder);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[upperBorder]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[upperBorder(0.5)]->=0-[bottomBorder(0.5)]|"
                                                                 options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                 metrics:nil views:views]];
}




@end
