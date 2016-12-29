//
//  NSNull+JWKit.m
//  AppKitLibrary
//
//  Created by secoo02 on 15/11/20.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "NSNull+JWKit.h"


#define NSNullObjects @[@"",@0,@{},@[],@"<null>",@"(null)"]

@implementation NSNull (JWKit)

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        for (NSObject *object in NSNullObjects) {
            signature = [object methodSignatureForSelector:selector];
            if (signature) {
                break;
            }
        }
        
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL aSelector = [anInvocation selector];
    
    for (NSObject *object in NSNullObjects) {
        if ([object respondsToSelector:aSelector]) {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    
    [self doesNotRecognizeSelector:aSelector];
}

@end
