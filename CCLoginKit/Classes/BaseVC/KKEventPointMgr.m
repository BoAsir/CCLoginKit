//
//  KKEventPointMgr.m
//  KKTribe
//
//  Created by adu on 2018/8/31.
//  Copyright © 2018 杭州鼎代. All rights reserved.
//

#import "KKEventPointMgr.h"
#import "NSDictionary+BBAdd.h"
#import "NSMutableDictionary+BBAdd.h"
@implementation KKEventPointMgr

+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static KKEventPointMgr *instance;
    dispatch_once(&onceToken, ^{
        instance = [[KKEventPointMgr alloc] init];
    });
    return instance;
}

+ (NSMutableDictionary *)appendEventPointWithDic:(NSMutableDictionary *)dic
{
    if ([KKEventPointMgr shareInstance].from.length>0 && [KKEventPointMgr shareInstance].to.length>0) {
        [dic safe_setObject:[KKEventPointMgr shareInstance].from forKey:@"from"];
        [dic safe_setObject:[KKEventPointMgr shareInstance].to forKey:@"to"];
    }
    
    return dic;
}

+(void)refreshWithSelfViewName:(NSString *)dbName
{
    [[KKEventPointMgr shareInstance] changeFromStrWith:dbName index:0];
}

-(void)changeFromStrWith:(NSString *)changedStr index:(NSInteger)index
{
    if (!changedStr) {
        return;
    }
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:@[@"null",@"null",@"null",@"null",@"null",@"null"]];
    NSArray *itemArr = [self.from componentsSeparatedByString:@"_"];

    for (int i = 0; i<6; i++) {
        if (i<index) {
            if (itemArr.count>i) {
                [mutArr replaceObjectAtIndex:i withObject:itemArr[i]];
            }
        }else if(i==index)
        {
            [mutArr replaceObjectAtIndex:i withObject:changedStr];
        }
    }
    
    self.from = [mutArr componentsJoinedByString:@"_"];
}
@end
