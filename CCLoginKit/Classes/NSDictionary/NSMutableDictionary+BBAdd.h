//
//  NSMutableDictionary+BBAdd.h
//  BananaBall
//
//  Created by lidaoyuan on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (BBAdd)

- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey;

- (void)safe_removeObjectForKey:(id<NSCopying>)aKey;

@end
