//
//  UIImage+JWPhotoBrowser.h
//  AppKitLibrary
//
//  Created by jinwei on 15/11/27.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JWPhotoBrowser)
+ (UIImage *)imageForResourcePath:(NSString *)path ofType:(NSString *)type inBundle:(NSBundle *)bundle;
+ (UIImage *)clearImageWithSize:(CGSize)size;
@end
