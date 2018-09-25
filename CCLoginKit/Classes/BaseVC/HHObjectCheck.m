//
//  HHObjectCheck.m
//  HHSLive
//
//  Created by 郦道元  on 2017/7/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HHObjectCheck.h"

@implementation HHObjectCheck

+(BOOL)isEmpty:(id)obj
{
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)obj;
        
        NSString *trimStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([trimStr isEqualToString:@""] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] || [str isEqualToString:@"<nil>"]) {
            return YES;
        }
    } else if ([obj respondsToSelector:@selector(length)]
               && [(NSData *)obj length] == 0) {
        return YES;
    } else if ([obj respondsToSelector:@selector(count)]
               && [(NSArray *)obj count] == 0) {
        return YES;
    }
    return NO;
    
}

@end
