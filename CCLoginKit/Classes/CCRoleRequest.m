//
//  CCRoleRequest.m
//  CCTribe
//
//  Created by gwh on 2018/7/31.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "CCRoleRequest.h"
#import "CCUserInfoRequest.h"

@implementation CCRoleRequest

+ (void)saveLoginInfo:(NSDictionary *)response{
    [ccs saveDefaultKey:@"user_loginKey" andV:response[@"userPlatformLogin"][@"loginKey"]];
    [ccs saveDefaultKey:@"user_signKey" andV:response[@"userPlatformLogin"][@"signKey"]];
    [ccs saveDefaultKey:@"user_cryptKey" andV:response[@"userPlatformLogin"][@"cryptKey"]];
    [ccs saveDefaultKey:@"authedUserId" andV:response[@"userPlatformLogin"][@"userId"]];
    [ccs saveDefaultKey:@"loginName" andV:response[@"loginUserInfo"][@"loginName"]];
    
    [ccs saveDefaultKey:@"loginUserAvatarUrl" andV:response[@"loginUserInfo"][@"userLogoUrl"]];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [UserStateManager shareInstance].user_loginKey=response[@"userPlatformLogin"][@"loginKey"];
    [UserStateManager shareInstance].user_signKey=response[@"userPlatformLogin"][@"signKey"];
    [UserStateManager shareInstance].user_cryptKey=response[@"userPlatformLogin"][@"cryptKey"];
    [UserStateManager shareInstance].authedUserId=response[@"userPlatformLogin"][@"userId"];
    [UserStateManager shareInstance].loginName=response[@"loginUserInfo"][@"loginName"];
    [UserStateManager shareInstance].loginUserAvatarUrl = response[@"loginUserInfo"][@"userLogoUrl"];
    
    NSMutableDictionary *mutDic=[[NSMutableDictionary alloc]initWithDictionary:[CC_HttpTask getInstance].extreDic];
    [mutDic setObject:response[@"userPlatformLogin"][@"userId"] forKey:@"authedUserId"];
    [mutDic setObject:response[@"userPlatformLogin"][@"loginKey"] forKey:@"loginKey"];
    [[CC_HttpTask getInstance]setSignKeyStr:response[@"userPlatformLogin"][@"signKey"]];
    [[CC_HttpTask getInstance]setExtreDic:mutDic];
    
    //查询用户一些信息
    [CCUserInfoRequest requestUserInfo];
}

+ (void)requestLoginSelectedLoginUserId:(NSString *)selectedLoginUserId resetDefaultUser:(BOOL)resetDefaultUser controller:(UIViewController *)controller type:(LoginType)type{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    [para setObject:@"SELECT_USER_AUTH_LOGIN" forKey:@"service"];
    
    [para setObject:@"login_login_unselectlogin_null_null_null" forKey:@"from"];
    [para setObject:@"findrecommend" forKey:@"to"];
    [para setObject:selectedLoginUserId forKey:@"selectedLoginUserId"];
    [para setObject:@(resetDefaultUser) forKey:@"resetDefaultUser"];
    MaskProgressHUD *HUD = [MaskProgressHUD hudStartAnimatingAndAddToView:controller.view];
    [[CC_HttpTask getInstance]post:[CCLoginConfig loginHeadUrl] params:para model:nil finishCallbackBlock:^(NSString *error, ResModel *resmodel) {
        [HUD stop];
        if (error) {
            [CC_NoticeView showError:error];
        }else{
            [self saveLoginInfo:resmodel.resultDic[@"response"]];
            [[CC_CodeLib getRootNav] dismissViewControllerAnimated:YES completion:^{
                if (type==LoginTypeLogin) {
                    [CC_NoticeView showError:@"登录成功"];
                }else if (type==LoginTypeCreate){
                    [CC_NoticeView showError:@"登录成功"];
                }else{
                    [CC_NoticeView showError:@"切换成功"];
                }
                //登陆成功
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CCLoginConfigDidLoginSuccess" object:nil userInfo:@{@"fromRegister":@(NO)}];
            }];
        }
    }];
}

@end
