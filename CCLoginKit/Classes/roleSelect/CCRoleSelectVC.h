//
//  CCRoleSelectVC.h
//  CCLoginKit
//
//  Created by 路飞 on 2018/9/27.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, RoleEnterType) {
    RoleEnterLogin = 0,  // 登录进入
    RoleEnterSwitch,   // 切换角色进入
};

NS_ASSUME_NONNULL_BEGIN

@interface CCRoleSelectVC : BaseViewController

-(instancetype)initWithType:(RoleEnterType)VCType;

@end

NS_ASSUME_NONNULL_END
