//
//  CCLoginVC.h
//  CCTribe
//
//  Created by lidaoyuan on 2018/7/11.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//


#import "BaseViewController.h"
typedef void (^HHSLoginSuccess)(NSDictionary *loginInfo);


@interface CCLoginVC : BaseViewController

-(void)loginrequestCell:(NSString *)cell andPwd:(NSString*)pwd fromRegister:(BOOL)fromRegister;

@property (nonatomic,copy) HHSLoginSuccess userloginSuccessBlock;

@end
