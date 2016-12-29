//
//  JWRefreshHeadView.h
//  AppKitLibrary
//
//  Created by why_ios on 2016/12/29.
//  Copyright © 2016年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWRefreshHeadView : UIView

/** 拉取范围*/
@property ( nonatomic, assign ) CGFloat jw_progress;

/** 开始刷新*/
@property ( nonatomic, copy ) void (^js_startRefreshBlock)();


/** 刷新结果*/
- (void)refreshFinish:(BOOL)isSuccess;

@end
