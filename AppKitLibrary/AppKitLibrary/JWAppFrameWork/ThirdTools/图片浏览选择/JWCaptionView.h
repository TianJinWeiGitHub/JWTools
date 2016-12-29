//
//  JWCaptionView.h
//  AppKitLibrary
//
//  Created by jinwei on 15/11/27.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWPhotoProtocol.h"

@interface JWCaptionView : UIToolbar

- (instancetype)initWithPhoto:(id<JWPhotoProtocol>)photo;

- (CGSize)sizeThatFits:(CGSize)size;

@end
