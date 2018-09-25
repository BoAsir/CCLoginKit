//
//  CCLoginPrefix.h
//  LoginTest
//
//  Created by 路飞 on 2018/9/21.
//  Copyright © 2018年 lufei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HHObjectCheck.h"
#import "CC_NoticeView.h"
#import "CC_Share.h"
#import "KKEventPointMgr.h"
#import "MaskProgressHUD.h"
#import "NSDictionary+BBAdd.h"
#import "NSMutableDictionary+BBAdd.h"
#import "CC_CodeLib.h"
#import "Masonry.h"
#import "BaseNavigationController.h"
#import "UserStateManager.h"
#import "AFNetworking.h"
#import "CCLoginConfig.h"

#define UIFT(f) [UIFont systemFontOfSize:f]

#define HERMIT_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HERMIT_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define HERMIT_RGBCOLOR [UIColor colorWithRed:244/255.0f green:244/255.0f blue:244/255.0f alpha:1]
#define UNIT_WIDTH ([UIScreen mainScreen].bounds.size.width) / 320
/** 二进制颜色*/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0x00FF0000) >> 16)) / 255.0     \
green:((float)((rgbValue & 0x0000FF00) >>  8)) / 255.0     \
blue:((float)((rgbValue & 0x000000FF) >>  0)) / 255.0     \
alpha:1.0]

#define UIColorFromHexStr(hexStr) ({NSString *colorHexStr = [hexStr stringByReplacingOccurrencesOfString:@"#" withString:@"0x"]; unsigned colorHex = 0; [[NSScanner scannerWithString:colorHexStr] scanHexInt:&colorHex];UIColorFromRGB(colorHex);})

/** rgb颜色*/
#define RGBCOLOR [UIColor colorWithRed:244/255.0f green:244/255.0f blue:244/255.0f alpha:1]
#define COLOR_NAVBAR [UIColor colorWithRed:228/255.0f green:45/255.0f blue:39/255.0f alpha:1]
#define COLOR_TEXT [UIColor colorWithRed:25/255.0f green:25/255.0f blue:25/255.0f alpha:1]
#define COLOR_BOTTOM [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

/** 常用颜色 */
#define BLACK_TEXT_COLOR        RGBA(51,51,51,1.0)
#define DARK_GRAY_TEXT_COLOR    RGBA(102,102,102,1.0)
#define GRAY_TEXT_COLOR         RGBA(153,153,153,1.0)

/** 获取屏幕 宽度、高度*/
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//#define BBKEY_WINDOW [UIApplication sharedApplication].keyWindow
#define BBKEY_WINDOW [[[UIApplication sharedApplication] delegate] window]
//#define BBKEY_WINDOW [AppDelegate sharedApplication].window


#define MAXValue(A,B) ({__typeof(A) __a = (A);__typeof(B) __b = (B);__a > __b ? __a : __b;})
#define MINValue(A,B) ({__typeof(A) __a = (A);__typeof(B) __b = (B);__a > __b ? __b : __a;})


/** 获取系统版本*/
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
#define CurrentAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** 简写*/
#define UIF(f) [UIFont systemFontOfSize:f]
#define UIIMAGE(a) [UIImage imageNamed:a]
#define new(T)        [[T alloc] init]

// 判断iPhone
#define iPhone5 (MAX(SCREEN_WIDTH, SCREEN_HEIGHT) == 568)
#define iPhoneX (MAX(SCREEN_WIDTH, SCREEN_HEIGHT) >= 812)

// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

// 设备相关
#define GREATER_iPhone5_WIDTH             (MIN(SCREEN_WIDTH, SCREEN_HEIGHT) > 320)
#define GREATER_iPhone6_WIDTH           (MIN(SCREEN_WIDTH, SCREEN_HEIGHT) > 375)

// 导航栏高度
#define NAV_BAR_HEIGHT (44.f)
#define STATUS_AND_NAV_BAR_HEIGHT (STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)
#define STATUS_BAR_HEIGHT (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))

#define IGNORE_ERROR @"a"    // 回调的时候,忽略掉的错误提示

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf)  __strong __typeof(&*weakSelf)strongSelf = weakSelf;

#define weak(v) __weak typeof(v) weak_##v = v;
#define strong(v) __strong typeof(v) strong_##v = weak_##v;

#ifdef DEBUG
#   define CSLOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define CSLOG(...)
#endif

#ifdef DEBUG
#   define BBLOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define BBLOG(...)
#endif

NS_ASSUME_NONNULL_BEGIN

@interface CCLoginPrefix : NSObject

@end

NS_ASSUME_NONNULL_END
