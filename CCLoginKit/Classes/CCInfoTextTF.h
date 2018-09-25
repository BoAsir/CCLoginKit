//
//  CCInfoTextTF.h
//  CCTribe
//
//  Created by lidaoyuan on 2018/7/13.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCInfoTextTF : UIView

@property (nonatomic,strong) UIImageView* iconImg;
@property (nonatomic,strong) UITextField* inputTextField;
@property(nonatomic,strong)UIView *rightView;
@property(nonatomic,strong)UIView *separateLine;

-(void)hiddenSeparateLine;

-(void)setupWithIcon:(NSString *)iconName placeholder:(NSString *)holderString;



@end
