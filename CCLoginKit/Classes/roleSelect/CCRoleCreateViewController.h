//
//  CCRoleCreateViewController.h
//  CCTribe
//
//  Created by gwh on 2018/7/30.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CCInfoTextTF.h"

typedef NS_ENUM(NSUInteger, CreateEnterType) {
    CreateEnterLogin = 0,  // 注册进入
    CreateEnterSwitch,   // 切换角色进入
};

@interface CCRoleCreateViewController : BaseViewController
@property(nonatomic,copy) NSString* VCType;
@property(nonatomic,assign) CreateEnterType type;

@end
