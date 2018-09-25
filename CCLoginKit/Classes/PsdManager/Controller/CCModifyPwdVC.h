//
//  CCModifyPwdVC.h
//  CCTribe
//
//  Created by lidaoyuan on 2018/7/16.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, CCModifyPwdVCType) {
    CCModifyLoginPwdType = 0,  // 修改登录密码
    CCModifypayPwdType,   // 修改支付密码
};


@interface CCModifyPwdVC : BaseViewController

-(instancetype)initWithType:(CCModifyPwdVCType)VCType;

@end
