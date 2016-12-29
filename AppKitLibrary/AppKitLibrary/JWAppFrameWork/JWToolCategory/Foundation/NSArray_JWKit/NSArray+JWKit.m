//
//  NSArray+JWKit.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "NSArray+JWKit.h"

@implementation NSArray (JWKit)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if([self count] > 0 && [self count] > index)
        return [self objectAtIndex:index];
    else
        return nil;
}

- (NSArray *)reversedArray
{
    return [NSArray reversedArray:self];
}

- (NSString *)arrayToJson
{
    return [NSArray arrayToJson:self];
}

- (NSInteger)superCircle:(NSInteger)index maxSize:(NSInteger)maxSize
{
    if(index < 0)
    {
        index = index % maxSize;
        index += maxSize;
    }
    if(index >= maxSize)
    {
        index = index % maxSize;
    }
    
    return index;
}

- (id)objectAtCircleIndex:(NSInteger)index
{
    return [self objectAtIndex:[self superCircle:index maxSize:self.count]];
}

+ (NSString *)arrayToJson:(NSArray*)array
{
    NSString *json = nil;
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:&error];
    if(!error)
    {
        json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return json;
    }
    else
        return error.localizedDescription;
}

+ (NSArray *)reversedArray:(NSArray*)array
{
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[array count]];
    NSEnumerator *enumerator = [array reverseObjectEnumerator];
    for(id element in enumerator) [arrayTemp addObject:element];
    
    return arrayTemp;
}

@end
