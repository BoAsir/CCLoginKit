//
//  CCRoleSelectViewController.h
//  CCTribe
//
//  Created by yaya on 2018/7/25.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, RoleEnterType) {
    RoleEnterLogin = 0,  // 登录进入
    RoleEnterSwitch,   // 切换角色进入
};

@interface CCRoleSelectViewController : BaseViewController

-(instancetype)initWithType:(RoleEnterType)VCType;

@end
