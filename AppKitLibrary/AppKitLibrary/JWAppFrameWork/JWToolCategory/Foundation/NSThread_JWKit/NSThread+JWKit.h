//
//  NSThread+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Runs a block in the main thread
 *
 *  @param ^block Block to be executed
 */
NS_INLINE void runOnMainThread(void (^block)(void))
{
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}

@interface NSThread (JWKit)

@end
