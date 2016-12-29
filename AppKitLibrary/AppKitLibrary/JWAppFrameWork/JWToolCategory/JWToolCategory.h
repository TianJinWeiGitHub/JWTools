//
//  JWToolCategory.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/17.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#ifndef JWToolCategory_h
#define JWToolCategory_h

#import <Foundation/Foundation.h>

#import "NSData+JWKit.h"
#import "NSDate+JWKit.h"
#import "NSFileManager+JWKit.h"
#import "NSString+JWKit.h"
#import "NSArray+JWKit.h"
#import "NSNumber+JWKit.h"
#import "NSThread+JWKit.h"
#import "NSObject+JWKit.h"
#import "NSMutableArray+JWKit.h"
#import "NSMutableDictionary+JWKit.h"
#import "NSString+Html.h"
#import "NSNull+JWKit.h"

#import <UIKit/UIKit.h>
#import "UIView+JWKit.h"
#import "UIBarButtonItem+JWKit.h"
#import "UIBarButtonItem+Badge.h"
#import "UIButton+JWActivityIndicator.h"
#import "UIButton+JWKit.h"
#import "UIButton+Badge.h"
#import "UIColor+JWKit.h"
#import "UIDevice+JWKit.h"
#import "UIFont+JWKit.h"
#import "UIImage+JWKit.h"
#import "UIImage+JWQRCode.h"
#import "UIImageView+JWKit.h"
#import "UILabel+JWLabel.h"
#import "UINavigationBar+JWKit.h"
#import "UIScreen+JWKit.h"
#import "UIScrollView+JWKit.h"
#import "UIScrollView+ScalableCover.h"
#import "UITableView+JWKit.h"
#import "UITextField+JWKit.h"
#import "UITextView+JWKit.h"
#import "UIToolbar+JWKit.h"
#import "UIWebView+JWKit.h"
#import "UIWindow+JWKit.h"
#import "TJWCustomTextView.h"


#define BFLocalizedString(key, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:@"JWKit"]

#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]


#endif /* JWToolCategory_h */
