//
//  UILabel+JWLabel.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "UILabel+JWLabel.h"

@implementation UILabel (JWLabel)

+ (UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text font:(FontName)fontName size:(CGFloat)size color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines
{
    return [UILabel initWithFrame:frame text:text font:fontName size:size color:color alignment:alignment lines:lines shadowColor:[UIColor clearColor]];
}

+ (UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text font:(FontName)fontName size:(CGFloat)size color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines shadowColor:(UIColor *)colorShadow
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setFont:[UIFont fontForFontName:fontName size:size]];
    [label setText:text];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:color];
    [label setShadowColor:colorShadow];
    [label setTextAlignment:alignment];
    [label setNumberOfLines:lines];
    
    return label;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

+ (UILabel*) labelWithFontSize: (CGFloat)fontSize fontColor:(UIColor *)color text: (NSString *)text {
    UILabel *label = [UILabel new];
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.text = text;
    return label;
}

+ (UILabel*) labelWithFrame: (CGRect) frame
                   fontSize: (int) fontsize
                       text: (NSString*) text {
    
    UILabel* label = [[UILabel alloc] initWithFrame: frame];
    
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize: fontsize];
    
    return label;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UILabel*) labelWithFrame: (CGRect) frame
                   fontSize: (int) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text {
    
    UILabel* label = [[UILabel alloc] initWithFrame: frame];
    
    label.text = text;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize: fontsize];
    
    return label;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UILabel*) labelWithFrame: (CGRect) frame
               boldFontSize: (int) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text {
    
    UILabel* label = [[UILabel alloc] initWithFrame: frame];
    
    label.text = text;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize: fontsize];
    
    return label;
}



@end
