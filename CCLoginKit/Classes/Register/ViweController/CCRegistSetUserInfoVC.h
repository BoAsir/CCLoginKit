//
//  CCRegistSetUserInfoVC.h
//  CCTribe
//
//  Created by lidaoyuan on 2018/7/16.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "BaseViewController.h"

/**
 注册流程,设置基本用户信息
 */
@interface CCRegistSetUserInfoVC : BaseViewController

@property(nonatomic,retain) NSString *smsIdString;
@property(nonatomic,retain) NSString *randomString;
@property(nonatomic,retain) NSString *verifyCellSign;
@property(nonatomic,retain) NSString *cell;
@property(nonatomic,retain) NSString *password;


@end
