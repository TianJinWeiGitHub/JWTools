//
//  JWSquarePhotoViewController.m
//  Bshopkeeper
//
//  Created by jinwei on 15/5/23.
//  Copyright (c) 2015年 jinwei. All rights reserved.
//

#import "JWSquarePhotoViewController.h"
#import "JWScrollPhotoView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImageView+WebCache.h"


#define  p_height [UIScreen mainScreen].bounds.size.height

#define p_width [UIScreen mainScreen].bounds.size.width


@interface JWSquarePhotoViewController ()<UIScrollViewDelegate>
{
    UIScrollView *backScrollView;
    NSInteger currentIndex;
}

@end

@implementation JWSquarePhotoViewController

- (instancetype)initWithImgs:(NSArray *)list withCurrentIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        currentIndex = index;
        if (list) {
            _imageUrls = [NSMutableArray arrayWithArray:list];
        }else{
            _imageUrls = [NSMutableArray array];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    backScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    backScrollView.delegate = self;
    backScrollView.backgroundColor = [UIColor blackColor];
    backScrollView.pagingEnabled = YES;
    backScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*[self.imageUrls count], CGRectGetHeight(self.view.frame));
    backScrollView.autoresizingMask = self.view.autoresizingMask;
    [self.view addSubview:backScrollView];
    backScrollView.showsHorizontalScrollIndicator = NO;
    backScrollView.showsVerticalScrollIndicator = NO;
    self.view.backgroundColor = [UIColor blackColor];
    
    if (currentIndex== 0 ||currentIndex>self.imageUrls.count) {
        currentIndex = 1;
    }
    
    for (int i= 0; i< self.imageUrls.count;i++)
    {
        JWScrollPhotoView* image = [[JWScrollPhotoView alloc]initWithFrame:CGRectMake(p_width*i, 0, p_width, p_height)];
        
        NSString *imageUrl = [self.imageUrls objectAtIndex:i];
        
        if (imageUrl) {
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
//            imageUrl = [imageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "]];
//#else
//            imageUrl =  [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//#endif
            [image setimageWith:[NSURL URLWithString:imageUrl]];
        }
        image.translatesAutoresizingMaskIntoConstraints = NO;
        image.tag = 101+i;
        image.contentMode = UIViewContentModeScaleAspectFit;
        image.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
        image.backgroundColor = [UIColor clearColor];
        [backScrollView addSubview:image];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onDismiss)];
        [image addGestureRecognizer:tap];
        image.userInteractionEnabled = YES;
        
    }
    self.pageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, p_width-40, 24)];
    self.pageLabel.font = [UIFont systemFontOfSize:18];
    self.pageLabel.textColor = [UIColor whiteColor];
        self.pageLabel.textAlignment = NSTextAlignmentRight;
    self.pageLabel.backgroundColor = [UIColor clearColor];
    self.pageLabel.text = [NSString stringWithFormat:@"%d/%lu",1,(unsigned long)_imageUrls.count];
    [self.view addSubview:self.pageLabel];
    
    _downLoadBtn = [[UIButton alloc]initWithFrame:CGRectMake(p_width-60, p_height-60, 40, 40)];
    _downLoadBtn.backgroundColor = [UIColor clearColor];
    [_downLoadBtn setImage:[UIImage imageNamed:@"icon_downLoad_img.png"] forState:UIControlStateNormal];
    _downLoadBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_downLoadBtn addTarget:self action:@selector(clickDownLoadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_downLoadBtn];    
    backScrollView.contentOffset = CGPointMake((currentIndex-1)*backScrollView.bounds.size.width, 0);
    
    
}

- (void)clickDownLoadBtnAction:(id)sender
{
    
    JWScrollPhotoView* image  = (JWScrollPhotoView *)[backScrollView viewWithTag:100+currentIndex];
    if (!image)return;
    
    __weak __typeof (self) weakself = self;

    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];
    [assetsLibrary writeImageToSavedPhotosAlbum:[image.imageView.image CGImage] orientation:(ALAssetOrientation)image.imageView.image.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 100, 20)];
        label.text = error?@"保存失败":@"保存成功";
        label.backgroundColor = [UIColor blackColor];
        [label sizeToFit];
        label.center = weakself.view.center;
        label.layer.cornerRadius = 5;
        label.textColor = [UIColor whiteColor];
        [weakself.view addSubview:label];
        __weak __typeof (label) blabel = label;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakself) {
                if (blabel) {
                    [blabel removeFromSuperview];
                }
            }
        });
        
       
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    currentIndex = scrollView.contentOffset.x/p_width + 1;
    if (currentIndex != 0) {
        self.pageLabel.text = [NSString stringWithFormat:@"%d/%lu",currentIndex,(unsigned long)_imageUrls.count];
        
    }
    
}

- (void)dealloc{
    _imageUrls = nil;
    _downLoadBtn = nil;
}

- (void) onDismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
