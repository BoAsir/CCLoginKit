//
//  AppCodeLib.m
//  JCZJ
//
//  Created by apple on 17/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_CodeLib.h"

@implementation CC_CodeLib

+ (UINavigationController *)getRootNav{
   // return (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    /* keywindow会出现bug,参考:
     https://stackoverflow.com/questions/21698482/diffrence-between-uiapplication-sharedapplication-delegate-window-and-u/42996156#42996156
     http://www.jianshu.com/p/ae84cd31d8f0
     */
    
    if ([[UIApplication sharedApplication].delegate.window.rootViewController isKindOfClass:[UINavigationController class]])
    {
        return (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    }
    else if ([[UIApplication sharedApplication].delegate.window.rootViewController isKindOfClass:[UITabBarController class]])
    {
        UIViewController *selectVc = [((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController) selectedViewController];
        if ([selectVc isKindOfClass:[UINavigationController class]])
        {
            return (UINavigationController *)selectVc;
        }
    }
    
    return nil;
}

+ (UIViewController *)viewControllerForView:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (void)showStateBar{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}
+ (void)hiddenStateBar{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

+ (UIDeviceOrientation)getOritation{
    UIDeviceOrientation ori=[UIDevice currentDevice].orientation;
    return ori;
}

+(UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb{
    
    if (!image) {
        return image;
    }
    if (kb<1) {
        return image;
    }
    
    kb*=1024;
    
    
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > kb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
//    BBLOG(@"当前大小:%fkb",(float)[imageData length]/1024.0f);
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}


-(UIWindow *)lastWindow
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            window.hidden = NO;
        return window;
    }
    
    return [UIApplication sharedApplication].keyWindow;
}

@end
