//
//  CCLoginConfig.m
//  LoginTest
//
//  Created by 路飞 on 2018/9/18.
//  Copyright © 2018年 lufei. All rights reserved.
//

NSString * const CCLoginConfigHalfOpenDidLoginSuccess = @"CCLoginConfigHalfOpenDidLoginSuccess";//半开放登录成功
NSString * const CCLoginConfigDidLoginSuccess = @"CCLoginConfigDidLoginSuccess";
NSString * const CCLoginConfigDidLogOut = @"CCLoginConfigDidLogOut";

#import "CCLoginConfig.h"

@implementation CCLoginConfig

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static CCLoginConfig *_sharedCCLoginConfig = nil;
    dispatch_once(&onceToken, ^{
        _sharedCCLoginConfig = [[CCLoginConfig alloc]init];
    });
    return _sharedCCLoginConfig;
}

-(instancetype)init{
    if (self = [super init]) {
        [self setUpInfo];
    }
    return self;
}

-(void)setUpInfo{
    self.needRealName = NO;
    self.halfOpen = NO;
}

+(BOOL)isNeedRealName{
    return [CCLoginConfig shareInstance].needRealName;
}

+(BOOL)isHalfOpen{
    return [CCLoginConfig shareInstance].halfOpen;
}

+(NSURL *)loginHeadUrl{
    if ([CCLoginConfig shareInstance].headUrl) {
        return [CCLoginConfig shareInstance].headUrl;
    }else{
        NSAssert(NO,@"请先配置登录请求头headUrl");
        return nil;
    }
}
@end
