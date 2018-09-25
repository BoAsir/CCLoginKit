//
//  CSNetWorkConfig.h
//  LotteryOrderSystem
//
//  Created by lidaoyuan on 2018/6/28.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 彩世网络配置
 */
@interface CSNetWorkConfig : NSObject

/**
 获取当前的域名以及路径

 @return 当前请求地址
 */
+(NSURL *)currentUrl;

/**
 获取群聊当前的域名以及路径
 
 @return 当前请求地址
 */
+(NSString *)groupCurrentUrl;


/**
 投注等从jczj拷来的代码
 */
+(NSString *)getJCZJREQUEST;
+(NSString *)getFTSCORE;
+(NSString *)getBTSCORE;
+(NSString *)getFIGURESCOREREQUEST;
+(NSString *)getBTFIGURESCOREREQUEST;
+ (NSString *)getAPPLEPAY_MID;

/**
 配置请求头
 */
+(void)configHTTPHeaders;


/**
 配置额外的固定参数
 */
+(void)configExtreParams;


/**
 配置签名key
 */
+(void)configSignKey;



/**
 清空用户信息相关配置
 */
+(void)clearUserInfo;


@end
