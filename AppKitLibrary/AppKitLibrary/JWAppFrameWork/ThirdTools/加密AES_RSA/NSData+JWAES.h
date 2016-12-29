//
//  NSData+JWAES.h
//  AppKitLibrary
//
//  Created by jinwei on 15/11/25.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JWAES)

- (NSData *)AES256EncryptWithKey:(NSData *)key;   //加密
- (NSData *)AES256DecryptWithKey:(NSData *)key;   //解密

- (NSString *)newStringInBase64FromData;            //追加64编码
+ (NSString*)base64encode:(NSString*)str;           //同上64编码

@end
