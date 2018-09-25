//
//  NSDictionary+BBAdd.m
//  BananaBall
//
//  Created by lidaoyuan on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSDictionary+BBAdd.h"

@implementation NSDictionary (BBAdd)

- (id)safe_objectForKey:(id<NSCopying>)aKey
{
    if (aKey) {
        return [self objectForKey:aKey];
    }
    
    return nil;
}

@end
