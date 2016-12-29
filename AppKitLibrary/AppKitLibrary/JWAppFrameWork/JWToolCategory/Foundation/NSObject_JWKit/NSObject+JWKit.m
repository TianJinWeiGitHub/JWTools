//
//  NSObject+JWKit.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "NSObject+JWKit.h"

@implementation NSObject (JWKit)

- (BOOL)isValid
{
    return !(self == nil || [self isKindOfClass:[NSNull class]]);
}

- (id)performSelector:(SEL)aSelector withObjects:(id)object, ...
{
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    if(signature)
    {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:aSelector];
        
        va_list args;
        va_start(args, object);
        
        [invocation setArgument:&object atIndex:2];
        
        id arg = nil;
        int index = 3;
        while((arg = va_arg(args, id)))
        {
            [invocation setArgument:&arg atIndex:index];
            index++;
        }
        
        va_end(args);
        
        [invocation invoke];
        if(signature.methodReturnLength)
        {
            id anObject;
            [invocation getReturnValue:&anObject];
            return anObject;
        }
        else
        {
            return nil;
        }
    }
    else
    {
        return nil;
    }
}

@end
