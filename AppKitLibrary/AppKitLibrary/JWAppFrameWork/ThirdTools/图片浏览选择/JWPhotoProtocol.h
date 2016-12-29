//
//  JWPhotoProtocol.h
//  AppKitLibrary
//
//  Created by jinwei on 15/11/27.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JWPHOTO_LOADING_DID_END_NOTIFICATION @"JWPHOTO_LOADING_DID_END_NOTIFICATION"
#define JWPHOTO_PROGRESS_NOTIFICATION @"JWPHOTO_PROGRESS_NOTIFICATION"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define JW_kScreenW [UIScreen mainScreen].bounds.size.width

#define JW_kScreenH [UIScreen mainScreen].bounds.size.height


#if DEBUG // Set to 1 to enable debug logging
#define JWLog(x, ...) NSLog(x, ## __VA_ARGS__);
#else
#define JWLog(x, ...)
#endif

@protocol JWPhotoProtocol <NSObject>

/** 返回底层UIImage的要显示*/
@property (nonatomic, strong) UIImage *underlyingImage;

/**加载下面的图像，并通知*/
- (void)loadUnderlyingImageAndNotify;

/**执行负载下面的图像，并通知*/
- (void)performLoadUnderlyingImageAndNotify;

/** 卸载下面的图像*/
- (void)unloadUnderlyingImage;

@optional

/** 如果照片是空的，在这种情况下，不显示加载错误图标*/
@property (nonatomic) BOOL emptyImage;

/** 是否是视频*/
@property (nonatomic) BOOL isVideo;

/** 获取视频*/
- (void)getVideoURL:(void (^)(NSURL *url))completion;

/** 返回一个字符串，标题要在图像显示*/
- (NSString *)caption;

/** 取消图像数据的任何后台加载*/
- (void)cancelAnyLoading;



@end
