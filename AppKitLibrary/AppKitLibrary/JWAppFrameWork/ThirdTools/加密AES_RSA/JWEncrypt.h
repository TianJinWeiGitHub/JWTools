//
//  JWEncrypt.h
//  AppKitLibrary
//
//  Created by jinwei on 15/11/25.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>


@interface JWEncrypt : NSObject

-(NSData *)encrypt:(NSString *)plainText usingKey:(SecKeyRef)key error:(NSError **)err;
-(NSData*)hexToBytes:(NSString*) s;
-(SecKeyRef)getKeyRefWithPersistentKeyRef:(CFTypeRef)persistentRef;
-(SecKeyRef)addPeerPublicKey:(NSData *)publicKey;
-(SecKeyRef)addPeerPublicKeyS:(NSString *)publicKey;
-(NSData *)encryptDataNoPadding:(NSData *)data usingKey:(SecKeyRef)key;
-(NSData *)des3EncryptData:(NSData *)data key:(NSData*)key;
-(NSDictionary *)encryptTwoPwd:(NSString *)pin withKey:(NSString *)key;

static NSString* bytesToHex(NSData* bs);
static int getSERLNO();
static NSData* getRandomBytes(int len);
static NSData* makeRsaData(Byte* ran);
static int bitCount(int v);
static void oddCheck(Byte* data,int len);
static NSData* getPinBlock(NSString* pin);


@end
