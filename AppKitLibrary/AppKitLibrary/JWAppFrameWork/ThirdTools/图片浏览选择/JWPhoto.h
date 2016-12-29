//
//  JWPhoto.h
//  AppKitLibrary
//
//  Created by jinwei on 15/11/27.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "JWPhotoProtocol.h"

@interface JWPhoto : NSObject<JWPhotoProtocol>

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic) BOOL emptyImage;
@property (nonatomic) BOOL isVideo;

+ (JWPhoto *)photoWithImage:(UIImage *)image;
+ (JWPhoto *)photoWithURL:(NSURL *)url;
+ (JWPhoto *)photoWithAsset:(PHAsset *)asset targetSize:(CGSize)targetSize;
+ (JWPhoto *)videoWithURL:(NSURL *)url; // Initialise video with no poster image

- (id)init;
- (id)initWithImage:(UIImage *)image;
- (id)initWithURL:(NSURL *)url;
- (id)initWithAsset:(PHAsset *)asset targetSize:(CGSize)targetSize;
- (id)initWithVideoURL:(NSURL *)url;


@end
