//
//  UILabel+JWLabel.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIFont+JWKit.h"

@interface UILabel (JWLabel)

/**
 *  Create an UILabel with the given parameters, with clearColor for the shadow
 *
 *  @param frame     Label's frame
 *  @param text      Label's text
 *  @param fontName  Label's font name, FontName enum is declared in UIFont+BFKit
 *  @param size      Label's font size
 *  @param color     Label's text color
 *  @param alignment Label's text alignment
 *  @param lines     Label's text lines
 *
 *  @return Returns the created UILabel
 */
+ (UILabel *)initWithFrame:(CGRect)frame
                      text:(NSString *)text
                      font:(FontName)fontName
                      size:(CGFloat)size
                     color:(UIColor *)color
                 alignment:(NSTextAlignment)alignment
                     lines:(NSInteger)lines;

/**
 *  Create an UILabel with the given parameters
 *
 *  @param frame       Label's frame
 *  @param text        Label's text
 *  @param fontName    Label's font name, FontName enum is declared in UIFont+BFKit
 *  @param size        Label's font size
 *  @param color       Label's text color
 *  @param alignment   Label's text alignment
 *  @param lines       Label's text lines
 *  @param colorShadow Label's text shadow color
 *
 *  @return Returns the created UILabel
 */
+ (UILabel *)initWithFrame:(CGRect)frame
                      text:(NSString *)text
                      font:(FontName)fontName
                      size:(CGFloat)size
                     color:(UIColor *)color
                 alignment:(NSTextAlignment)alignment
                     lines:(NSInteger)lines
               shadowColor:(UIColor *)colorShadow;

+ (UILabel*) labelWithFrame: (CGRect) frame fontSize: (int) fontsize text: (NSString*) text;

+ (UILabel*) labelWithFrame: (CGRect) frame fontSize: (int) fontsize fontColor: (UIColor*) color text: (NSString*) text;

+ (UILabel*) labelWithFontSize: (CGFloat)fontSize fontColor:(UIColor *)color text: (NSString *)text;

+ (UILabel*) labelWithFrame: (CGRect) frame
               boldFontSize: (int) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text;



@end
