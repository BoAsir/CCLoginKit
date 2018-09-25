//
//  main.m
//  3DES研究
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 apple. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface JKEncrypt : NSObject

/**字符串加密 */
-(NSString *)doEncryptStr:(NSString *)originalStr;
/**字符串解密 */
-(NSString*)doDecEncryptStr:(NSString *)encryptStr;
-(NSString*)doDecEncryptStr:(NSString *)encryptStr withKey:(NSString *)keyString;

/**十六进制解密 */
-(NSString *)doEncryptHex:(NSString *)originalStr;
/**十六进制加密 */
-(NSString*)doDecEncryptHex:(NSString *)encryptStr;

//-(NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt;

@end
