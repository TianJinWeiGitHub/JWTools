//
//  JWEncrypt.m
//  AppKitLibrary
//
//  Created by jinwei on 15/11/25.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "JWEncrypt.h"

@implementation JWEncrypt

static char* CS="0123456789ABCDEF";

static NSString* bytesToHex(NSData* bs){
    NSInteger len = bs.length;
    char* cs = CS;
    unichar* rs = (unichar*)malloc(len << 2);
    char * ss = (char*)[bs bytes];
    for(int i = 0;i < len;i++){
        int b = ss[i] & 0xFF;
        rs[i + i] = cs[b >> 4];
        rs[i + i + 1] = cs[b & 0xF];
    }
    NSString* r= [NSString stringWithCharacters:rs length:len*2];
    free(rs);
    return r;
}


static int getSERLNO(){
    static int SERLNO=0;
    if(SERLNO==0){
        SERLNO=arc4random();
    }
    return SERLNO++;
}


static NSData* getRandomBytes(int len){
    char* cs=(char*)malloc(len);
    for(int i=0;i<len;i++){
        cs[i]=(char)arc4random();
    }
    return [NSData dataWithBytesNoCopy:cs length:len freeWhenDone:TRUE];
}


static NSData* makeRsaData(Byte* ran){
    char * bs=(char*)malloc(128);
    for(int i=0;i < 128;i++){
        if(bs[i] == 0){
            bs[i]=77;
        }
    }
    bs[0]=0;
    bs[1]=2;
    
    bs[97]=0;
    bs[98]=0x30;
    bs[99]=0x1c;
    bs[100]=0x04;
    bs[101]=0x10;
    memcpy(bs+102,ran,16);
    bs[118]=0x04;
    bs[119]=0x08;
    NSData * rd=[NSData dataWithBytesNoCopy:bs length:128 freeWhenDone:TRUE];
    return rd;
}


static int bitCount(int v){
    int r=0;
    for(int i=0;i<32;i++){
        if(v&(1<<i)){
            r++;
        }
    }
    return r;
}


static void oddCheck(Byte* data,int len){
    for(int i=0;i < len;i++){
        int t=data[i] & 0x7F;
        int p=bitCount(t);
        if((p & 1) == 0){
            t|=0x80;
        }
        data[i]=(Byte)t;
    }
}


static NSData* getPinBlock(NSString* pin){
    Byte* bs=(Byte*)malloc(8);
    NSInteger len=[pin length];
    memset(bs,0xFF,8);
    int ic=0;
    for(int i=0;i < 8 && ic < len;i++){
        unichar c=[pin characterAtIndex:ic++];
        bs[i]&=((c - '0') << 4) | 0xF;
        if(ic >= len){
            break;
        }
        c=[pin characterAtIndex:ic++];
        bs[i]&=(c - '0') | 0xF0;
    }
    return [NSData dataWithBytesNoCopy:bs length:8 freeWhenDone:TRUE];
}


- (NSData *)encrypt:(NSString *)plainText usingKey:(SecKeyRef)key error:(NSError **)err {
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = NULL;
    cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    memset((void *)cipherBuffer, 0x0, cipherBufferSize);
    NSData *plainTextBytes = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSInteger blockSize = cipherBufferSize - 11;
    int numBlock = (int)ceil([plainTextBytes length] / (double)blockSize);
    NSMutableData *encryptedData = [[NSMutableData alloc] init ];
    for (int i=0; i<numBlock; i++) {
        NSInteger bufferSize = MIN(blockSize, [plainTextBytes length] - i * blockSize);
        NSData *buffer = [plainTextBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(key, kSecPaddingPKCS1,
                                        (const uint8_t *)[buffer bytes],
                                        [buffer length], cipherBuffer,
                                        &cipherBufferSize);
        
        if (status == noErr) {
            NSData *encryptedBytes = [[NSData alloc]
                                       initWithBytes:(const void *)cipherBuffer
                                       length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
            
        } else {
            *err = [NSError errorWithDomain:@"errorDomain" code:status userInfo:nil];
            
            return nil;
        }
    }
    
    if (cipherBuffer) {
        free(cipherBuffer);
    }
    return encryptedData;
}


-(NSData*) hexToBytes:(NSString*) s{
    NSInteger len=s.length;
    unsigned char* bs=malloc(len>>1);
    int r=0;
    for(int i=0;i < len;i++){
        int n=[s characterAtIndex:i];
        if(n >= '0' && n <= '9'){
            n-='0';
        }
        else if(n >= 'A' && n <= 'F'){
            n-='A' - 10;
        }
        else if(n >= 'a' && n <= 'f'){
            n-='a' - 10;
        }
        if((i & 1) == 1){
            bs[i >> 1]=(unsigned char)(r | n);
        }
        else{
            r=n << 4;
        }
    }
    NSData * td=[NSData dataWithBytesNoCopy:bs length:len>>1 freeWhenDone:TRUE];
    return td;
}

- (SecKeyRef)getKeyRefWithPersistentKeyRef:(CFTypeRef)persistentRef
{
    OSStatus sanityCheck = noErr;
    SecKeyRef keyRef = NULL;
    
    NSMutableDictionary * queryKey = [[NSMutableDictionary alloc] init];
    
    
    [queryKey setObject:(__bridge id)persistentRef forKey:(id)kSecValuePersistentRef];
    [queryKey setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnRef];
    
    
    sanityCheck = SecItemCopyMatching((CFDictionaryRef)queryKey, (CFTypeRef *)&keyRef);
    
    return keyRef;
}


- (SecKeyRef)addPeerPublicKey:(NSData *)publicKey {
    OSStatus sanityCheck = noErr;
    SecKeyRef peerKeyRef = NULL;
    CFTypeRef persistPeer = NULL;
    
    NSString * peerName=@"PPPPP";
    NSData * peerTag = [[NSData alloc] initWithBytes:(const void *)[peerName UTF8String] length:[peerName length]];
    NSMutableDictionary * peerPublicKeyAttr = [[NSMutableDictionary alloc] init];
    
    [peerPublicKeyAttr setObject:(id)kSecClassKey forKey:(id)kSecClass];
    [peerPublicKeyAttr setObject:(id)kSecAttrKeyTypeRSA forKey:(id)kSecAttrKeyType];
    [peerPublicKeyAttr setObject:peerTag forKey:(id)kSecAttrApplicationTag];
    [peerPublicKeyAttr setObject:publicKey forKey:(id)kSecValueData];
    [peerPublicKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnPersistentRef];
    
    sanityCheck = SecItemAdd((CFDictionaryRef) peerPublicKeyAttr, (CFTypeRef *)&persistPeer);
    if(persistPeer==0){
        SecItemDelete((CFDictionaryRef) peerPublicKeyAttr);
        sanityCheck = SecItemAdd((CFDictionaryRef) peerPublicKeyAttr, (CFTypeRef *)&persistPeer);
    }
    
    if (persistPeer) {
        peerKeyRef = [self getKeyRefWithPersistentKeyRef:persistPeer];
    } else {
        [peerPublicKeyAttr removeObjectForKey:(id)kSecValueData];
        [peerPublicKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnRef];
        
        sanityCheck = SecItemCopyMatching((CFDictionaryRef) peerPublicKeyAttr, (CFTypeRef *)&peerKeyRef);
    }
    if (persistPeer) CFRelease(persistPeer);
    return peerKeyRef;
}

- (SecKeyRef)addPeerPublicKeyS:(NSString *)publicKey {
    return [self addPeerPublicKey:[self hexToBytes:publicKey]];
}




- (NSData *)encryptDataNoPadding:(NSData *)data usingKey:(SecKeyRef)key{
    uint8_t *buf = malloc([data length]);
    memset(buf, 0x0, [data length]);
    NSData * rdata=[NSData dataWithBytesNoCopy:buf length:[data length] freeWhenDone:TRUE];
    size_t outLen=128;
    OSStatus status = SecKeyEncrypt(key, kSecPaddingNone,
                                    [data bytes],[data length],
                                    buf,&outLen);
    
    if (status == noErr) {
        return rdata;
    } else {
        return nil;
    }
}


-(NSData *)des3EncryptData:(NSData *)data key:(NSData*)key{
    char buffer [64] ;
    memset(buffer, 0, sizeof(buffer));
    size_t bufferNumBytes=0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithm3DES,
                                          0,
                                          [key bytes],
                                          kCCKeySize3DES,
                                          NULL,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          64,
                                          &bufferNumBytes);
    if(cryptStatus == kCCSuccess){
        NSData *returnData =  [NSData dataWithBytes:buffer length:bufferNumBytes];
        return returnData;
    }
    
    return nil;
}


- (NSDictionary *)encryptBankInfo:(NSString *) bankInfo QUICKPK:(NSString *)QUICKPK
{
    SecKeyRef se = [self addPeerPublicKeyS:QUICKPK];
    NSData *bank=[self encrypt:bankInfo usingKey:se error:NULL];
    NSString *bi = bytesToHex(bank);
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init ];
    [dic setValue:bi forKey:@"BANKINFO"];
    
    return dic;
    
    
}


-(NSDictionary *)encryptTwoPwd:(NSString *)pin withKey:(NSString *)key
{
    
    NSData *b24 = getRandomBytes(24);
    Byte *testByte=(Byte *)[b24 bytes];
    oddCheck(testByte,24);
    memcpy(testByte+16,testByte,8);
    NSData* pb=getPinBlock(pin);
    NSString *pw = bytesToHex([self des3EncryptData:pb key:b24]);
    
    
    pw = [pw substringWithRange:NSMakeRange(0, 16)];
    NSData *rsaK = makeRsaData((Byte*)[b24 bytes]);
    if (key.length == 0){
        return nil;
    }
    SecKeyRef se=[self addPeerPublicKeyS:key];
    
    NSData * td=[self encryptDataNoPadding:rsaK usingKey:se];
    
    NSString *pk = bytesToHex(td);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init ];
    [dic setValue:pw forKey:@"paypwd"];
    [dic setValue:pk forKey:@"paykey"];
    return dic;
}


@end
