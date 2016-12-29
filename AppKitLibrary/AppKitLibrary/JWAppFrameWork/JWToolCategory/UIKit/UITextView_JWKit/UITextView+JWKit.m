//
//  UITextView+JWKit.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "UITextView+JWKit.h"

@implementation UITextView (JWKit)

+ (UITextView *)initWithFrame:(CGRect)frame text:(NSString *)text color:(UIColor *)color font:(FontName)fontName size:(float)size alignment:(NSTextAlignment)alignment dataDetectorTypes:(UIDataDetectorTypes)dataDetectorTypes editable:(BOOL)editable selectable:(BOOL)selectable returnType:(UIReturnKeyType)returnType keyboardType:(UIKeyboardType)keyboardType secure:(BOOL)secure autoCapitalization:(UITextAutocapitalizationType)capitalization keyboardAppearance:(UIKeyboardAppearance)keyboardAppearence enablesReturnKeyAutomatically:(BOOL)enablesReturnKeyAutomatically autoCorrectionType:(UITextAutocorrectionType)autoCorrectionType delegate:(id<UITextViewDelegate>)delegate
{
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    [textView setText:text];
    [textView setAutocorrectionType:autoCorrectionType];
    [textView setTextAlignment:alignment];
    [textView setKeyboardType:keyboardType];
    [textView setAutocapitalizationType:capitalization];
    [textView setTextColor:color];
    [textView setReturnKeyType:returnType];
    [textView setEnablesReturnKeyAutomatically:enablesReturnKeyAutomatically];
    [textView setSecureTextEntry:secure];
    [textView setKeyboardAppearance:keyboardAppearence];
    [textView setFont:[UIFont fontForFontName:fontName size:size]];
    [textView setDelegate:delegate];
    [textView setDataDetectorTypes:dataDetectorTypes];
    [textView setEditable:editable];
    [textView setSelectable:selectable];
    
    return textView;
}

@end
