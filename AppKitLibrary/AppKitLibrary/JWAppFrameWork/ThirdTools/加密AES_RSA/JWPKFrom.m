//
//  JWPKFrom.m
//  AppKitLibrary
//
//  Created by jinwei on 15/11/25.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "JWPKFrom.h"

@implementation JWPKFrom

@synthesize pkMod;
@synthesize pkEvl;
@synthesize pkLen;

-(id)init{
    self = [super init];
    pkMod = @"";
    pkEvl = @"";
    pkLen = 0;
    
    return self;
}


-(NSString*) byte2hex:(Byte [])bytes length:(int)length {
    NSMutableString *hex = [NSMutableString string];
    // unsigned char *bytes = (unsigned char *)[data bytes];
    //char *bytes = ( char *)[data bytes];
    char temp[3];
    int i = 0;
    for (i = 0; i < length; i++) {
        temp[0] = temp[1] = temp[2] = 0;
        (void)sprintf(temp, "%02X", bytes[i]);
        [hex appendString:[NSString stringWithUTF8String: temp]];
    }
    return hex;
}

-(NSArray *)hex2byte:(NSString *)str{
    NSInteger len = [str length];
    NSString *stmp=@"";
    NSMutableArray *byteArray = [[NSMutableArray alloc]init];
    
    for (int n=0; n<len/2; n++) {
        NSRange range = NSMakeRange(n*2, 2);
        stmp = [str substringWithRange:range];
        char tt=( char)strtoul([stmp UTF8String], 0, 16);
        NSNumber *charNum = [NSNumber numberWithChar:tt];
        [byteArray addObject:charNum];
    }
    
    return byteArray;
}


-(NSString *)UnionGetPKOutOfRacalHsmCmdReturnStr:(NSString *)racalPK{
    if (racalPK == nil) {
        return nil;
    }
    int offset=0;
    int lenOfNextPart=0;
    NSArray *racalPKStr=[self hex2byte:racalPK];
    NSNumber *charNUM =[racalPKStr objectAtIndex:offset];
    //NSNumber *charNUM= [NSNumber numberWithChar:47];
    if([charNUM compare:[NSNumber numberWithChar:48]]){
        //if ([[racalPKStr indexOfObject:offset]  isEqualToNumber:48]) {
        return nil;
    }
    offset++;
    if (([[racalPKStr objectAtIndex:offset] charValue]&0xFF) <= 128) {
        
        lenOfNextPart = [[racalPKStr objectAtIndex:offset] charValue]&0xFF;
        offset++;
    }else {
        int bitsOfLenFlag=([[racalPKStr objectAtIndex:offset] charValue]&0xFF)-128;
        offset++;
        int i=0;
        lenOfNextPart=0;
        while (i<bitsOfLenFlag) {
            lenOfNextPart +=[[racalPKStr objectAtIndex:offset] charValue]&0xFF;
            i++;
            offset++;
        }
    }
    
    //int lenOfStr= lenOfNextPart+offset;
    if (([[racalPKStr objectAtIndex:offset] charValue]&0xFF)!=2) {
        return nil;
    }
    offset++;
    lenOfNextPart--;
    
    int lenOfPk=0;
    if (([[racalPKStr objectAtIndex:offset] charValue]&0xFF)<=128) {
        lenOfPk = [[racalPKStr objectAtIndex:offset] charValue]&0xFF;
        offset++;
    }else {
        int bitsOfLenFlag=([[racalPKStr objectAtIndex:offset] charValue]&0xFF)-128;
        offset++;
        int i=0;
        lenOfPk=0;
        while (i<bitsOfLenFlag) {
            lenOfPk +=[[racalPKStr objectAtIndex:offset] charValue]&0xFF;
            i++;
            offset++;
        }
        
    }
    
    for (; lenOfPk%8 !=0; lenOfPk--) {
        if (([[racalPKStr objectAtIndex:offset] charValue]&0xFF) !=0) {
            return nil;
        }
        offset++;
    }
    
    char LPk[lenOfPk+1];
    
    int tmpOffset = offset;
    for (int i=0; i<lenOfPk; i++) {
        LPk[i] = [[racalPKStr objectAtIndex:tmpOffset] charValue];
        tmpOffset++;
    }
    LPk[lenOfPk]='\0';
    
    NSString *pk = [self byte2hex:LPk length:lenOfPk];
    self.pkMod=pk;
    
    offset += lenOfPk;
    int lenOfEval=0;
    if ([[racalPKStr objectAtIndex:offset] charValue]!=2) {
        return nil;
    }
    offset++;
    lenOfEval= [[racalPKStr objectAtIndex:offset] charValue];
    offset++;
    
    char LPEvl[lenOfEval+1];
    int tmpOffsetEvl = offset;
    for (int i=0; i<lenOfEval; i++) {
        LPEvl[i] = [[racalPKStr objectAtIndex:tmpOffsetEvl] charValue];
        //[racalPKStr description];
        tmpOffsetEvl++;
    }
    LPEvl[lenOfEval]='\0';
    offset+=lenOfEval;
    
    self.pkLen = offset;
    self.pkEvl = [self byte2hex:LPEvl length:lenOfEval];
    
    return pk;
    
    
    
}

@end
