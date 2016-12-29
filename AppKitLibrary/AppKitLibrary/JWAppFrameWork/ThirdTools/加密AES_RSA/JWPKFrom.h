//
//  JWPKFrom.h
//  AppKitLibrary
//
//  Created by jinwei on 15/11/25.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWPKFrom : NSObject
{
    NSString *pkMod;
    NSString *pkEvl;
    int pkLen;
}

@property(nonatomic,retain)NSString *pkMod;
@property(nonatomic,retain)NSString *pkEvl;

@property (assign)int pkLen;

-(NSString*) byte2hex:(Byte [])bytes length:(int)length;

-(NSArray *)hex2byte:(NSString *)str;

-(NSString *)UnionGetPKOutOfRacalHsmCmdReturnStr:(NSString *)racalPK;


@end
