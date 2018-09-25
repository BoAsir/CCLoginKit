//
//  CCViewController.m
//  CCLoginKit
//
//  Created by BoASir on 09/21/2018.
//  Copyright (c) 2018 BoASir. All rights reserved.
//

#import "CCViewController.h"

@interface CCViewController ()

@end

@implementation CCViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initViews];
}

-(void)initViews{
    CC_Button* logOutBtn = [[CC_Button alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    logOutBtn.center = self.view.center;
    logOutBtn.backgroundColor = [UIColor redColor];
    [logOutBtn setTitle:@"登出" forState:UIControlStateNormal];
    [self.view addSubview:logOutBtn];
    [logOutBtn addTappedBlock:^(UIButton *button) {
        //点击登出按钮
        [[UserStateManager shareInstance] logoutAndSetNil];
        [[UserStateManager shareInstance]presentLoginVC];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
