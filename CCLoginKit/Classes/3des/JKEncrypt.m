//
//  main.m
//  3DES研究
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "JKEncrypt.h"
#import <CommonCrypto/CommonDigest.h>  
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import "GTMBase64.h"

//密匙 key
#define gkey            @"cD6JFvclXnWbW57W056bKoVDGp2KlA2z"
//偏移量
#define gIv             @""


@implementation JKEncrypt

//字符串
-(NSString *)doEncryptStr:(NSString *)originalStr{
    
    //把string 转NSData
    NSData* data = [originalStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //length
    size_t plainTextBufferSize = [data length];
    
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    //偏移量
    const void *vinitVec = (const void *) [gIv UTF8String];
    
//    配置CCCrypt
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES, //3DES
                       kCCOptionECBMode|kCCOptionPKCS7Padding, //设置模式
                       vkey,    //key
                       kCCKeySize3DES,
                       vinitVec,     //偏移量，这里不用，设置为nil;不用的话，必须为nil,不可以为@“”
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [GTMBase64 stringByEncodingData:myData];
    return result;
}



-(NSString*)doDecEncryptStr:(NSString *)encryptStr{
    
    NSData *encryptData = [GTMBase64 decodeData:[encryptStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    {
        NSData *encryptData = [GTMBase64 decodeData:[gkey dataUsingEncoding:NSUTF8StringEncoding]];
        
//        size_t plainTextBufferSize = [encryptData length];
        const void *vplainText = [encryptData bytes];
        vkey=vplainText;
    }
    
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding|kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                      length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    
    
    return result;
}

-(NSString*)doDecEncryptStr:(NSString *)encryptStr withKey:(NSString *)keyString{
    
    NSData *encryptData = [GTMBase64 decodeData:[encryptStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [keyString UTF8String];
    {
        NSData *encryptData = [GTMBase64 decodeData:[keyString dataUsingEncoding:NSUTF8StringEncoding]];
        
        //        size_t plainTextBufferSize = [encryptData length];
        const void *vplainText = [encryptData bytes];
        vkey=vplainText;
    }
    
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding|kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    
    
    return result;
}


//十六进制
-(NSString *)doEncryptHex:(NSString *)originalStr{
    
    //把string 转NSData
    NSData* data = [originalStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //length
    size_t plainTextBufferSize = [data length];
    
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    //偏移量
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    //配置CCCrypt
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES, //3DES
                       kCCOptionECBMode|kCCOptionPKCS7Padding, //设置模式
                       vkey,    //key
                       kCCKeySize3DES,
                       vinitVec,     //偏移量，这里不用，设置为nil;不用的话，必须为nil,不可以为@“”
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const char *)bufferPtr length:(NSUInteger)movedBytes];
    
    NSUInteger          len = [myData length];
    char *              chars = (char *)[myData bytes];
    NSMutableString *   hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
        [hexString appendString:[NSString stringWithFormat:@"%0.2hhx", chars[i]]];
    
    return hexString;
    
}



-(NSString*)doDecEncryptHex:(NSString *)encryptStr{
    
    //十六进制转NSData
    long len = [encryptStr length] / 2;
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    for (i=0; i < [encryptStr length] / 2; i++) {
        byte_chars[0] = [encryptStr characterAtIndex:i*2];
        byte_chars[1] = [encryptStr characterAtIndex:i*2+1];
        *whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    
    NSData *encryptData = [NSData dataWithBytes:buf length:len];
    
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding|kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    
    
    return result;
}


//-(NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt
//{
//    
//    const void *vplainText;
//    size_t plainTextBufferSize;
//    
//    if (encryptOrDecrypt == kCCDecrypt)//解密
//    {
//        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
//        plainTextBufferSize = [EncryptData length];
//        vplainText = [EncryptData bytes];
//    }
//    else //加密
//    {
//        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
//        plainTextBufferSize = [data length];
//        vplainText = (const void *)[data bytes];
//    }
//    
//    CCCryptorStatus ccStatus;
//    uint8_t *bufferPtr = NULL;
//    size_t bufferPtrSize = 0;
//    size_t movedBytes = 0;
//    
//    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
//    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
//    memset((void *)bufferPtr, 0x0, bufferPtrSize);
//    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
//    
//    const void *vkey = (const void *)[DESKEY UTF8String];
//    // NSString *initVec = @"init Vec";
//    //const void *vinitVec = (const void *) [initVec UTF8String];
//    //  Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
//    ccStatus = CCCrypt(encryptOrDecrypt,
//                       kCCAlgorithm3DES,
//                       kCCOptionPKCS7Padding | kCCOptionECBMode,
//                       vkey,
//                       kCCKeySize3DES,
//                       nil,
//                       vplainText,
//                       plainTextBufferSize,
//                       (void *)bufferPtr,
//                       bufferPtrSize,
//                       &movedBytes);
//    //if (ccStatus == kCCSuccess) BBLOG(@"SUCCESS");
//    /*else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
//     else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
//     else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
//     else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
//     else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
//     else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED"; */
//    
//    NSString *result;
//    
//    if (encryptOrDecrypt == kCCDecrypt)
//    {
//        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
//                                                                length:(NSUInteger)movedBytes]
//                                        encoding:NSUTF8StringEncoding];
//    }
//    else
//    {
//        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
//        result = [GTMBase64 stringByEncodingData:myData];
//    }
//    
//    return result;
//}

@end
