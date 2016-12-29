//
//  NSString+RequestUrl.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RequestUrl)

//
// 返回带有统计数据的URL
//
- (NSString*) urlPathWithCommonStat;
//
// 带有统计信息的字符串
//
+ (NSString *) commonStatString;

+ (NSString *)escapeURL:(NSString *)url;

+ (NSString*) getUUID;

- (NSString*)uniqueDeviceToken;
@end

