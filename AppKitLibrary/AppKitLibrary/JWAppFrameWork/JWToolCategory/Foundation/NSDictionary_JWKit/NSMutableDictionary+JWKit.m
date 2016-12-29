//
//  NSMutableDictionary+JWKit.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "NSMutableDictionary+JWKit.h"

@implementation NSMutableDictionary (JWKit)

- (BOOL)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if(anObject == nil)
    {
        return NO;
    }
    
    [self setObject:anObject forKey:aKey];
    
    return YES;
}

@end
