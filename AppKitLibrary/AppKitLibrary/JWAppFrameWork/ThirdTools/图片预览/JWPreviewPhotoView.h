//
//  JWPreviewPhotoView.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/29.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PHOSCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define PHOSCREENWIDTH [UIScreen mainScreen].bounds.size.width

@interface JWPreviewPhotoView : UIView


//每行展示的列数 默认3
@property (nonatomic, assign) int row;

//左右间距 默认10
@property (nonatomic, assign) float margin;

/** 数据附值后返回 自身高度
 */
- (float)setImageUrlsOfArray:(NSArray *)urls;


@end
