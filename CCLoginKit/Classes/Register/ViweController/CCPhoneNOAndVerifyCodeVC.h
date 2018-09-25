//
//  CCPhoneNOAndVerifyCodeVC.h
//  CCTribe
//
//  Created by lidaoyuan on 2018/7/16.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//


#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, CCPhoneNOAndVerifyCodeVCType) {
    CCPhoneNOAndVerifyCodeRegisterVC = 0,  // 注册
    CCPhoneNOAndVerifyCodeFindLoginPwdVC = 1, // 找回登录密码
    CCPhoneNOAndVerifyCodeFindPayPwdVC = 2   //找回支付密码
};

extern CGFloat PhoneNOAndVerifyCodeVC_left_space;


/**
 带有手机号和验证码的VC
 */ 
@interface CCPhoneNOAndVerifyCodeVC : BaseViewController

@property(nonatomic,strong)UIButton *agreeRegistProtocolButton;
@property(nonatomic,strong)UILabel *registProtocolLabel;

-(instancetype)initWithType:(CCPhoneNOAndVerifyCodeVCType)VCType;

@end
