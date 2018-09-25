//
//  BBAccountAlertView.h
//  BananaBall
//
//  Created by 万耀辉 on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCAccountAlertViewDelegate <NSObject>


- (void)AccountAlertViewButtonClickPassValue:(UIButton *)button AccountAlertView:(UIView *)AccountAlertView;

@end

@interface CCAccountAlertView : UIView

@property (nonatomic, strong) UIView *destView;
@property (nonatomic, weak) id <CCAccountAlertViewDelegate> delegate;

-(id)initWithTitleString:(NSString *)titleString Second:(NSString *)secondString third:(NSString *)thirdString ButtonContent:(NSString *)buttString;
@end
