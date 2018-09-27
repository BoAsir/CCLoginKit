//
//  UserStateManager.m
//  HHSLive
//
//  Created by apple on 2017/3/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserStateManager.h"
#import "JKEncrypt.h"
#import "CCLoginVC.h"
#import "CC_CodeLib.h"
#import "CCLoginConfig.h"
#import "CC_Share.h"

@interface UserStateManager(){
    
}

@end
@implementation UserStateManager

static UserStateManager *userManager = nil;
static dispatch_once_t onceToken;

+ (instancetype)shareInstance
{
    dispatch_once(&onceToken, ^{
        userManager = [[UserStateManager alloc] init];
    });
    return userManager;
}

- (void)remove{
    userManager=nil;
    onceToken=0;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setUpInfo];
    }
    return self;
}
- (void)setAuthSignKey{
    if (!self.authTask) {
        self.authTask=[[CC_HttpTask alloc]init];
    }
    //设置请求头
    NSMutableDictionary *headers = [[NSMutableDictionary alloc]init];
    [headers setObject:[CCLoginConfig shareInstance].appName forKey:@"appName"];
    [headers setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"appVersion"];
    [headers setObject:[NSString stringWithFormat:@"IOS_VERSION%fSCREEN_HEIGHT%d",IOS_VERSION,(int)SCREEN_HEIGHT] forKey:@"appUserAgent"];
    
    [self.authTask setRequestHTTPHeaderFieldDic:headers];
    
    [self.authTask addResponseLogic:@"SIGN_REQUIRED" logicStr:@"response,error,name=SIGN_REQUIRED" stop:0 popOnce:1 logicBlock:^(NSDictionary *resultDic) {
//        [[AppDelegate sharedAppDelegate]enterMainTabFromRegister:NO];
        //登陆成功
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CCLoginConfigDidLoginSuccess" object:nil userInfo:@{@"fromRegister":@(NO)}];
        [[UserStateManager shareInstance]presentLoginVC];
    }];
    
    NSMutableDictionary *mutDic=[[NSMutableDictionary alloc]initWithDictionary:[CC_HttpTask getInstance].extreDic];
    if ([UserStateManager shareInstance].oneAuthId) {
        
        [mutDic setObject:[UserStateManager shareInstance].oneAuthId forKey:@"oneAuthId"];
    }
    if ([UserStateManager shareInstance].oneAuth_loginKey) {
        
        [mutDic setObject:[UserStateManager shareInstance].oneAuth_loginKey forKey:@"loginKey"];
    }
    
    [self.authTask setSignKeyStr:[UserStateManager shareInstance].oneAuth_signKey];
    [self.authTask setExtreDic:mutDic];
}

- (void)setUserSignKey{
    NSMutableDictionary *mutDic=[[NSMutableDictionary alloc]initWithDictionary:[CC_HttpTask getInstance].extreDic];
    [mutDic setObject:[UserStateManager shareInstance].authedUserId forKey:@"authedUserId"];
    [mutDic setObject:[UserStateManager shareInstance].user_loginKey forKey:@"loginKey"];
    
    [[CC_HttpTask getInstance]setSignKeyStr:[UserStateManager shareInstance].user_signKey];
    [[CC_HttpTask getInstance]setExtreDic:mutDic];
}

- (void)presentLoginVC{
    [[UserStateManager shareInstance]setAuthSignKey];
    if ([UserStateManager shareInstance].authedUserId) {
        return;
    }
    CCLoginVC *loginVC = [[CCLoginVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    nav.navigationBarHidden=YES;
    [[CC_CodeLib getRootNav]presentViewController:nav animated:YES completion:nil];
}

+ (BOOL)isLogIn{
    if ([UserStateManager shareInstance].authedUserId) {
        return YES;
    }
    return NO;
}

- (void)setUpInfo{
    self.keysMutArr=[[NSMutableArray alloc]init];
    {
        NSString *name=@"USER_uuid";
        if ([ccs getDefault:name]) {
            self.uuid=[ccs getDefault:name];
        }else{
            NSString *uuidS = [NSUUID UUID].UUIDString;
            [ccs saveDefaultKey:name andV:uuidS];
            self.uuid=uuidS;
        }
        [self.keysMutArr addObject:name];
    }
    {
        NSString *name=@"authedUserId";
        self.authedUserId=[ccs getDefault:name];
        [self.keysMutArr addObject:name];
    }
    {
        NSString *name=@"loginName";
        self.loginName=[ccs getDefault:name];
        [self.keysMutArr addObject:name];
    }
    {
        NSString *name=@"oneAuthId";
        self.oneAuthId=[ccs getDefault:name];
        [self.keysMutArr addObject:name];
    }
    {
        NSString *name=@"user_loginKey";
        self.user_loginKey=[ccs getDefault:name];
        [self.keysMutArr addObject:name];
    }
    {
        NSString *name=@"user_signKey";
        self.user_signKey=[ccs getDefault:name];
        [self.keysMutArr addObject:name];
    }
    {
        NSString *name=@"user_cryptKey";
        self.user_cryptKey=[ccs getDefault:name];
        [self.keysMutArr addObject:name];
    }
    {
        NSString *name=@"loginUserAvatarUrl";
        self.loginUserAvatarUrl = [ccs getDefault:name];
        [self.keysMutArr addObject:name];
    }
    {
        NSString *name=@"oneAuth_loginKey";
        self.oneAuth_loginKey=[ccs getDefault:name];
        [self.keysMutArr addObject:name];
    }
    {
        NSString *name=@"oneAuth_signKey";
        self.oneAuth_signKey=[ccs getDefault:name];
        [self.keysMutArr addObject:name];
    }
    {
        NSString *name=@"oneAuth_cryptKey";
        self.oneAuth_cryptKey=[ccs getDefault:name];
        [self.keysMutArr addObject:name];
    }
    {
        NSString *name=@"oneAuthId";
        self.oneAuthId=[ccs getDefault:name];
        [self.keysMutArr addObject:name];
    }
    
    if (self.authedUserId&&self.user_loginKey&&self.oneAuthId) {
        [[CC_HttpTask getInstance]setSignKeyStr:self.user_signKey];
        [[CC_HttpTask getInstance]setExtreDic:@{@"authedUserId":self.authedUserId,
                                      @"loginKey":self.user_loginKey,
                                      @"oneAuthId":self.oneAuthId
                                                }];
    }
}

-(void)logoutAndSetNil{
    for (int i=0; i<_keysMutArr.count; i++) {
        [ccs saveDefaultKey:_keysMutArr[i] andV:nil];
    }
    self.authedUserId = nil;
    self.sdkAppId = 0;
    [self remove];
    //登出
    [[NSNotificationCenter defaultCenter] postNotificationName:CCLoginConfigDidLogOut object:nil];
}

#pragma mark- 管理自己的登录
- (void)getSign{

}

- (void)getSignForIm{
    BOOL userlog=[UserStateManager isLogIn];
    
    if (userlog) {
//        [self signGet:^(NSDictionary *result) {

//            [[BBTXCloudSDKManager shareInstance] managerLoginSDK];
//        } andFail:^(NSDictionary *result) {
//            [[BBTXCloudSDKManager shareInstance] managerLoginSDK];
//        }];
    }else{
//        [self anonymousGet:^(NSDictionary *result) {
//            [[BBTXCloudSDKManager shareInstance] managerLoginSDK];
//
//        } andFail:^(NSDictionary *result) {
//            [[BBTXCloudSDKManager shareInstance] managerLoginSDK];
//        }];
    }
}

@end
