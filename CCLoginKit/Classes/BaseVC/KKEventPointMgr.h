//
//  KKEventPointMgr.h
//  KKTribe
//
//  Created by adu on 2018/8/31.
//  Copyright © 2018 杭州鼎代. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKEventPointMgr : NSObject
@property(nonatomic,copy) NSString *from;
@property(nonatomic,copy) NSString *to;

+(instancetype)shareInstance;

+(NSMutableDictionary *)appendEventPointWithDic:(NSMutableDictionary *)dic;

/**
 * @brief 更改from的第x个参数以及把x后面的参数置为null. 比如之前是a_b_c_d_e_f，调这个方法x=3,index=3;就会将from变为a_b_x_null_null_null;
 */
-(void)changeFromStrWith:(NSString *)changedStr index:(NSInteger )index;

+(void)refreshWithSelfViewName:(NSString *)dbName;

@end
