//
//  CCPhoneNOAndVerifyCodeVC+Register.m
//  CCTribe
//
//  Created by lidaoyuan on 2018/7/16.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "CCPhoneNOAndVerifyCodeVC+Register.h"
#import "CC_Share.h"
@implementation CCPhoneNOAndVerifyCodeVC (Register)

-(CGFloat)addRegistProtocolUITopY:(CGFloat)Y{
    self.agreeRegistProtocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.agreeRegistProtocolButton.frame = CGRectMake( [ccui getRH:PhoneNOAndVerifyCodeVC_left_space], Y + [ccui getRH:5], [ccui getRH:40], [ccui getRH:40]);
    self.agreeRegistProtocolButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.agreeRegistProtocolButton setImage:[UIImage imageNamed:@"kk_regiest_agree_protocol" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
    [self.agreeRegistProtocolButton setImage:[UIImage imageNamed:@"kk_regiest_unagree_protocol" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [self.agreeRegistProtocolButton addTarget:self action:@selector(agreeRegistProtocolButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.agreeRegistProtocolButton.selected = YES;
    [self.view addSubview:self.agreeRegistProtocolButton];
    
    
    self.registProtocolLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.agreeRegistProtocolButton.right, self.agreeRegistProtocolButton.top, 200,self.agreeRegistProtocolButton.height)];
    self.registProtocolLabel.textAlignment = NSTextAlignmentLeft;
    self.registProtocolLabel.font = [ccui getRFS:13];
    
    NSMutableAttributedString *protocolAttributeStr = [[NSMutableAttributedString alloc]initWithString:@"我已阅读并同意" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x999999),NSFontAttributeName:[UIFont systemFontOfSize:10]}];
    
    [protocolAttributeStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"《用户注册协议》" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x4979f3),NSFontAttributeName:[UIFont systemFontOfSize:10]} ]];
    [self.registProtocolLabel setAttributedText:protocolAttributeStr];
    [self.view addSubview:self.registProtocolLabel];
    
    self.registProtocolLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToLookRegisterProtocol:)];
    [self.registProtocolLabel addGestureRecognizer:tap];
    
    return self.agreeRegistProtocolButton.bottom;
}

-(void)agreeRegistProtocolButtonClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}

-(void)goToLookRegisterProtocol:(UITapGestureRecognizer *)tap{
    
}



@end
