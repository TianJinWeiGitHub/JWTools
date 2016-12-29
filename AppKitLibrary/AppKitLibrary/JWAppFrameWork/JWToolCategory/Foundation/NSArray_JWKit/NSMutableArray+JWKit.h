//
//  NSMutableArray+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (JWKit)

/**
 *  Move an object from an index to another
 *
 *  @param from The index to move from
 *  @param to   The index to move to
 */
- (void)moveObjectFromIndex:(NSUInteger)from
                    toIndex:(NSUInteger)to;

/**
 *  Create a reversed array from self
 *
 *  @return Returns the reversed array
 */
- (NSMutableArray *)reversedArray;

/**
 *  Sort an array by a given key with option for ascending or descending
 *
 *  @param key       The key to order the array
 *  @param array     The array to be ordered
 *  @param ascending A BOOL to choose if ascending or descending
 *
 *  @return Returns the given array ordered by the given key ascending or descending
 */
+ (NSMutableArray *)sortArrayByKey:(NSString *)key
                             array:(NSMutableArray *)array
                         ascending:(BOOL)ascending;


@end
