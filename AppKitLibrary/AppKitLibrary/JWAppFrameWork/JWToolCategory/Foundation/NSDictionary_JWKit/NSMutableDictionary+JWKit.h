//
//  NSMutableDictionary+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (JWKit)

/**
 *  Set the object for a given key in safe mode (if not nil)
 *
 *  @param anObject The object
 *  @param aKey     The key
 *
 *  @return Returns YES if has been setted, otherwise NO
 */
- (BOOL)safeSetObject:(id)anObject
               forKey:(id<NSCopying>)aKey;

@end
