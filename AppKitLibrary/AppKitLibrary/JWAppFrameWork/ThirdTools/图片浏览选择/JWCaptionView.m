//
//  JWCaptionView.m
//  AppKitLibrary
//
//  Created by jinwei on 15/11/27.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "JWCaptionView.h"

static const CGFloat labelPadding = 10;

@interface JWCaptionView (){
    id<JWPhotoProtocol> _photo;
    UILabel *_label;
}

@end
@implementation JWCaptionView

- (id)initWithPhoto:(id<JWPhotoProtocol>)photo {
    self = [super initWithFrame:CGRectMake(0, 0, JW_kScreenW, 44)];
    if (self) {
        self.userInteractionEnabled = NO;
        _photo = photo;
        self.barStyle = UIBarStyleBlackTranslucent;
        self.tintColor = nil;
        self.barTintColor = nil;
        self.barStyle = UIBarStyleBlackTranslucent;
        [self setBackgroundImage:nil forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self setupCaption];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat maxHeight = 9999;
    if (_label.numberOfLines > 0) maxHeight = _label.font.leading*_label.numberOfLines;
    CGSize textSize = [_label.text boundingRectWithSize:CGSizeMake(size.width - labelPadding*2, maxHeight)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:_label.font}
                                                context:nil].size;
    return CGSizeMake(size.width, textSize.height + labelPadding * 2);
}

- (void)setupCaption {
    _label = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(labelPadding, 0,
                                                                      self.bounds.size.width-labelPadding*2,
                                                                      self.bounds.size.height))];
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _label.opaque = NO;
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    
    _label.numberOfLines = 0;
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:17];
    if ( _photo &&[_photo respondsToSelector:@selector(caption)]) {
        _label.text = [_photo caption] ? [_photo caption] : @" ";
    }
    [self addSubview:_label];
}

@end
