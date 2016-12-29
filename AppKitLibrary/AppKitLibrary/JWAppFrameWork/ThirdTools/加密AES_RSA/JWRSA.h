//
//  JWRSA.h
//  AppKitLibrary
//
//  Created by jinwei on 15/11/25.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JWString,JWPKFrom;

@interface JWRSA : NSObject{
    int eb_length;
    int placeholder_length;
    int transfer_key;
    int data_length;
    
    JWString *hisunStr;
    JWPKFrom *hisunPkFrom;
}

-(NSArray *)getPinBlock4Login:(NSString *)loginPwd;

-(NSString *)getRandFillStr:(int) length;

-(NSArray *)getTransferKey4Pay:(NSArray *)transferArray;

-(NSString *)getRandKeyOdd:(NSString *)str;

-(NSString *)makeTransferKey;

-(NSArray *) keyXorFun:(NSArray *)buf;

-(char) keyBitXorFun:(char)buf;

-(NSArray *)str2Bcd:(NSString *) asc;

-(BOOL)isOddNumber:(NSString *)transferByte;

//-(NSString *)encryptLoginPwd:(NSString *)loginPwd derPk:(NSString *)derPk;
//-(NSArray *)encryptPayPwd:(NSString *)payPwd derPk:(NSString*)derPk;

-(NSString *)encryptLoginPwd:(NSString *)loginPwd publicKey:(NSString *)publicKey;//加密登录密码
-(NSArray *)encryptPayPwd:(NSString *)payPwd publicKey:(NSString*)publicKey;//加密支付密码

/** 使用本地加密*/
-(NSString *)RSAEncrypotoTheData:(NSString *)plainText;



@end
