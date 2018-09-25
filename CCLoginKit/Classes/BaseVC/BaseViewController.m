//
//  BaseViewController.m
//  HHSLive
//
//  Created by mac on 2017/3/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "NavBarView.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)setSelfViewDBName:(NSString *)selfViewDBName
{
    _selfViewDBName = selfViewDBName;
    
    if (self.fromStr) {
        [KKEventPointMgr shareInstance].from = self.fromStr;
    }else
    {
        [[KKEventPointMgr shareInstance] changeFromStrWith:[KKEventPointMgr shareInstance].to index:0];
    }

    if ([KKEventPointMgr shareInstance].from.length<=0) {
        [[KKEventPointMgr shareInstance] changeFromStrWith:selfViewDBName index:0];
    }
       
    [KKEventPointMgr shareInstance].to = selfViewDBName;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:[self getStatusBarStyle]];
  //  [self setNeedsStatusBarAppearanceUpdate];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = COLOR_BOTTOM;
    self.navigationController.navigationBar.hidden = YES;
  
    ///网络错误
    _connectErrorReminder = [[NoContentReminderView alloc]initWithFrame:self.view.bounds withNoContentStyle:NoContentReminderConnectError];
    [self.view addSubview:_connectErrorReminder];
    _connectErrorReminder.hidden = YES;
    
    
    _insideLoadingView = [InsideLoadingVIew loadingStartAnimatingAndAddToView:self.view];///<页面内加载中
    _insideLoadingView.hidden = YES;
}





-(UIStatusBarStyle)getStatusBarStyle
{
    if (self.UD_navigationBarView) {
        BBNavBarType barType = [self getUdNavBarType];
        switch (barType) {
            case BBNavBarTypeRed:
                return UIStatusBarStyleLightContent;
                break;
            case BBNavBarTypeWhite:
            case BBNavBarTypeGray:
            case BBNavBarTypeClear:
                return  UIStatusBarStyleDefault;
                break;
            default:
                return UIStatusBarStyleLightContent;
                break;
        }
        
    }
    return UIStatusBarStyleLightContent;
}




// plist 中 View controller-based status bar appearance 为NO的时候. 状态栏的显隐以[[UIApplication sharedApplication] setStatusBar 为准.
//View controller-based status bar appearance 为YES的时候, 由控制器控制.
//-(BOOL)prefersStatusBarHidden
//{
//    return [[UIApplication sharedApplication] isStatusBarHidden];
//}


//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    if (self.UD_navigationBarView ) {
//        BBNavBarType barType = [self getUdNavBarType];
//        switch (barType) {
//            case BBNavBarTypeRed:
//                return UIStatusBarStyleLightContent;
//                break;
//            case BBNavBarTypeWhite:
//               return  UIStatusBarStyleDefault;
//                break;
//
//            default:
//                return UIStatusBarStyleLightContent;
//                break;
//        }
//
//    }
//    return UIStatusBarStyleLightContent;
//}


-(void)pressBackButton
{
    [[KKEventPointMgr shareInstance] changeFromStrWith:[KKEventPointMgr shareInstance].to index:0];
    [[KKEventPointMgr shareInstance] changeFromStrWith:@"navigation" index:1];
    [[KKEventPointMgr shareInstance] changeFromStrWith:@"return" index:2];
    
    if(self.navigationController.viewControllers.count>1){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [KKEventPointMgr shareInstance].to = self.selfViewDBName;
}
@end
