//
//  CCAppDelegate.m
//  CCLoginKit
//
//  Created by BoASir on 09/21/2018.
//  Copyright (c) 2018 BoASir. All rights reserved.
//

#import "CCAppDelegate.h"
#import "CSNetWorkConfig.h"
#import "CCLoginVC.h"
#import "CCViewController.h"
#import "CCLoginPrefix.h"
@implementation CCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    //显示窗口
    [self.window makeKeyAndVisible];
    
    
    [[CC_UIHelper getInstance]initUIDemoWidth:375 andHeight:750];
    
    NSString *absoluteFilePath = [[NSBundle mainBundle] pathForResource:@"CCLoginKit/Classes/stylesheet" ofType:@"cas"];
    //    NSString *absoluteFilePath=CASAbsoluteFilePath(@"stylesheet.cas");
    [CC_ClassyExtend initSheet:absoluteFilePath];
    [CC_ClassyExtend parseCas];
    
    [CSNetWorkConfig configHTTPHeaders];
    [CCLoginConfig shareInstance].headUrl = [CSNetWorkConfig currentUrl];
    
    [self addNotifications];
    
    [self enterMainTabFromRegister:NO];
    [[UserStateManager shareInstance] presentLoginVC];
    return YES;
}
#pragma mark - Notifications
-(void)addNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:CCLoginConfigDidLoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(halfOpenLoginSuccess) name:CCLoginConfigHalfOpenDidLoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOut) name:CCLoginConfigDidLogOut object:nil];
}

-(void)loginSuccess:(NSNotification *)notification{
    BOOL isFromRegist = [notification.userInfo[@"fromRegister"] boolValue];
    if (isFromRegist) {
        //来自注册成功的登录
        [CC_NoticeView showError:@"哦嚯，注册好还登陆成功了呢！"];
    }else{
        //单纯登录成功
        [self enterMainTabFromRegister:YES];
    }
}
-(void)halfOpenLoginSuccess{
    //半开放登陆成功
}
-(void)logOut{
    //登出成功
    
}
-(void)enterMainTabFromRegister:(BOOL)fromRegister{
    self.tabbarC = [[UITabBarController alloc]init];
    UIViewController *c1=[[UIViewController alloc]init];
    c1.view.backgroundColor=[UIColor greenColor];
    c1.tabBarItem.title=@"消息";
    c1.tabBarItem.image=[UIImage imageNamed:@"attention_selected_tab_icon"];
    c1.tabBarItem.badgeValue=@"123";
    
    CCViewController *c2=[[CCViewController alloc]init];
    c2.view.backgroundColor=[UIColor cyanColor];
    c2.tabBarItem.title=@"联系人";
    c2.tabBarItem.image=[UIImage imageNamed:@"bazaar_selected_tab_icon"];
    
    _tabbarC.viewControllers=@[c1,c2];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_tabbarC];
    nav.navigationBarHidden=YES;
    self.window.rootViewController = nav;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
