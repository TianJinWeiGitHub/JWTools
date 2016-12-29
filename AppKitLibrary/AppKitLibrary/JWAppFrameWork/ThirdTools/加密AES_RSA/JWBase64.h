//
//  JWBase64.h
//  AppKitLibrary
//
//  Created by jinwei on 15/11/25.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMDefines.h"

@interface JWBase64 : NSObject

+(NSData *)encodeData:(NSData *)data;

+(NSData *)decodeData:(NSData *)data;

+(NSData *)encodeBytes:(const void *)bytes length:(NSUInteger)length;

+(NSData *)decodeBytes:(const void *)bytes length:(NSUInteger)length;

+(NSString *)stringByEncodingData:(NSData *)data;

+(NSString *)stringByEncodingBytes:(const void *)bytes length:(NSUInteger)length;

+(NSData *)decodeString:(NSString *)string;

+(NSData *)webSafeEncodeData:(NSData *)data
                      padded:(BOOL)padded;

+(NSData *)webSafeDecodeData:(NSData *)data;

+(NSData *)webSafeEncodeBytes:(const void *)bytes
                       length:(NSUInteger)length
                       padded:(BOOL)padded;


+(NSData *)webSafeDecodeBytes:(const void *)bytes length:(NSUInteger)length;

+(NSString *)stringByWebSafeEncodingData:(NSData *)data
                                  padded:(BOOL)padded;

+(NSString *)stringByWebSafeEncodingBytes:(const void *)bytes
                                   length:(NSUInteger)length
                                   padded:(BOOL)padded;

+(NSData *)webSafeDecodeString:(NSString *)string;



@end

@interface JWBase64 (PrivateMethods)

+(NSData *)baseEncode:(const void *)bytes
               length:(NSUInteger)length
              charset:(const char *)charset
               padded:(BOOL)padded;

+(NSData *)baseDecode:(const void *)bytes
               length:(NSUInteger)length
              charset:(const char*)charset
       requirePadding:(BOOL)requirePadding;

+(NSUInteger)baseEncode:(const char *)srcBytes
                 srcLen:(NSUInteger)srcLen
              destBytes:(char *)destBytes
                destLen:(NSUInteger)destLen
                charset:(const char *)charset
                 padded:(BOOL)padded;

+(NSUInteger)baseDecode:(const char *)srcBytes
                 srcLen:(NSUInteger)srcLen
              destBytes:(char *)destBytes
                destLen:(NSUInteger)destLen
                charset:(const char *)charset
         requirePadding:(BOOL)requirePadding;

@end
