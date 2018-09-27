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
#import "CC_ClassyExtend.h"
#import "CCMacros.h"
#import "UserStateManager.h"

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
+(void)configHTTPHeaders:(NSString*)appName{
    [CCLoginConfig shareInstance].appName = appName;
    //设置请求头
    NSMutableDictionary *headers = [[NSMutableDictionary alloc]init];
    [headers setObject:appName forKey:@"appName"];
    [headers setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"appVersion"];
    [headers setObject:[NSString stringWithFormat:@"IOS_VERSION%fSCREEN_HEIGHT%d",IOS_VERSION,(int)SCREEN_HEIGHT] forKey:@"appUserAgent"];
    
    [[CC_HttpTask getInstance] setRequestHTTPHeaderFieldDic:headers];
    
    [[CC_HttpTask getInstance] addResponseLogic:@"SIGN_REQUIRED" logicStr:@"response,error,name=SIGN_REQUIRED" stop:0 popOnce:1 logicBlock:^(NSDictionary *resultDic) {
        [[UserStateManager shareInstance]presentLoginVC];
    }];
}
@end
