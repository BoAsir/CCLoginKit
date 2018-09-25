//
//  BaseNavigationController.m
//  HHSLive
//
//  Created by mac on 2017/3/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseNavigationController.h"
#import "CCLoginPrefix.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationBarHidden=YES;
}
-(BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIViewController *)childViewControllerForStatusBarStyle
{
    return self.visibleViewController;
}

-(UIViewController *)childViewControllerForStatusBarHidden
{
    return self.visibleViewController;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    BBLOG(@"%ld",self.viewControllers.count);
    if (self.viewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
