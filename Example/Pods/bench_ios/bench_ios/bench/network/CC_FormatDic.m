//
//  AppFormatDic.m
//  AppleToolProj
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CC_FormatDic.h"
#import "CC_MD5Object.h"

@implementation CC_FormatDic

+ (NSMutableString *)getFormatStringWithDic: (NSMutableDictionary *)dic{
    NSMutableString *formatString=[[NSMutableString alloc]init];
    
    NSArray *keysArray = [dic allKeys];
    NSArray *resultArray = [keysArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
        
    }];
    
    for (NSString *categoryId in resultArray) {
        [formatString appendString:[NSString stringWithFormat:@"%@=%@&",categoryId,[dic objectForKey:categoryId]]];
    }
    
    NSRange range = NSMakeRange (formatString.length-1, 1);
    [formatString deleteCharactersInRange:range];
    
    return formatString;
}

+ (NSMutableString *)getSignFormatStringWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString{
    NSMutableString *formatString=[[NSMutableString alloc]init];
    NSMutableString *urlFormatString=[[NSMutableString alloc]init];
    
    NSMutableDictionary *newDic=[[NSMutableDictionary alloc]initWithDictionary:dic];
    
    NSArray *keysArray = [newDic allKeys];
    NSArray *resultArray = [keysArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
        
    }];
    
    for (NSString *categoryId in resultArray) {
        NSString *tempString=( NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL, /* allocator */
                                                                                                    (CFStringRef)[NSString stringWithFormat:@"%@",[newDic objectForKey:categoryId]],
                                                                                                    NULL, /* charactersToLeaveUnescaped */
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]<>&\\",kCFStringEncodingUTF8)) ;
        
        
        if (tempString.length>0) {//参数为空不放入
            [urlFormatString appendString:[NSString stringWithFormat:@"%@=%@&",categoryId,tempString]];
            
            [formatString appendString:[NSString stringWithFormat:@"%@=%@&",categoryId,[newDic objectForKey:categoryId]]];
        }
        
    }
    
    if (formatString.length>0) {
        NSRange range = NSMakeRange (formatString.length-1, 1);
        [formatString deleteCharactersInRange:range];
    }
    
    if (MD5KeyString) {
        [urlFormatString appendString:[NSString stringWithFormat:@"sign=%@",[CC_MD5Object signString:[NSString stringWithFormat:@"%@%@",MD5KeyString,formatString]]]];
    }
    
    return urlFormatString;
}

@end
