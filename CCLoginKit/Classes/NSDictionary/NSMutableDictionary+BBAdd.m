//
//  NSMutableDictionary+BBAdd.m
//  BananaBall
//
//  Created by lidaoyuan on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSMutableDictionary+BBAdd.h"

@implementation NSMutableDictionary (BBAdd)
- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!aKey) {
        return;
    }
    if (!anObject) {
        [self removeObjectForKey:aKey];
        return;
    }
    [self setObject:anObject forKey:aKey];
}

- (void)safe_removeObjectForKey:(id<NSCopying>)aKey
{
    if (aKey) {
        [self removeObjectForKey:aKey];
    }
}
@end
