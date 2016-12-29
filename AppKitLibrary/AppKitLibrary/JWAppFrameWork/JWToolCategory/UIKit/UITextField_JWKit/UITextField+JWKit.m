//
//  UITextField+JWKit.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "UITextField+JWKit.h"

@implementation UITextField (JWKit)

+ (id)fieldWithFrame:(CGRect)frame font:(float)textFont place:(NSString *)place delete:(id<UITextFieldDelegate>)Cdelete textColor:(UIColor *)textColor
{
    UITextField *field = [[UITextField alloc]initWithFrame:frame];
    if (textFont) {
        field.font = [UIFont systemFontOfSize:textFont];
    }
    if (place) {
        field.placeholder = place;
    }
    if (Cdelete) {
        field.delegate = Cdelete;
    }
    if (textColor) {
        field.textColor = textColor;
    }else {
        field.textColor = [UIColor blackColor];
    }
    field.returnKeyType = UIReturnKeyDone;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    return field;
}


+ (UITextField *)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder color:(UIColor *)color font:(FontName)fontName size:(float)size returnType:(UIReturnKeyType)returnType keyboardType:(UIKeyboardType)keyboardType secure:(BOOL)secure borderStyle:(UITextBorderStyle)borderStyle autoCapitalization:(UITextAutocapitalizationType)capitalization keyboardAppearance:(UIKeyboardAppearance)keyboardAppearence enablesReturnKeyAutomatically:(BOOL)enablesReturnKeyAutomatically clearButtonMode:(UITextFieldViewMode)clearButtonMode autoCorrectionType:(UITextAutocorrectionType)autoCorrectionType delegate:(id<UITextFieldDelegate>)delegate
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    [textField setBorderStyle:borderStyle];
    [textField setAutocorrectionType:autoCorrectionType];
    [textField setClearButtonMode:clearButtonMode];
    [textField setKeyboardType:keyboardType];
    [textField setAutocapitalizationType:capitalization];
    [textField setPlaceholder:placeholder];
    [textField setTextColor:color];
    [textField setReturnKeyType:returnType];
    [textField setEnablesReturnKeyAutomatically:enablesReturnKeyAutomatically];
    [textField setSecureTextEntry:secure];
    [textField setKeyboardAppearance:keyboardAppearence];
    [textField setFont:[UIFont fontForFontName:fontName size:size]];
    [textField setDelegate:delegate];
    
    return textField;
}

@end
