//
//  JWRequest.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//



#import "AFHTTPRequestOperationManager.h"

#define Api_host @"http://123.23.124.23"

typedef void(^responseCallBlock)( id responObject, NSString *errmsg);

@interface JWRequest : AFHTTPRequestOperationManager

+ (instancetype)defaultJWNetClient;

@end
