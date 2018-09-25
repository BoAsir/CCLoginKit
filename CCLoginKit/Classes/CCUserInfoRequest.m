//
//  CCUserInfoRequest.m
//  CCTribe
//
//  Created by gwh on 2018/8/1.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "CCUserInfoRequest.h"
#import "UserStateManager.h"
#import "NSDictionary+BBAdd.h"
#import "NSMutableDictionary+BBAdd.h"
#import "CC_GHttpSessionTask.h"
#import "CCLoginConfig.h"
#import "CCMacros.h"
#import "CC_Share.h"
#import "CC_NoticeView.h"
@implementation CCUserInfoRequest

+ (void)requestUserInfo{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    [para setObject:@"MY_USER_INFO_QUERY" forKey:@"service"];
    [para safe_setObject:[UserStateManager shareInstance].authedUserId forKey:@"authedUserId"];
//    [para safe_setObject:[UserStateManager shareInstance].user_signKey forKey:@"sign"];
    [[CC_HttpTask getInstance]post:[CCLoginConfig loginHeadUrl] params:para model:nil finishCallbackBlock:^(NSString *error, ResModel *resmodel) {
        if (error) {
            [CC_NoticeView showError:error];
        }else{
            NSDictionary *userInfoClient=resmodel.resultDic[@"response"][@"userInfoClient"];
            [UserStateManager shareInstance].accountPasswordSet=userInfoClient[@"accountPasswordSet"];
            [UserStateManager shareInstance].canLogin=userInfoClient[@"canLogin"];
            [UserStateManager shareInstance].cell=ccstr(@"%@",userInfoClient[@"cell"]);
            [UserStateManager shareInstance].cellValidate=userInfoClient[@"cellValidate"];
            [UserStateManager shareInstance].emailValidate=userInfoClient[@"emailValidate"];
            [UserStateManager shareInstance].loginName=ccstr(@"%@",userInfoClient[@"loginName"]);
            [UserStateManager shareInstance].loginPasswordSet=userInfoClient[@"loginPasswordSet"];
            [UserStateManager shareInstance].nickName=ccstr(@"%@",userInfoClient[@"nickName"]);
            [UserStateManager shareInstance].qqValidate=userInfoClient[@"qqValidate"];
            [UserStateManager shareInstance].realName=ccstr(@"%@",userInfoClient[@"realName"]);
            [UserStateManager shareInstance].userId=ccstr(@"%@",userInfoClient[@"userId"]);
        }
    }];
}

@end
