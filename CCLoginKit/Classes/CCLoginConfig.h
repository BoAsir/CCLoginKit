//
//  CCLoginConfig.h
//  LoginTest
//
//  Created by 路飞 on 2018/9/18.
//  Copyright © 2018年 lufei. All rights reserved.
//

FOUNDATION_EXPORT NSString * const CCLoginConfigHalfOpenDidLoginSuccess;//半开放登录成功
FOUNDATION_EXPORT NSString * const CCLoginConfigDidLoginSuccess;//登录成功
FOUNDATION_EXPORT NSString * const CCLoginConfigDidLogOut;//登出

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCLoginConfig : NSObject

@property (nonatomic, assign) BOOL needRealName;//是否需要实名认证
@property (nonatomic, assign) BOOL halfOpen;//是否半开放
@property (nonatomic, strong) NSURL *headUrl;//请求头


+(instancetype)shareInstance;

//是否需要实名认证
+(BOOL)isNeedRealName;

//是否半开放
+(BOOL)isHalfOpen;

//请求地址
+(NSURL *)loginHeadUrl;
@end

NS_ASSUME_NONNULL_END
