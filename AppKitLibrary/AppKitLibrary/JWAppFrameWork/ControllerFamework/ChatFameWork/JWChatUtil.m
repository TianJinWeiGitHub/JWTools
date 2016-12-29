//
//  JWChatUtil.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/24.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "JWChatUtil.h"

@implementation JWChatUtil

#pragma mark - 通用

#pragma mark - emoji Dictionary

+ (NSDictionary *)emojiDict
{
    static dispatch_once_t once;
    static NSDictionary *emojiDict;
    
    dispatch_once(&once, ^ {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path = [bundle pathForResource:@"jwemoji" ofType:@"plist"];
        emojiDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    });
    
    return emojiDict;
}


@end
