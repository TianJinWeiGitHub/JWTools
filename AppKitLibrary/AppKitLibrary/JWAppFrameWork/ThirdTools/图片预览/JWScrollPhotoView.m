//
//  JWScrollPhotoView.m
//  Bshopkeeper
//
//  Created by jinwei on 15/3/30.
//  Copyright (c) 2015年 jinwei. All rights reserved.
//

#import "JWScrollPhotoView.h"
#import <CommonCrypto/CommonDigest.h>
#import "SDImageCache.h"


@interface JWScrollPhotoView ()
{
    NSString *diskCachePath;
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0

@property (nonatomic, strong) NSURLSession *currentSession;
@property (strong, nonatomic) NSURLSessionDownloadTask *cancellableTask;

#endif

@end

@implementation JWScrollPhotoView

@synthesize imageView;
@synthesize imageUrl;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setDelegate:self];
        [self setMaximumZoomScale:3.0];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin| UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.imageView];
        
    }
    return self;
}

-(void)startLoadImage
{
    if (self.imageUrl) {
        return;
    }
    [self startLoadImageWithUrl:self.imageUrl];
}


-(void)setimageWith:(NSURL *)url
{
    self.imageUrl = url;
    [self startLoadImageWithUrl:url];
}


-(void)startLoadImageWithUrl:(NSURL*)url
{
    if (!url) {
        return ;
    }
    diskCachePath = [self getCachePath];
    NSString *pathString = [self cachePathForKey:[url absoluteString]];
    UIImage *cacheImage = SDScaledImageForKey([url absoluteString], [UIImage imageWithContentsOfFile:pathString]);
    if (cacheImage)
    {
        self.imageView.image = cacheImage;
        return;
    }
    
    
    NSURL *requestUrl = [NSURL URLWithString:[url absoluteString]];
    NSURLRequest* request = [NSURLRequest requestWithURL:requestUrl];
    
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
//    NSURLSessionDownloadTask *downTask = [[NSURLSession sharedSession]downloadTaskWithRequest:request];
//    
//    
//#else
    
    connect = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connect start];
//#endif
    
    if (!progressView) {
        progressView = [[JWCircleProgressView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-53.5,10 , 50, 50) backColor:[UIColor blackColor] progressColor:[UIColor whiteColor] lineWidth:4];
        [progressView setProgressLabelHidden:NO];
        progressView.center = self.imageView.center;
        [self.imageView addSubview:progressView];
    }
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.imageView.image = [UIImage imageNamed:@"icon_image_default.png"];
    if (self) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 100, 20)];
        label.text = @"加载大图失败";
        label.backgroundColor = [UIColor blackColor];
        [label sizeToFit];
        label.center = self.center;
        label.layer.cornerRadius = 5;
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        __weak __typeof (self) weakself = self;
        __weak __typeof (label) blabel = label;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakself) {
                if (blabel) {
                    [blabel removeFromSuperview];
                }
            }
        });
    }
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    httpData = nil;
    httpData = [[NSMutableData alloc]initWithCapacity:0];
    dataLenth = response.expectedContentLength;
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [httpData appendData:data];
    if (dataLenth >0) {
        float p = [httpData length]/dataLenth;
        [progressView setCurrentProgress:p];
    }
    
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage* httpImage = [UIImage imageWithData:httpData];
    self.imageView.image = httpImage;
    [progressView removeFromSuperview];
    progressView = nil;
    if (httpData)
    {
        [[NSFileManager defaultManager] createFileAtPath:[self cachePathForKey:[self.imageUrl absoluteString]] contents:httpData attributes:nil];
    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


-(NSString*)getCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString* path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ImageCache"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:diskCachePath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
    return path;
}

- (NSString *)cachePathForKey:(NSString *)key
{
    if (!key) {
        return nil;
    }
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return [diskCachePath stringByAppendingPathComponent:filename];
}


// 9.0以后用这个下载获取当前进度

//- (void)createCurrentSession {
//    
//    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
//    self.currentSession = [NSURLSession sessionWithConfiguration:defaultConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//    self.currentSession.sessionDescription = self.description;
//}
//
//- (void)cancellableDownload
//{
//    if (!self.cancellableTask) {
//        if (!self.currentSession) {
//            [self createCurrentSession];
//        }
//        if (self.imageUrl) return;
//        
//        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageUrl];
//        self.cancellableTask = [self.currentSession downloadTaskWithRequest:request];
//        self.imageView.image = nil;
//        [self.cancellableTask resume];
//        
//    }
//}
//
//- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
// completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler
//{
//    
//}
//


@end
