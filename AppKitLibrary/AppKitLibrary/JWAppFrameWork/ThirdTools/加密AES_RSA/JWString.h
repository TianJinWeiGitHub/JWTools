//
//  JWString.h
//  AppKitLibrary
//
//  Created by jinwei on 15/11/25.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWString : NSObject{
   
    NSString *base_string;
    
}

-(NSString *)getRandStr:(int)length;

-(NSString*) byte2hex:(Byte [])bytes length:(int)length;

-(NSString*) byteArray2hex:(NSArray *)bytes;

-(NSArray *)hex2byte:(NSString *)str;


@end
