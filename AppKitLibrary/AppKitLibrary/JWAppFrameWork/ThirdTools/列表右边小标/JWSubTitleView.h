//
//  JWSubTitleView.h
//  AppKitLibrary
//
//  Created by secoo02 on 15/11/23.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JWSubtitleViewDelegate <NSObject>

-(void)touchEndPoint:(CGPoint )point andWithSelectedTag:(int)tag;

@end

@interface JWSubTitleView : UIView

@property (nonatomic, assign) id<JWSubtitleViewDelegate>delegate;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end


@interface JWSubTitleLabel : UILabel

@property (nonatomic, assign) int fromValue;


@end