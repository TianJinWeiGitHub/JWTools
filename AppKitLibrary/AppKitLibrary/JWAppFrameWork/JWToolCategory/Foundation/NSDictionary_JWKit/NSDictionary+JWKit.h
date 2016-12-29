//
//  NSDictionary+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JWKit)

/**
 *  Convert self to JSON as NSString
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
- (NSString *)dictionaryToJson DEPRECATED_MSG_ATTRIBUTE("Use -dictionaryToJSON");

/**
 *  Convert self to JSON as NSString
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
- (NSString *)dictionaryToJSON;

/**
 *  Convert the given dictionary to JSON as NSString
 *
 *  @param dictionary The dictionary to be converted
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
+ (NSString *)dictionaryToJson:(NSDictionary *)dictionary DEPRECATED_MSG_ATTRIBUTE("Use +dictionaryToJSON:");

/**
 *  Convert the given dictionary to JSON as NSString
 *
 *  @param dictionary The dictionary to be converted
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
+ (NSString *)dictionaryToJSON:(NSDictionary *)dictionary;

@end
