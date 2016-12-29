//
//  JWEmojiPageVC.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/24.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "JWEmojiPageVC.h"
#import "JWPlaceholderTextView.h"
#import "UIColor+themeColor.h"
#import "JWEmojiPanelViewController.h"

@interface JWEmojiPageVC ()<UIPageViewControllerDataSource>

@property (nonatomic, copy) void (^didSelectEmoji) (NSTextAttachment *);
@property (nonatomic, copy) void (^deleteEmoji)();

@end

@implementation JWEmojiPageVC

- (instancetype)initWithTextView:(JWPlaceholderTextView *)textView
{
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                    navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                  options:nil];
    if (self) {
        _didSelectEmoji = ^(NSTextAttachment *textAttachment) {
            NSAttributedString *emojiAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
            NSMutableAttributedString *mutableAttributeString = [[NSMutableAttributedString alloc] initWithAttributedString:textView.attributedText];
            [mutableAttributeString replaceCharactersInRange:textView.selectedRange withAttributedString:emojiAttributedString];
            textView.attributedText = mutableAttributeString;
            textView.textColor = [UIColor JWtitleColor];
            [textView insertText:@""];
            textView.font = [UIFont systemFontOfSize:16];
        };
        _deleteEmoji = ^ {
            [textView deleteBackward];
        };
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor JWthemeColor];
    
    JWEmojiPanelViewController *emojiPanelVC = [[JWEmojiPanelViewController alloc] initWithPageIndex:0];
    emojiPanelVC.didSelectEmoji = _didSelectEmoji;
    emojiPanelVC.deleteEmoji    = _deleteEmoji;
    if (emojiPanelVC != nil) {
        self.dataSource = self;
        [self setViewControllers:@[emojiPanelVC]
                       direction:UIPageViewControllerNavigationDirectionReverse
                        animated:NO
                      completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(JWEmojiPanelViewController *)vc
{
    int index = vc.pageIndex;
    
    if (index == 0) {
        return nil;
    } else {
        JWEmojiPanelViewController *emojiPanelVC = [[JWEmojiPanelViewController alloc] initWithPageIndex:index-1];
        emojiPanelVC.didSelectEmoji = _didSelectEmoji;
        emojiPanelVC.deleteEmoji    = _deleteEmoji;
        return emojiPanelVC;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(JWEmojiPanelViewController *)vc
{
    int index = vc.pageIndex;
    
    if (index == 6) {
        return nil;
    } else {
        JWEmojiPanelViewController *emojiPanelVC = [[JWEmojiPanelViewController alloc] initWithPageIndex:index+1];
        emojiPanelVC.didSelectEmoji = _didSelectEmoji;
        emojiPanelVC.deleteEmoji    = _deleteEmoji;
        return emojiPanelVC;
    }
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 7;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


@end
