//
//  JWRequest.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "JWRequest.h"
#import "JWRequestSerializer.h"

@implementation JWRequest

+ (instancetype)defaultJWNetClient
{
    static JWRequest *jwNetclient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jwNetclient = [[JWRequest alloc]initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",Api_host]]];
    });
    return jwNetclient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        
        
        // 为了https请求正常
        self.securityPolicy.allowInvalidCertificates = YES;
        
        self.requestSerializer = [JWRequestSerializer serializer];
        self.requestSerializer.timeoutInterval = 45;
        
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.requestSerializer setValue: @"application/json"
                      forHTTPHeaderField: @"Accept"];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    }
    
    return self;
}

@end
