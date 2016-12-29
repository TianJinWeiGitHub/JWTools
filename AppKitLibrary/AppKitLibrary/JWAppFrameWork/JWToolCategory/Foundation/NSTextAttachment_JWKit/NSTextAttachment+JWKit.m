//
//  NSTextAttachment+JWKit.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/23.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "NSTextAttachment+JWKit.h"

@implementation NSTextAttachment (JWKit)

- (void)adjustY:(CGFloat)y
{
    self.bounds = CGRectMake(0, y, self.image.size.width, self.image.size.height);
}

@end
