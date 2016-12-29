//
//  JWString.m
//  AppKitLibrary
//
//  Created by jinwei on 15/11/25.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "JWString.h"

@implementation JWString

- (id)init{
    self =[super init];
    base_string = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    return self;
    
}

-(NSString *)getRandStr:(int)length{
    NSMutableString *sb = [[NSMutableString alloc] init];
    for (int i=0; i<length; i++) {
        int number = arc4random()%36;
        [sb appendString:[base_string substringWithRange:NSMakeRange(number,1)]];
    }
    return sb;
}

-(NSString*) byte2hex:(Byte [])bytes length:(int)length {
    NSMutableString *hex = [[NSMutableString alloc] init];
    char temp[3];
    int i = 0;
    for (i = 0; i < length; i++) {
        temp[0] = temp[1] = temp[2] = 0;
        (void)sprintf(temp, "%02X", bytes[i]);
        [hex appendString:[NSString stringWithUTF8String: temp]];
    }
    return hex;
}


-(NSString*) byteArray2hex:(NSArray *)bytes {
    
    char temp[3];
    int i = 0;
    NSMutableString *tmpHex = [[NSMutableString alloc] initWithCapacity:16];
    for (i = 0; i < [bytes count]; i++) {
        temp[0] = temp[1] = temp[2] = 0;
        unsigned char ch=[[bytes objectAtIndex:i] charValue];
        (void)sprintf(temp, "%02X", ch);
        [tmpHex appendString:[NSString stringWithUTF8String: temp]];
        
    }
    
    return tmpHex;
    
    
}

-(NSArray *)hex2byte:(NSString *)str{
    NSInteger len = [str length];
    NSString *stmp= @"";
    NSMutableArray *byteArray = [[NSMutableArray alloc]init];
    
    for (int n=0; n<len/2; n++) {
        NSRange range = NSMakeRange(n*2, 2);
        stmp = [str substringWithRange:range];
        char tt=( char)strtoul([stmp UTF8String], 0, 16);
        NSNumber *charNum = [NSNumber numberWithChar:tt];
        [byteArray addObject:charNum];
        //NSLog(@"string = %d",tt);
    }
    
    return byteArray;
}

@end
