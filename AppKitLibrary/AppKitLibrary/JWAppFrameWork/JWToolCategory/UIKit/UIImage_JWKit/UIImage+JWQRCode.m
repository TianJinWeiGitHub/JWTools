//
//  UIImage+JWQRCode.m
//  AppKitLibrary
//
//  Created by secoo02 on 15/11/20.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "UIImage+JWQRCode.h"
#import <CoreImage/CoreImage.h>


@implementation UIImage (JWQRCode)

+ (UIImage*)qrImageWithString: (NSString*)string dimension: (NSInteger)dim {
    return [self qrImageWithString:string destSize:CGSizeMake(dim, dim)];
}

+ (UIImage *)centerLogoImage:(UIImage*)coverImage logoSize: (CGSize)logoSize inQRImage: (UIImage*)QRCodeImage qrSize: (CGSize)qrSize  {
    CGRect rect = CGRectZero;
    rect.size = qrSize;
    
    CGRect coverRect = CGRectZero;
    coverRect.size = logoSize;
    coverRect.origin.x = (CGRectGetWidth(rect) - coverRect.size.width) / 2;
    coverRect.origin.y = (CGRectGetHeight(rect) - coverRect.size.height) / 2;
    
    UIImage *mixedImage;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    {
        [QRCodeImage drawInRect:rect];
        [coverImage drawInRect:coverRect];
        mixedImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    return mixedImage;
}
+ (UIImage*)qrImageWithString:(NSString *)string
                     destSize:(CGSize)size
                         logo: (UIImage*)logo
                     logoSize:(CGSize)logoSize;
{
    UIImage* qrCode = [self qrImageWithString:string destSize:size];
    if (logo == nil) {
        return qrCode;
    }
    return [self centerLogoImage:logo logoSize:logoSize inQRImage:qrCode qrSize:qrCode.size];
}


+ (UIImage*)qrImageWithString: (NSString*)string
                     destSize: (CGSize)size {
    // Setup the QR filter with our string
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *image = [filter valueForKey:@"outputImage"];
    
    // Calculate the size of the generated image and the scale for the desired image size
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGFloat scale = MIN(size.width / CGRectGetWidth(extent), size.height / CGRectGetHeight(extent));
    scale = (scale>0)?scale*screenScale:screenScale;
    
    // Since CoreImage nicely interpolates, we need to create a bitmap image that we'll draw into
    // a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage scale:screenScale orientation:UIImageOrientationUp];
}

@end
