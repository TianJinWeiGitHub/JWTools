//
//  UIImage+JWPhotoBrowser.m
//  AppKitLibrary
//
//  Created by jinwei on 15/11/27.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "UIImage+JWPhotoBrowser.h"

@implementation UIImage (JWPhotoBrowser)


+ (UIImage *)imageForResourcePath:(NSString *)path ofType:(NSString *)type inBundle:(NSBundle *)bundle {
    return [UIImage imageWithContentsOfFile:[bundle pathForResource:path ofType:type]];
}

+ (UIImage *)clearImageWithSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return blank;
}

@end
