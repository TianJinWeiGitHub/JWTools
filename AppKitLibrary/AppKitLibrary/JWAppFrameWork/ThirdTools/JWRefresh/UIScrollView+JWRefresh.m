//
//  UIScrollView+JWRefresh.m
//  AppKitLibrary
//
//  Created by why_ios on 2016/12/29.
//  Copyright © 2016年 jinwei group. All rights reserved.
//

#import "UIScrollView+JWRefresh.h"
#import <objc/runtime.h>
#import "JWRefreshHeadView.h"

static NSString *KEY_PATH = @"contentOffset";
static char JWRefreshIndicatorKey;

@implementation UIScrollView (JWRefresh)


- (void)setJw_header:(JWRefreshHeadView *)jw_header
{
    if (jw_header != self.jw_header) {
        [self.jw_header removeFromSuperview];
        
        [self willChangeValueForKey:@"jw_header"];
        objc_setAssociatedObject(self, &JWRefreshIndicatorKey,jw_header,OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"jw_header"];
        
        [self addSubview:jw_header];
    }

}

-(JWRefreshHeadView *)jw_header
{
    return objc_getAssociatedObject(self, &JWRefreshIndicatorKey);
}




#pragma mark - 重写
- (void)setFrame:(CGRect)frame
{
    if (self.frame.size.width != frame.size.width) {
        [self centerSub:frame.size.width];
    }
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    if (self.bounds.size.width != bounds.size.width) {
        [self centerSub:bounds.size.width];
    }
    [super setBounds:bounds];
}
//indicator居中
- (void)centerSub:(CGFloat)width
{
    CGRect frame = self.jw_header.frame;
    frame.size.width = width;
    frame.origin.x = (width - frame.size.width) / 2.l;
    self.jw_header.frame = frame;
}


#pragma mark - 添加刷新事件

- (void)addRefreshBlock:(void (^)())block
{
    self.delaysContentTouches = NO;
    
    self.jw_header = [[JWRefreshHeadView alloc]init];
    CGRect frame = self.jw_header.frame;
    frame.origin.y = -frame.size.height;
    frame.size.width = self.bounds.size.width;
    self.jw_header.frame = frame;
    self.jw_header.js_startRefreshBlock = block;
    
    [self addObserver:self forKeyPath:KEY_PATH options:NSKeyValueObservingOptionNew context:nil];

}




- (void)didChangeValueForKey:(NSString *)key
{
    
    CGFloat move_y = self.contentOffset.y + self.contentInset.top;
    NSLog(@"------%f",move_y);

    if ([key isEqualToString:KEY_PATH] && move_y <= 0) {
        self.jw_header.jw_progress = -move_y;
    }
  
}


/** 刷新结束*/
- (void)finishRefresh:(BOOL)isSucess
{
    [[self jw_header]refreshFinish:isSucess];
}

- (void)dealloc
{
//    [self removeObserver:self forKeyPath:KEY_PATH context:nil];
}


@end
