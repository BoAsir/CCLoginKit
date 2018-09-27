//
//  UIViewController+Base.m
//  HHSLive
//
//  Created by 郦道元  on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIViewController+Base.h"
#import <objc/runtime.h>
#import "UIImage+RTTint.h"
#import "CC_Button.h"
static const char  user_defined_base_navigationbar_view_key;


@implementation UIViewController (Base)

@dynamic UD_navigationBarView;


-(void)setUserDefinedNavigationBar
{
    [self setUserDefinedNavigationBarWithType:BBNavBarTypeRed];
}
-(void)setUserDefinedNavigationBarWhite
{
    [self setUserDefinedNavigationBarWithType:BBNavBarTypeWhite];
}
-(void)setUserDefinedNavigationBarClear{
    [self setUserDefinedNavigationBarWithType:BBNavBarTypeClear];
}
-(void)setUserDefinedNavigationBarGray
{
    [self setUserDefinedNavigationBarWithType:BBNavBarTypeGray];
}


-(void)setUserDefinedNavigationBarWithType:(BBNavBarType)barType
{
    self.navigationController.navigationBarHidden = YES;
    NavBarView *udNavBarView = [[NavBarView alloc]init];
    __weak typeof(self)weakSelf = self;

    BBLOG(@"%ld",self.navigationController.viewControllers.count);
    if (self.navigationController.viewControllers.count > 0) {

        udNavBarView.backButton.hidden = NO;
    }else{
        udNavBarView.backButton.hidden = YES;
    }
    [udNavBarView.backButton addTarget:self action:@selector(tagpped:) forControlEvents:UIControlEventTouchUpInside];
//    [udNavBarView.backButton addTappedBlock:^(UIButton *button) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        if ([strongSelf canPerformAction:@selector(pressBackButton) withSender:nil]) {
//            [strongSelf performSelector:@selector(pressBackButton)];
//
//        }else if(strongSelf.navigationController.viewControllers.count>1){
//            [strongSelf.navigationController popViewControllerAnimated:YES];
//        }else{
//            [strongSelf dismissViewControllerAnimated:YES completion:nil];
//        }
//    }];


    switch (barType) {
        case BBNavBarTypeRed:
            udNavBarView.barType = BBNavBarTypeRed;
            break;
        case BBNavBarTypeWhite:
        {
            udNavBarView.barType = BBNavBarTypeWhite;
            [udNavBarView setNavBarBackGroundColor:[UIColor whiteColor]];
            [udNavBarView setNavBarTitleColor:UIColorFromRGB(0x333333)];
            [udNavBarView.backButton setImage:[[UIImage imageNamed:@"gray_navBack_arrow_icon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil]rt_tintedImageWithColor:UIColorFromRGB(0x333333)] forState:UIControlStateNormal];
        }
            break;
        case BBNavBarTypeClear:
        {
            udNavBarView.barType = BBNavBarTypeClear;
            [udNavBarView setNavBarBackGroundColor:[UIColor clearColor]];
            [udNavBarView setNavBarTitleColor:UIColorFromRGB(0x333333)];

        }
             break;
        case BBNavBarTypeGray:
        {
            udNavBarView.barType = BBNavBarTypeGray;
            [udNavBarView setNavBarBackGroundColor:UIColorFromRGB(0xf2f2f2)];
            [udNavBarView setNavBarTitleColor:UIColorFromRGB(0x333333)];

        }
            break;
        default:
            break;
    }
    self.UD_navigationBarView = udNavBarView;
    [self.view addSubview:udNavBarView];
}

-(void)tagpped:(UIButton*)sender{
    if ([self canPerformAction:@selector(pressBackButton) withSender:nil]) {
        [self performSelector:@selector(pressBackButton)];
        
    }else if(self.navigationController.viewControllers.count>1){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(NavBarView *)UD_navigationBarView
{

    return objc_getAssociatedObject(self, &user_defined_base_navigationbar_view_key);
}

-(void)setUD_navigationBarView:(NavBarView *)UD_navigationBarView
{
    [self willChangeValueForKey:@"UD_navigationBarView"];
    objc_setAssociatedObject(self, &user_defined_base_navigationbar_view_key, UD_navigationBarView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"UD_navigationBarView"];
}



-(NSString *)udNavBarTitle
{
    return self.UD_navigationBarView.titleLabel.text;
}

-(void)setUdNavBarTitle:(NSString *)title
{
    self.UD_navigationBarView.titleLabel.text = title;
}

-(void)setUdNavBarBackgroundImage:(UIImage *)image
{
    self.UD_navigationBarView.navBarBackgroundImage = image;
}

-(void)setUdNavBarBackgroundColor:(UIColor *)color
{
    [self.UD_navigationBarView setNavBarBackGroundColor:color];;
}

-(void)setUdNavBarTitleColor:(UIColor *)color
{
    [self.UD_navigationBarView setNavBarTitleColor:color];;
}
-(void)setUdNavBarTitleFont:(UIFont *)font
{
    [self.UD_navigationBarView setNavBarTitleFont:font] ;
}
-(CGFloat)udNavBarHeight
{
    return self.UD_navigationBarView.frame.size.height;
}

-(UIView *)setUdDisplayView{
    CGRect rect=self.view.frame;
    rect.origin.y=self.udNavBarHeight;
    rect.size.height=rect.size.height-self.udNavBarHeight;
    UIView *v=[[UIView alloc]initWithFrame:rect];
    [self.view addSubview:v];
    return v;
}

-(BBNavBarType)getUdNavBarType
{
    return self.UD_navigationBarView.barType;
}


-(void)hiddenBackButton
{
    if (self.UD_navigationBarView) {
        self.UD_navigationBarView.backButton.hidden = YES;
    }
}

@end

