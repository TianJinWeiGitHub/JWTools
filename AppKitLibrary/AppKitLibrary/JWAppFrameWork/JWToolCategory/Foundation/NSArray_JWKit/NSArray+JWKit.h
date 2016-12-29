//
//  NSArray+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JWKit)


/**
 *  得到对象在给定索引在安全模式(nil如果自我为空或范围)
 *  @param index 下标
 *  @return 返回的对象在给定索引在安全模式(nil如果自我为空或范围)
 */
- (id)safeObjectAtIndex:(NSUInteger)index;

/**
 *  创建一个反转数组从自我
 *  @return 返回颠倒数组
 */
- (NSArray *)reversedArray;

/**
 *  自我转换为JSON 字符串
 */
- (NSString *)arrayToJson;

/**
 *  模拟了数组作为一个圆。它的范围时,重新开始
 *  @param index 下标
 *  @return 返回对象
 */
- (id)objectAtCircleIndex:(NSInteger)index;

/**
 *  Create a reversed array from the given array
 *
 *  @param array The array to be converted
 *
 *  @return Returns the reversed array
 */
+ (NSArray *)reversedArray:(NSArray *)array;

/**
 *  Convert the given array to JSON as NSString
 *
 *  @param array The array to be reversed
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
+ (NSString *)arrayToJson:(NSArray *)array;

@end
