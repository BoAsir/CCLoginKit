//
//  UserStateManager.h
//  HHSLive
//
//  Created by apple on 2017/3/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CC_HttpTask;
@interface UserStateManager : NSObject

@property (nonatomic,retain) NSString *accountType;///>用户的账号类型
@property (nonatomic,retain) NSString *identifier;///>用户名
@property (nonatomic,retain) NSString *userSig;///>鉴权Token
@property (nonatomic,retain) NSString *appidAt3rd;///>App用户使用OAuth授权体系分配的Appid
@property (nonatomic,assign) int sdkAppId;//用户标识接入SDK的应用ID


@property (nonatomic,retain) NSMutableArray *keysMutArr;
/** 用户信息*/
    ///<oneAuthKey
@property (nonatomic,retain) NSString *oneAuth_loginKey;
@property (nonatomic,retain) NSString *oneAuth_signKey;
@property (nonatomic,retain) NSString *oneAuth_cryptKey;
    ///<UserKey
@property (nonatomic,retain) NSString *user_loginKey;
@property (nonatomic,retain) NSString *user_signKey;
@property (nonatomic,retain) NSString *user_cryptKey;

@property (nonatomic,retain) NSString *authedUserId;
@property (nonatomic,retain) NSString *oneAuthId;

@property (nonatomic,retain) CC_HttpTask *authTask;

@property (nonatomic,retain) NSString *uuid;
@property (nonatomic,retain) NSString *loginName;
@property (nonatomic,retain) NSString *loginUserAvatarUrl;

@property(nonatomic,assign) BOOL hasInitPayPassword;

/**
 *  userInfoClient
 */
@property(nonatomic,assign) BOOL accountPasswordSet;
@property(nonatomic,assign) BOOL canLogin;
@property(nonatomic,retain) NSString *cell;
@property(nonatomic,assign) BOOL cellValidate;
@property(nonatomic,assign) BOOL emailValidate;
//@property(nonatomic,retain) NSString *loginName;
@property(nonatomic,assign) BOOL loginPasswordSet;
@property(nonatomic,retain) NSString *nickName;
@property(nonatomic,assign) BOOL qqValidate;
@property(nonatomic,retain) NSString *realName;
@property(nonatomic,retain) NSString *userId;

+ (BOOL)isLogIn;


+ (instancetype)shareInstance;
- (void)remove;

- (void)logoutAndSetNil;

- (void)setAuthSignKey;

- (void)setUserSignKey;

#pragma mark- 管理自己的登录

/** Im的*/
/** 腾讯视频的刷新登录 针对im 登录im*/
- (void)getSignForIm;

/**
 *  登录
 */
- (void)presentLoginVC;

@end
