//
//  JWEmojiPanelViewController.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/24.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWEmojiPanelViewController : UIViewController

- (instancetype)initWithPageIndex:(int)pageIndex;

@property (nonatomic, readonly, assign) int pageIndex;

@property (nonatomic, copy) void (^didSelectEmoji)(NSTextAttachment *textAttachment);

@property (nonatomic, copy) void (^deleteEmoji)();

@end
