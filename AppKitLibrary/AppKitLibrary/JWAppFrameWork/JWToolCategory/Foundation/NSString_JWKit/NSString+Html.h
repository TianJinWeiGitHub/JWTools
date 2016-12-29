//
//  NSString+Html.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/23.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Html)
/**转义html
 */
- (NSString *)escapeHTML;

/**删除html标签
 */
- (NSString *)deleteHTMLTag;


- (NSString*)pinyin;

@end
