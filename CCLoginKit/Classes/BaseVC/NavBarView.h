//
//  NavBarView.h
//  HHSLive
//
//  Created by apple on 17/3/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Share.h"
typedef NS_ENUM(NSUInteger, BBNavBarType) {
    BBNavBarTypeRed,           // 红色背景 白色标题
    BBNavBarTypeWhite,         //白色背景  黑色标题
    BBNavBarTypeClear,         //透明背景  无标题
    BBNavBarTypeGray           // 灰色背景f2f2f2, 黑色标题
};


@interface NavBarView : UIView{

}

@property (nonatomic, strong) CC_Button *backButton;
@property (nonatomic,strong) UILabel  *titleLabel;
@property(nonatomic,strong)UIImage *navBarBackgroundImage;
@property(nonatomic,strong) UIImageView *navBarImageView;
@property(nonatomic,assign) BBNavBarType barType;

-(void)hiddenBackButton;

/**
 设置背景颜色
 */
-(void)setNavBarBackGroundColor:(UIColor *)color;

/**
 设置标题颜色
 */
-(void)setNavBarTitleColor:(UIColor *)color;

/**
 设置标题字体大小
 */
-(void)setNavBarTitleFont:(UIFont *)font;

@end

