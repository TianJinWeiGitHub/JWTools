//
//  UIImage+JWQRCode.h
//  AppKitLibrary
//
//  Created by secoo02 on 15/11/20.
//  Copyright © 2015年 jinwei group. All rights reserved.
// 生成二维码

#import <UIKit/UIKit.h>

@interface UIImage (JWQRCode)

+ (UIImage*)qrImageWithString: (NSString*)string dimension: (NSInteger)dim;

+ (UIImage*)qrImageWithString: (NSString*)string destSize: (CGSize)size;

+ (UIImage*)qrImageWithString:(NSString *)string
                     destSize:(CGSize)size
                         logo: (UIImage*)logo
                     logoSize:(CGSize)logoSize;

@end
