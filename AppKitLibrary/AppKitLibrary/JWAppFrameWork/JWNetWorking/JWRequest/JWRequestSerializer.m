//
//  JWRequestSerializer.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "JWRequestSerializer.h"
#import "NSString+RequestUrl.h"

@implementation JWRequestSerializer


- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters
                                     error:(NSError *__autoreleasing *)error
{
    
    NSString *newURLString = [URLString urlPathWithCommonStat];
    
    return [super requestWithMethod: method
                          URLString: newURLString
                         parameters: parameters
                              error: error];
}

@end
