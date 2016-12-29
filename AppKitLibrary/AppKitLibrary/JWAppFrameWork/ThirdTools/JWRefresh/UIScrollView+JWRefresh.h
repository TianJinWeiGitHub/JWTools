//
//  UIScrollView+JWRefresh.h
//  AppKitLibrary
//
//  Created by why_ios on 2016/12/29.
//  Copyright © 2016年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWRefreshHeadView.h"

@interface UIScrollView (JWRefresh)


/** 设置刷新功能*/
- (void)addRefreshBlock:(void (^)())block;


/** 刷新结束*/
- (void)finishRefresh:(BOOL)isSucess;


@end
