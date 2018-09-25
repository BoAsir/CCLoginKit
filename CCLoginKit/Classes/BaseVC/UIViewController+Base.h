//
//  UIViewController+Base.h
//  HHSLive
//
//  Created by 郦道元  on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavBarView.h"


@interface UIViewController (Base)


@property(nonatomic,strong)NavBarView *UD_navigationBarView;

/**
 设置使用自定义navigation bar    红底白字
 */
-(void)setUserDefinedNavigationBar;


/**
 设置使用自定义navigation bar   白底黑字
 */
-(void)setUserDefinedNavigationBarWhite;

/**
 设置使用自定义navigation bar   透明无标题
 */
-(void)setUserDefinedNavigationBarClear;


/**
 设置使用自定义navigation bar   灰底,黑字
 */
-(void)setUserDefinedNavigationBarGray;


/**
 设置使用自定义navigationBar

 @param barType 类型
 */
-(void)setUserDefinedNavigationBarWithType:(BBNavBarType)barType;




/**
 自定义navigationBar 的 title

 @return t
 */
-(NSString *)udNavBarTitle;


/**
 设置自定义navigation bar 的标题

 @param title 标题
 */
-(void)setUdNavBarTitle:(NSString *)title;


/**
 自定义导航栏的高度

 */
-(CGFloat)udNavBarHeight;

/**
 设置导航栏的背景图

 @param image 背景图
 */
-(void)setUdNavBarBackgroundImage:(UIImage *)image;


/**
 设置导航栏背景色,此方法会隐藏导航栏背景图

 @param color 颜色
 */
-(void)setUdNavBarBackgroundColor:(UIColor *)color;

/**
 设置导航栏title的颜色

 @param color 颜色
 */
-(void)setUdNavBarTitleColor:(UIColor *)color;

/**
 设置导航栏title的字体大小
 
 @param font 字体大小
 */
-(void)setUdNavBarTitleFont:(UIFont *)font;

/**
 获取导航栏类型
 */
-(BBNavBarType)getUdNavBarType;


/**
 隐藏默认的返回按钮
 */
-(void)hiddenBackButton;

/**
 *  添加展示内容view 不包含头部导航栏区域
 */
-(UIView *)setUdDisplayView;

@end

