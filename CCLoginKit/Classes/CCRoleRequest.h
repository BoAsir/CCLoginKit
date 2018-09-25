//
//  CCRoleRequest.h
//  CCTribe
//
//  Created by gwh on 2018/7/31.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCRoleRequest : NSObject

typedef NS_ENUM(NSUInteger, LoginType) {
    LoginTypeLogin = 0,  // 登录调
    LoginTypeCreate,   // 创建角色调
    LoginTypeSwitch,   // 切换角色调
};

/**
 *  保存登录信息
 */
+ (void)saveLoginInfo:(NSDictionary *)response;

/**
 *  请求登录接口
 */
+ (void)requestLoginSelectedLoginUserId:(NSString *)selectedLoginUserId resetDefaultUser:(BOOL)resetDefaultUser controller:(UIViewController *)controller type:(LoginType)type;

@end
