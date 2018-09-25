//
//  CCTwoPwdTFVC.h
//  CCTribe
//
//  Created by lidaoyuan on 2018/7/16.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "BaseViewController.h"


typedef NS_ENUM(NSUInteger, CCTwoPwdTFVCType) {
    CCTwoPwdTFRegistVC = 0,  // 注册
    CCTwoPwdTFSetPayPwdVC = 1,   // 设置支付密码
    CCTwoPwdTFFindLoginPwdVC = 2,   // 找回登录密码
    CCTwoPwdTFFindPayPwdVC = 3,     // 找回支付密码
    CCUserRealNameVerifyVC=4 //实名认证
};

extern CGFloat TwoPwdTFVC_left_space;

/**
 带有两个textField,设置密码VC
 */
@interface CCTwoPwdTFVC : BaseViewController

-(instancetype)initWithType:(CCTwoPwdTFVCType)VCType;

@property(nonatomic,retain) NSString *smsIdString;
@property(nonatomic,retain) NSString *randomString;
@property(nonatomic,retain) NSString *verifyCellSign;
@property(nonatomic,retain) NSString *cell;


@end
