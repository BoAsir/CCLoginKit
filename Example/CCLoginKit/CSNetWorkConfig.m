//
//  CSNetWorkConfig.m
//  LotteryOrderSystem
//
//  Created by lidaoyuan on 2018/6/28.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "CSNetWorkConfig.h"
#import "CCMacros.h"
#import "CC_GHttpSessionTask.h"
#import "UserStateManager.h"
static  NSString *develop_url = @"http://mapi.kkbuluo.net/client/service.json?";
static NSString *product_url = @"http://mapi.kkbuluo.com/client/service.json?";

/**
 0: 开发环境
 1: 生产环境
 */
static NSInteger url_choose = 0;


@implementation CSNetWorkConfig

+(NSURL *)currentUrl
{
    switch (url_choose) {
        case 0:
            return [NSURL URLWithString:develop_url] ;
            break;
        case 1:
            return [NSURL URLWithString:product_url];
            break;
        default:
        {
            return [NSURL URLWithString:product_url];
        }
            break;
    }
}

+(NSString *)groupCurrentUrl
{
    switch (url_choose) {
        case 0:
            return @"http://immapi.xjq.net/service.json" ;
            break;
        case 1:
            return @"http://immapi.xjball.com/service.json";
            break;
        default:
        {
            return @"http://immapi.xjball.com/service.json";
        }
            break;
    }
}
+(NSString *)getJCZJREQUEST
{
    switch (url_choose) {
        case 0:
            return develop_url ;
            break;
        case 1:
            return product_url;
            break;
        default:
        {
            return product_url;
        }
            break;
    }
}
+ (NSString *)getAPPLEPAY_MID
{
    return @"merchant.com.czthd.pro";
}
+(NSString *)getBTSCORE
{
    switch (url_choose) {
        case 0:
            return @"http://btapi.huored.net/service.json?";
            break;
        case 1:
            return @"http://btapi.jczj123.com/service.json?";
            break;
        default:
        {
            return @"http://btapi.jczj123.com/service.json";
        }
            break;
    }
}

+(NSString *)getFTSCORE
{
    switch (url_choose) {
        case 0:
            return @"http://ftapi.huored.net/service.json?";
            break;
        case 1:
            return @"http://ftapi.jczj123.com/service.json?";
            break;
        default:
        {
            return @"http://ftapi.jczj123.com/service.json";
        }
            break;
    }
}

+(NSString *)getFIGURESCOREREQUEST;
{
    switch (url_choose) {
        case 0:
            return @"http://ft.huored.net";
            break;
        case 1:
            return @"http://ft.jczj123.com";
            break;
        default:
        {
            return @"http://ft.jczj123.com";
        }
            break;
    }
}
+(NSString *)getBTFIGURESCOREREQUEST
{
    
    switch (url_choose) {
        case 0:
            return @"http://bt.huored.net";
            break;
        case 1:
            return @"http://bt.jczj123.com";
            break;
        default:
        {
            return @"http://bt.jczj123.com";
        }
            break;
    }
}

+(void)configHTTPHeaders
{
    //设置请求头
    NSMutableDictionary *headers = [[NSMutableDictionary alloc]init];
    [headers setObject:@"kk_iphone" forKey:@"appName"];
    [headers setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"appVersion"];
    [headers setObject:[NSString stringWithFormat:@"IOS_VERSION%fSCREEN_HEIGHT%d",IOS_VERSION,(int)SCREEN_HEIGHT] forKey:@"appUserAgent"];
    
    [[CC_HttpTask getInstance] setRequestHTTPHeaderFieldDic:headers];
    
    [[CC_HttpTask getInstance] addResponseLogic:@"SIGN_REQUIRED" logicStr:@"response,error,name=SIGN_REQUIRED" stop:1 popOnce:1 logicBlock:^(NSDictionary *resultDic) {
        [[UserStateManager shareInstance]presentLoginVC];
    }];
}



+(void)configSignKey
{
//     [CC_HttpTask getInstance].signKeyStr = [KKLoginUserInfo userInfo].signKey;
}
+(void)configExtreParams
{
//    //设置signKey以及authedUserId
//
//    if ([CC_HttpTask getInstance].extreDic) {
//        NSMutableDictionary *newExtreDic = [[CC_HttpTask getInstance].extreDic mutableCopy];
//        [newExtreDic setObject: [KKLoginUserInfo userInfo].staffId  forKey:@"authedUserId"];
//        [newExtreDic setObject:[KKLoginUserInfo userInfo].loginKey forKey:@"loginKey"];
//        [CC_HttpTask getInstance].extreDic = newExtreDic;
//    }else{
//        NSDictionary *newExtreDic = [[NSDictionary alloc]initWithObjectsAndKeys:[KKLoginUserInfo userInfo].staffId,@"authedUserId",[KKLoginUserInfo userInfo].loginKey,@"loginKey", nil];
//        [CC_HttpTask getInstance].extreDic = newExtreDic;
//    }
    
}


+(void)clearUserInfo
{
//    [CC_HttpTask getInstance].signKeyStr = nil;
//    if([CC_HttpTask getInstance].extreDic){
//        NSMutableDictionary *newExtreDic = [[CC_HttpTask getInstance].extreDic mutableCopy];
//        [newExtreDic removeObjectForKey:@"authedUserId"];
//        [newExtreDic removeObjectForKey:@"loginKey"];
//        [CC_HttpTask getInstance].extreDic = newExtreDic;
//    }
}

@end
