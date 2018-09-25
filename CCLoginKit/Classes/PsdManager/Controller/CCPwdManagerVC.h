//
//  CCPwdManagerVC.h
//  CCTribe
//
//  Created by lidaoyuan on 2018/7/17.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, CCPwdManagerVCType) {
    CCPwdManagerVCType_LoginPwd,//登录密码
    CCPwdManagerVCType_PayPwd//支付密码
};

@interface CCPwdManagerVC : BaseViewController

@property(nonatomic,assign)BOOL hasSetPayPwd;

-(instancetype)initWithType:(CCPwdManagerVCType)VCType;

@end
