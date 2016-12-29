//
//  NSDictionary+JWKit.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "NSDictionary+JWKit.h"

@implementation NSDictionary (JWKit)

- (NSString *)dictionaryToJson
{
    return [self dictionaryToJSON];
}

- (NSString *)dictionaryToJSON
{
    return [NSDictionary dictionaryToJSON:self];
}

+ (NSString *)dictionaryToJson:(NSDictionary *)dictionary
{
    return [self dictionaryToJSON:dictionary];
}

+ (NSString *)dictionaryToJSON:(NSDictionary *)dictionary
{
    NSString *json = nil;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    if(!jsonData)
    {
        return @"{}";
    }
    else if(!error)
    {
        json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    else
    {
        return error.localizedDescription;
    }
}

@end
