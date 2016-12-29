//
//  UIBarButtonItem+JWKit.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "UIBarButtonItem+JWKit.h"

@implementation UIBarButtonItem (JWKit)

- (instancetype)initWithBarButtonFlexibleSpace
{
    return [self initWithBarButtonSpaceType:UIBarButtonSystemItemFlexibleSpace width:0];
}

- (instancetype)initWithBarButtonSpaceType:(UIBarButtonSystemItem)spaceType width:(CGFloat)width
{
    if(spaceType == UIBarButtonSystemItemFixedSpace || spaceType == UIBarButtonSystemItemFlexibleSpace)
    {
        self = [self initWithBarButtonSystemItem:spaceType target:nil action:nil];
        if(spaceType == UIBarButtonSystemItemFixedSpace)
        {
            self.width = width;
        }
    }
    else
    {
        self = [self initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    }
    
    return self;
}

@end
