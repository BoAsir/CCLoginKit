//
//  CCRoleCreateVC.h
//  CCLoginKit
//
//  Created by 路飞 on 2018/9/27.
//

#import "BaseViewController.h"
#import "CCInfoTextTF.h"

typedef NS_ENUM(NSUInteger, CreateEnterType) {
    CreateEnterLogin = 0,  // 注册进入
    CreateEnterSwitch,   // 切换角色进入
};

NS_ASSUME_NONNULL_BEGIN

@interface CCRoleCreateVC : BaseViewController

@property(nonatomic,copy) NSString* VCType;
@property(nonatomic,assign) CreateEnterType type;

@end

NS_ASSUME_NONNULL_END
