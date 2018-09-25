//
//  NSDictionary+BBAdd.h
//  BananaBall
//
//  Created by lidaoyuan on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BBAdd)


- (id)safe_objectForKey:(id<NSCopying>)aKey;

@end
