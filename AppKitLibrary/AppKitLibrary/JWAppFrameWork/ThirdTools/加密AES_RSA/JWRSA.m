//
//  JWRSA.m
//  AppKitLibrary
//
//  Created by jinwei on 15/11/25.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "JWRSA.h"
#import "JWPKFrom.h"
#import "JWString.h"
#import <stdlib.h>
#import "JWEncrypt.h"
#import "JWBase64.h"

@implementation JWRSA

- (id)init
{
    self = [super init];
    eb_length = 128;
    placeholder_length = 3;
    transfer_key = 16;
    data_length = 30;
    hisunStr = [[JWString alloc]init];
    hisunPkFrom = [[JWPKFrom alloc]init];
    return self;
}

-(NSArray *)getPinBlock4Login:(NSString *)loginPwd{
    NSInteger pwdLen=[loginPwd length];
    NSInteger length = eb_length - placeholder_length-pwdLen;
    NSString *fillStr = [self getRandFillStr:(int)length];
    
    char pinBlockByte[eb_length];
    pinBlockByte[0]=0x00;
    pinBlockByte[1]=0x02;
    
    for (int i=0; i<[fillStr length]; i++) {
        pinBlockByte[i+2] = [fillStr characterAtIndex:i];
    }
    NSInteger startIndex=2+[fillStr length];
    pinBlockByte[startIndex]=0x00;
    NSInteger startLen=startIndex+1;
    for (int i=0; i<[loginPwd length]; i++) {
        pinBlockByte[startLen+i]=[loginPwd characterAtIndex:i];
    }
    
    NSMutableArray *pinArray = [[NSMutableArray alloc]init];
    for (int i=0; i<eb_length; i++) {
        [pinArray addObject:[NSNumber numberWithChar:pinBlockByte[i]]];
    }
    
    return pinArray;
    
}

-(NSString *)getRandFillStr:(int) length{
    NSString *fillStr=[hisunStr getRandStr:length];
    return fillStr;
}

-(NSArray *)getTransferKey4Pay:(NSArray *)transferArray{
    int randLength = eb_length - data_length -placeholder_length;
    NSString *fillStr =[self getRandFillStr:randLength];
    //NSString *fillStr=@"F6OVR4XS0O3O5A1MUFEUR58O9ZJ40Z97X2COPQKIYZ3BGNU2DSFF7OG73DRFSJX4H9V91KYNKC77IQQRGZD5FAOZ3D581IA";
    char pinBlockByte[eb_length];
    pinBlockByte[0]=0x00;
    pinBlockByte[1]=0x02;
    
    for (int i=0; i<[fillStr length]; i++) {
        pinBlockByte[i+2] = [fillStr characterAtIndex:i];
    }
    NSInteger startIndex = 2+[fillStr length];
    pinBlockByte[startIndex]=0x00;
    NSInteger startLen = 3+[fillStr length];
    pinBlockByte[startLen]=0x30;
    pinBlockByte[startLen +1]=0x1C;
    pinBlockByte[startLen +2]=0x04;
    pinBlockByte[startLen +3]=0x10;
    NSInteger followLen=startLen+4;
    
    for (int i=0; i<[transferArray count]; i++) {
        pinBlockByte[followLen+i] = [[transferArray objectAtIndex:i] charValue];
    }
    
    NSInteger pLen = followLen + [transferArray count];
    pinBlockByte[pLen]=0x04;
    pinBlockByte[pLen+1]=0x08;
    NSInteger nIndex=pLen+2;
    for (NSInteger i=nIndex; i<eb_length; i++) {
        pinBlockByte[i]=(char)0xFF;
    }
    NSMutableArray *pinArray = [[NSMutableArray alloc]init];
    for (int i=0; i<eb_length; i++) {
        [pinArray addObject:[NSNumber numberWithChar:pinBlockByte[i]]];
    }
    return pinArray;
}

-(NSString *)getRandKeyOdd:(NSString *)str{
    NSArray *btArray = [NSArray arrayWithArray:[hisunStr hex2byte:str]];
    NSArray *tmpBtArray = [NSArray arrayWithArray:[self keyXorFun:btArray]];
    NSInteger len=[tmpBtArray count];
    char bt[len];
    for (int i=0; i<len; i++) {
        bt[i]=[[tmpBtArray objectAtIndex:i] charValue];
    }
    NSString *odd = [NSString stringWithString:[hisunStr byte2hex:bt length:(int)len]];
    return odd;
    
}

-(NSString *)makeTransferKey{
    
    char randChar[transfer_key];
    for (int i=0; i<transfer_key; i++) {
        randChar[i]=arc4random();
    }
    NSString *generateRandStr = [NSString stringWithString:[hisunStr byte2hex:randChar length:transfer_key]];
    //NSString *generateRandStr1=@"8425338F11D92F8699CD54636981A403";
    NSString *key = [NSString stringWithString:[self getRandKeyOdd:generateRandStr]];
    return key;
}

-(NSArray *) keyXorFun:(NSArray *)buf{
    
    NSMutableArray *buffArray = [[NSMutableArray alloc]init];
    for (int i=0; i<[buf count]; i++) {
        char tmpChar= [self keyBitXorFun:[[buf objectAtIndex:i] charValue]];
        [buffArray addObject:[NSNumber numberWithChar:tmpChar]];
    }
    return buffArray;
}

-(char) keyBitXorFun:(char)buf{
    int i =0;
    char ch=0;
    char val=0;
    ch = (char)(buf&-2);
    for (i=7; i>0; i--) {
        val ^=1&ch>>i;
    }
    val ^=1;
    val = (char)(ch|val);
    return val;
}

-(NSArray *)str2Bcd:(NSString *) asc{
    NSInteger len = [asc length];
    NSInteger mod=len%2;
    NSMutableString *mutableAsc = [[NSMutableString alloc] init];
    
    if(mod !=0){
        [mutableAsc appendFormat:@"0"];
        [mutableAsc appendFormat:asc];
        len = [mutableAsc length];
    }
    else {
        [mutableAsc appendFormat:asc];
    }
    
    
    char *abt = (char*)malloc((sizeof(char)*(len+1)));
    if (len>=2) {
        len = len/2;
    }
    
    char bbt[len];
    abt = [mutableAsc UTF8String];
    int j,k;
    for (int p=0; p<[mutableAsc length]/2; p++) {
        if ((abt[2*p]>='0')&&(abt[2*p]<='9')) {
            j=abt[2*p]-'0';
        }else if ((abt[2*p]>='a')&&(abt[2*p]<='z')) {
            j=abt[2*p]-'a'+0x0a;
        }else {
            j=abt[2*p]-'A'+0x0a;
        }
        
        if ((abt[2*p+1]>='0')&&(abt[2*p+1]<='9')) {
            k=abt[2*p+1]-'0';
        }else if ((abt[2*p+1]>='a')&&(abt[2*p+1]<='z')) {
            k=abt[2*p+1]-'a'+0x0a;
        }else {
            
            j=abt[2*p+1]-'A'+0x0a;
        }
        
        int a=(j<<4)+k;
        char b=(char)a;
        bbt[p]=b;
        
    }
    NSMutableArray *bbtArray = [[NSMutableArray alloc] init];
    for (int i=0; i<len; i++) {
        [bbtArray addObject:[NSNumber numberWithChar:bbt[i]]];
    }
    //free(abt);
    return bbtArray;
    
    
}
-(BOOL)isOddNumber:(NSString *)transferByte{
    return YES;
}

static NSString* bytesToHex1(NSData* bs){
    int len=bs.length;
    char* cs="0123456789ABCDEF";
    unichar* rs=(unichar*)malloc(len << 2);
    char * ss=(char*)[bs bytes];
    for(int i=0;i < len;i++){
        int b=ss[i] & 0xFF;
        rs[i + i]=cs[b >> 4];
        rs[i + i + 1]=cs[b & 0xF];
    }
    NSString* r= [NSString stringWithCharacters:rs length:len*2];
    free(rs);
    return r;
}

//-(NSString *)encryptLoginPwd:(NSString *)loginPwd derPk:(NSString *)derPk{
//
//    HisunEncrypt* hisunEnc = [[HisunEncrypt alloc]init];
//    SecKeyRef se=[hisunEnc addPeerPublicKeyS:[OrderEntity Instance].publicKey];
//    //    NSDictionary *dic = [hisunEnc encryptTwoPwd:paypsw];//加密支付密码
//
//    NSData * loginpwd=[hisunEnc encrypt:loginPwd usingKey:se error:NULL];//加密登录密码
//	NSString *tmpSvrpsw = bytesToHex1(loginpwd);
//    [hisunEnc release];
//    return tmpSvrpsw;

//	NSArray *pinBlock = [self getPinBlock4Login:loginPwd];
//	NSString *pinBlockHexStr= [hisunStr byteArray2hex:pinBlock];
//	[hisunPkFrom UnionGetPKOutOfRacalHsmCmdReturnStr:derPk];
//
//	BIGNUM *bnn,*bne;
//	bnn = BN_new();
//	bne=BN_new();
//	BN_hex2bn(&bnn, [hisunPkFrom.pkMod cStringUsingEncoding:NSUTF8StringEncoding]);
//	BN_hex2bn(&bne, [hisunPkFrom.pkEvl cStringUsingEncoding:NSUTF8StringEncoding]);
//
//	RSA *rsa= RSA_new();
//	rsa->n=bnn;
//	rsa->e=bne;
//	int len=RSA_size(rsa);
//	RSA_print_fp(stdout, rsa, 5);
//	unsigned char *pszClipherText = (unsigned char *)(malloc(sizeof(unsigned char)*len));
//
//	NSLog(@"pinblockHexstr = %@",pinBlockHexStr);
//
//	unsigned char *tmp_pinBlockHexStr = (unsigned char*)malloc(sizeof(unsigned char)*128);
//	NSArray *tmp=[hisunStr hex2byte:pinBlockHexStr];
//
//	for (int i=0; i<128; i++) {
//
//		tmp_pinBlockHexStr[i]=[[tmp objectAtIndex:i] charValue];
//
//	}
//
//	int nRet = RSA_public_encrypt(128, tmp_pinBlockHexStr, pszClipherText, rsa, RSA_NO_PADDING);
//	if (nRet<0) {
//		NSLog(@"encryptLoginPwd encrypt error!");
//	}
//
//	NSString *out1 = [hisunStr byte2hex:pszClipherText length:128];
//	NSLog(@"decrypted data = %@",out1);
//	BN_clear_free(bnn);
//	BN_clear_free(bne);
//	return out1;
//}

-(NSString *)encryptLoginPwd:(NSString *)loginPwd publicKey:(NSString *)publicKey{
    
    JWEncrypt*Enc = [[JWEncrypt alloc]init];
    SecKeyRef se=[Enc addPeerPublicKeyS:publicKey];
    //    NSDictionary *dic = [hisunEnc encryptTwoPwd:paypsw];//加密支付密码
    
    NSData * loginpwd=[Enc encrypt:loginPwd usingKey:se error:NULL];//加密登录密码
    NSString *tmpSvrpsw = bytesToHex1(loginpwd);
    return tmpSvrpsw;
}

-(NSArray *)encryptPayPwd:(NSString *)payPwd publicKey:(NSString*)publicKey{
    
    JWEncrypt* hisunEnc = [[JWEncrypt alloc]init];
    SecKeyRef se=[hisunEnc addPeerPublicKeyS:publicKey];
    NSDictionary *dic = [hisunEnc encryptTwoPwd:payPwd withKey:publicKey];//加密支付密码
    NSMutableArray *encAndKey = [[NSMutableArray alloc] init];
    [encAndKey addObject:[dic objectForKey:@"paypwd"]];
    [encAndKey addObject:[dic objectForKey:@"paykey"]];
    return encAndKey;
}
//-(NSArray *)encryptPayPwd:(NSString *)payPwd derPk:(NSString*)derPk{
//
//    HisunEncrypt* hisunEnc = [[HisunEncrypt alloc]init];
//    SecKeyRef se=[hisunEnc addPeerPublicKeyS:[OrderEntity Instance].publicKey];
//    NSDictionary *dic = [hisunEnc encryptTwoPwd:payPwd];//加密支付密码
//    [hisunEnc release];
//
//
//	NSMutableArray *encAndKey = [[[NSMutableArray alloc] init] autorelease];
//	[encAndKey addObject:[dic objectForKey:@"paypwd"]];
//	[encAndKey addObject:[dic objectForKey:@"paykey"]];
//	return encAndKey;

//	NSString *transferKey = [NSString stringWithString:[self makeTransferKey]];
//	NSArray *transferArray = [hisunStr hex2byte:transferKey];
//	NSArray *keyPinBlock = [self getTransferKey4Pay:transferArray];
//	NSString *pinBlockHexStr = [hisunStr byteArray2hex:keyPinBlock];
//	//NSString *pinBlockHexStr =transferKey;
//	NSLog(@"pinBlockHexStr = %@",pinBlockHexStr);
//	[hisunPkFrom UnionGetPKOutOfRacalHsmCmdReturnStr:derPk];
//
//
//	//RSA加密
//	BIGNUM *bnn,*bne;
//	bnn = BN_new();
//	bne = BN_new();
//	BN_hex2bn(&bnn, [hisunPkFrom.pkMod cStringUsingEncoding:NSUTF8StringEncoding]);
//	BN_hex2bn(&bne, [hisunPkFrom.pkEvl cStringUsingEncoding:NSUTF8StringEncoding]);
//
//	RSA *rsa = RSA_new();
//	rsa->n = bnn;
//	rsa->e = bne;
//	RSA_print_fp(stdout, rsa, 5);
//
//	int len = RSA_size(rsa);
//	unsigned char *pszClipherText = (unsigned char*)(malloc(sizeof(unsigned char)*len));
//	unsigned char *tmp_pinBlockHexStr = (unsigned char*)malloc(sizeof(unsigned char)*128);
//	NSArray *tmp=[hisunStr hex2byte:pinBlockHexStr];
//
//	for (int i=0; i<128; i++) {
//
//		tmp_pinBlockHexStr[i]=[[tmp objectAtIndex:i] charValue];
//
//	}
//	int nRet = RSA_public_encrypt(128, tmp_pinBlockHexStr, pszClipherText, rsa, RSA_NO_PADDING);
//	if (nRet<0) {
//		NSLog(@"RSA_public_encrypt error!");
//	}
//
//	NSString *keyEncStr = [hisunStr byte2hex:pszClipherText length:128];
//	NSLog(@"encrypted data ==%@",keyEncStr);
//	BN_clear_free(bnn);
//	BN_clear_free(bne);
//
//
//	//3Des加密
//	unsigned char k1[8];
//
//	for (int i=0; i<8; i++) {
//		k1[i]=[[transferArray objectAtIndex:i] unsignedCharValue];
//	}
//
//	char k2[8];
//	for (int i=0; i<8; i++) {
//		k2[i] = [[transferArray objectAtIndex:i+8] unsignedCharValue];
//	}
//
//	unsigned char payPinBlock[8];
//	NSArray *payBcd=[self str2Bcd:payPwd];
//	for (int i=0; i<[payBcd count]; i++) {
//		payPinBlock[i]=[[payBcd objectAtIndex:i] unsignedCharValue];
//	}
//	for (int i=[payBcd count]; i<8; i++) {
//		payPinBlock[i]=(char)0xFF;
//	}
//	NSString *payPinStr=[hisunStr byte2hex:payPinBlock length:8];
//	NSLog(@"payPinStr = %@",payPinStr);
//
//
//
//	char COut[8];
//
//	DES_key_schedule key_schedule1,key_schedule2,key_schedule3;
//	int ret = DES_set_key_checked(&k1, &key_schedule1);
//	if (ret<0) {
//		NSLog(@"set key1 checked error!");
//	}
//	int ret1 = DES_set_key_checked(&k2, &key_schedule2);
//	if (ret1<0) {
//		NSLog(@"set key2 checked error!");
//	}
//	int ret2 = DES_set_key_checked(&k1, &key_schedule3);
//	if (ret2<0) {
//		NSLog(@"set key1 checked error!");
//	}
//	DES_ecb3_encrypt(&payPinBlock,&COut, &key_schedule1, &key_schedule2, &key_schedule3, DES_ENCRYPT);
//	NSString *encPwd = [hisunStr byte2hex:COut length:8];
//	NSLog(@"encPwd =%@",encPwd);
//	NSMutableArray *encAndKey = [[[NSMutableArray alloc] init] autorelease];
//	[encAndKey addObject:encPwd];
//	[encAndKey addObject:keyEncStr];
//	return encAndKey;
//}


#pragma mark -- 获取本地的文件 然后读取seckey

-(SecKeyRef)getPublicKey{
    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"keystore" ofType:@"p7b"];
    SecCertificateRef myCertificate = nil;
    NSData *certificateData = [[NSData alloc] initWithContentsOfFile:certPath];
    myCertificate = SecCertificateCreateWithData(kCFAllocatorDefault, (CFDataRef)certificateData);
    SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
    SecTrustRef myTrust;
    OSStatus status = SecTrustCreateWithCertificates(myCertificate,myPolicy,&myTrust);
    SecTrustResultType trustResult;
    if (status == noErr) {
        status = SecTrustEvaluate(myTrust, &trustResult);
    }
    return SecTrustCopyPublicKey(myTrust);
}

-(NSString *)RSAEncrypotoTheData:(NSString *)plainText
{
    
    SecKeyRef publicKey=nil;
    publicKey=[self getPublicKey];
    size_t cipherBufferSize = SecKeyGetBlockSize(publicKey);
    uint8_t *cipherBuffer = NULL;
    
    cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    memset((void *)cipherBuffer, 0*0, cipherBufferSize);
    
    NSData *plainTextBytes = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSInteger blockSize = cipherBufferSize-11;  // 这个地方比较重要是加密数组长度
    NSInteger numBlock = (int)ceil([plainTextBytes length] / (double)blockSize);
    NSMutableData *encryptedData = [[NSMutableData alloc] init];
    for (int i=0; i<numBlock; i++) {
        NSInteger bufferSize = MIN(blockSize,[plainTextBytes length]-i*blockSize);
        NSData *buffer = [plainTextBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(publicKey,
                                        kSecPaddingPKCS1,
                                        (const uint8_t *)[buffer bytes],
                                        [buffer length],
                                        cipherBuffer,
                                        &cipherBufferSize);
        if (status == noErr)
        {
            NSData *encryptedBytes = [[NSData alloc]
                                       initWithBytes:(const void *)cipherBuffer
                                       length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
        }
        else
        {
            return nil;
        }
    }
    if (cipherBuffer)
    {
        free(cipherBuffer);
    }
    NSString *encrypotoResult=[NSString stringWithFormat:@"%@",[JWBase64 stringByEncodingData:encryptedData]];
    return encrypotoResult;
}

@end
