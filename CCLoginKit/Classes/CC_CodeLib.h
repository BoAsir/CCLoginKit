//
//  AppCodeLib.h
//  JCZJ
//
//  Created by apple on 17/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CC_CodeLib : NSObject

/** 获取根试图控制器*/
+ (UINavigationController *)getRootNav;

/** 获取上级控制器*/
+ (UIViewController *)viewControllerForView:(UIView *)view;

/** 显示状态栏*/
+ (void)showStateBar;

/** 隐藏状态栏*/
+ (void)hiddenStateBar;

/** 获取屏幕方向*/
+ (UIDeviceOrientation)getOritation;

/** 压缩图片到指定大小*/
+(UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;

/**
 *  获取最上层的window
 */
- (UIWindow *)lastWindow;

@end
