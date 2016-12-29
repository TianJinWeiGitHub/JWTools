//
//  UIDevice+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (JWKit)

/**
 *  Get the iOS version string
 */
#define IOS_VERSION [UIDevice currentDevice].systemVersion

/**
 *  Macros to compare system versions
 *
 *  @param v Version, like @"9.0"
 *
 *  @return Returns a BOOL
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/**
 *  Macros that returns if the iOS version is greater or equal to choosed one
 *
 *  @return Returns a BOOL
 */
#define IS_IOS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_IOS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_IOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_IOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IOS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

/**
 *  Returns the device platform string
 *  Example: "iPhone7,2"
 *
 *  @return Returns the device platform string
 */
+ (NSString *)devicePlatform;
/**
 *  Returns the user-friendly device platform string
 *  Example: "iPad Air (Cellular)"
 *
 *  @return Returns the user-friendly device platform string
 */
+ (NSString *)devicePlatformString;

/**
 *  Check if the current device is an iPad
 *
 *  @return Returns YES if it's an iPad, NO if not
 */
+ (BOOL)isiPad;

/**
 *  Check if the current device is an iPhone
 *
 *  @return Returns YES if it's an iPhone, NO if not
 */
+ (BOOL)isiPhone;

/**
 *  Check if the current device is an iPod
 *
 *  @return Returns YES if it's an iPod, NO if not
 */
+ (BOOL)isiPod;

/**
 *  Check if the current device is an Apple TV
 *
 *  @return Returns YES if it's an Apple TV, NO if not
 */
+ (BOOL)isAppleTV;

/**
 *  Check if the current device is an Apple Watch
 *
 *  @return Returns YES if it's an Apple Watch, NO if not
 */
+ (BOOL)isAppleWatch;

/**
 *  Check if the current device is the simulator
 *
 *  @return Returns YES if it's the simulator, NO if not
 */
+ (BOOL)isSimulator;

/**
 *  Check if the current device has a Retina display
 *
 *  @return Returns YES if it has a Retina display, NO if not
 */
+ (BOOL)isRetina DEPRECATED_MSG_ATTRIBUTE("Use +isRetina in UIScreen class");

/**
 *  Check if the current device has a Retina HD display
 *
 *  @return Returns YES if it has a Retina HD display, NO if not
 */
+ (BOOL)isRetinaHD DEPRECATED_MSG_ATTRIBUTE("Use +isRetinaHD in UIScreen class");

/**
 *  Returns the iOS version without the subversion
 *  Example: 7
 *
 *  @return Returns the iOS version
 */
+ (NSInteger)iOSVersion;

/**
 *  Returns the current device CPU frequency
 *
 *  @return Returns the current device CPU frequency
 */
+ (NSUInteger)cpuFrequency;

/**
 *  Returns the current device BUS frequency
 *
 *  @return Returns the current device BUS frequency
 */
+ (NSUInteger)busFrequency;

/**
 *  Returns the current device RAM size
 *
 *  @return Returns the current device RAM size
 */
+ (NSUInteger)ramSize;

/**
 *  Returns the current device CPU number
 *
 *  @return Returns the current device CPU number
 */
+ (NSUInteger)cpuNumber;

/**
 *  Returns the current device total memory
 *
 *  @return Returns the current device total memory
 */
+ (NSUInteger)totalMemory;

/**
 *  Returns the current device non-kernel memory
 *
 *  @return Returns the current device non-kernel memory
 */
+ (NSUInteger)userMemory;

/**
 *  Returns the current device total disk space
 *
 *  @return Returns the current device total disk space
 */
+ (NSNumber *)totalDiskSpace;

/**
 *  Returns the current device free disk space
 *
 *  @return Returns the current device free disk space
 */
+ (NSNumber *)freeDiskSpace;

/**
 *  Returns the current device MAC address
 *
 *  @return Returns the current device MAC address
 */
+ (NSString *)macAddress DEPRECATED_MSG_ATTRIBUTE("In iOS 7 and later, if you ask for the MAC address of an iOS device, the system returns the value 02:00:00:00:00:00");

/**
 *  Generate an unique identifier and store it into standardUserDefaults
 *
 *  @return Returns a unique identifier as a NSString
 */
+ (NSString *)uniqueIdentifier;
@end
