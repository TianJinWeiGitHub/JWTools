//
//  NSString+RequestUrl.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "NSString+RequestUrl.h"
#import "SFHFKeychainUtils.h"
#import <UIKit/UIKit.h>

static NSMutableDictionary* urlSpecialChars = nil;


@implementation NSString (RequestUrl)

//
// 返回带有统计数据的URL
//
- (NSString*) urlPathWithCommonStat {
    
    // 如果是空字符串，则返回空字符串本身
    if (!self) {
        return self;
    }
    
    NSString* commonStat = [[self class] commonStatString];
    
    // 已经带有统计信息了
    if ([self rangeOfString:commonStat].length > 0) {
        return self;
    }
    
    // 添加统计信息
    if ([self rangeOfString:@"?"].length > 0) {
        return [self stringByAppendingFormat:@"&%@", commonStat];
    } else {
        return [self stringByAppendingFormat:@"?%@", commonStat];
    }
}


//
// 统计信息
//
+ (NSString *) commonStatString {
    
    NSString *ver = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    // platform: 和发布的app的platform的定义一致: iPad, iPhone, android, 如果需要统计真实的platform, 可以考虑添加其他的参数
    return [NSString stringWithFormat: @"platform=%@&systemVer=%@&version=%@&machineType=%@&device_id=%@",
            @"1",
            [NSString escapeURL: [[UIDevice currentDevice] systemVersion]],
            ver,
            [NSString escapeURL: [[UIDevice currentDevice] model]],
            [[NSString class] uniqueDeviceToken]]; // 用于数据的统计
    //            [[BGDeviceInfo sharedInstance] userPushToken]];
}

+ (NSString *)escapeURL:(NSString *)url {
    // Construct HashMap
    if (urlSpecialChars == nil ) {
        // TODO: 静态变量是否会出现内存泄露？
        urlSpecialChars = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                           @"%22", @"\"",
                           @"%3C", @"<",
                           @"%3E", @">",
                           @"%5C", @"\\",
                           @"%5E", @"^",
                           @"%5B", @"[",
                           @"%5D", @"]",
                           @"%60", @"`",
                           @"%2B", @"+",
                           @"%24", @"$",
                           @"%2C", @",",
                           @"%40", @"@",
                           @"%3A", @":",
                           @"%3B", @";",
                           @"%2F", @"/",
                           @"%21", @"!",
                           @"%23", @"#",
                           @"%3F", @"?",
                           @"%3D", @"=",
                           @"%26", @"&",
                           nil
                           ];
    }
    
    NSMutableString * str1 = [NSMutableString stringWithCapacity:0];
    [str1 appendString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableString * str2 = [NSMutableString stringWithCapacity:0];
    
    // 遍历str1中的每一个字符，并且进行可能的替换
    NSInteger str1Len = [str1 length];
    NSRange range;
    range.length = 1;
    
    // NSLog(@"Utility#escapeURL, Before Escape: %@", str1);
    for (int i = 0; i < str1Len; ++i) {
        range.location = i;
        NSString* key = [str1 substringWithRange:range];
        
        // NSLog(@"Utility#escapeURL, Key: %@", key);
        
        //"@"比较特殊
        // Use objectForKey instead of valueForKey to avoid KeyValueConversion, in which case "@" is for special use
        NSString* subStr = [urlSpecialChars objectForKey:key];
        // NSLog(@"Utility#escapeURL, Value: %@", subStr);
        
        if (subStr != nil)
            [str2 appendString:subStr];
        else
            [str2 appendString:key];
    }
    // NSLog(@"Utility#escapeURL, After Escape: %@", str2);
    return str2;
}

- (NSString*)uniqueDeviceToken {
    
    @synchronized(self) {
        NSString* uniqueDeviceToken = [self __uniqueDeviceToken];
        
        //        NIDPRINT(@"UniqueDeviceToken: ====> %@ <====", uniqueDeviceToken);
        return uniqueDeviceToken;
    }
}

- (NSString*) __uniqueDeviceToken {
    static NSString* kDeviceToken = @"BH_DV_TOKEN";
    static NSString* kServiceName = @"BG_SERVICE";
    
    // 1. 首先读取新的Token
    NSString* tokenV2 = [SFHFKeychainUtils getPasswordForUsernameV2: kDeviceToken
                                                     andServiceName: kServiceName
                                                              error: nil];
    
    // 2.1. 如果读取成功，则返回:
    if ([tokenV2 isNonEmpty]) {
        return tokenV2;
    }
    
    
    // 如果处于Active状态
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        // 生成一个UUID(不是设备相关的)
        NSString* uuid = [NSString getUUID];
        uuid =  [[uuid lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        [SFHFKeychainUtils storeUsername: kDeviceToken
                             andPassword: uuid
                          forServiceName: kServiceName
                          updateExisting: YES error: nil];
        
        return uuid;
    } else {
        return @"";
    }
}

static NSMutableCharacterSet* emptyStringSet = nil;

- (BOOL) isNonEmpty {
    if (emptyStringSet == nil) {
        emptyStringSet = [[NSMutableCharacterSet alloc] init];
        [emptyStringSet formUnionWithCharacterSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [emptyStringSet formUnionWithCharacterSet: [NSCharacterSet characterSetWithCharactersInString: @"　"]];
    }
    
    if ([self length] == 0) {
        return NO;
    }
    
    NSString* str = [self stringByTrimmingCharactersInSet:emptyStringSet];
    return [str length] > 0;
}


+ (NSString*) getUUID {
    
    static NSString *UUIDString = nil;
    if (UUIDString) {
        return UUIDString;
    }
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        UUIDString = [[NSUUID UUID] UUIDString];
    } else {
        CFUUIDRef UUID = CFUUIDCreate(NULL);
        UUIDString = CFBridgingRelease(CFUUIDCreateString(NULL, UUID));
    }
    
    UUIDString = [UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (!UUIDString) {
        return @"";
    } else {
        return UUIDString;
    }
}


@end
